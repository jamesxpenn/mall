package com.chinasofti.mall.cart.service.impl;

import com.chinasofti.mall.cart.feign.ProductFeign;
import com.chinasofti.mall.common.dto.Cart;
import com.chinasofti.mall.common.dto.ProductDetail;
import com.chinasofti.mall.common.dto.Response;
import com.chinasofti.mall.common.enums.ResponseEnum;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.chinasofti.mall.cart.enums.ProductStatusEnum;
import com.chinasofti.mall.cart.form.CartAddForm;
import com.chinasofti.mall.cart.form.CartUpdateForm;
import com.chinasofti.mall.cart.service.ICartService;
import com.chinasofti.mall.cart.vo.CartProductVo;
import com.chinasofti.mall.cart.vo.CartVo;
import com.chinasofti.mall.cart.vo.ResponseVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by xuepeng@chinasofti
 */
@Service
public class CartServiceImpl implements ICartService {

	private final static String CART_REDIS_KEY_TEMPLATE = "cart_%d";

	private static final HttpClient httpClient = HttpClient.newBuilder()
			.version(HttpClient.Version.HTTP_2)
			.connectTimeout(Duration.ofSeconds(10))
			.build();

	@Autowired
	private ProductFeign productFeign;

	@Autowired
	private StringRedisTemplate redisTemplate;

	private Gson gson = new Gson();

	private static final String DAPR_HTTP_PORT = System.getenv().getOrDefault("DAPR_HTTP_PORT", "3500");


	@Override
	public ResponseVo<CartVo> add(Integer uid, CartAddForm form) throws IOException, InterruptedException {

		/**
		 * add dapr service invocation
		 */
		String dapr_url = "http://localhost:"+DAPR_HTTP_PORT+"/products/"+form.getProductId();

		HttpRequest request = HttpRequest.newBuilder().GET()
				.uri(URI.create(dapr_url))
				.header("dapr-app-id", "mallproduct")
				.build();
		HttpResponse<String> httpResponse = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

		ObjectMapper objectMapper = new ObjectMapper();
		Response<ProductDetail> response = objectMapper.readValue(httpResponse.body(), Response.class);
		ProductDetail product = objectMapper.convertValue(response.getData(), new TypeReference<ProductDetail>(){});
		Integer quantity = 1;

//		Response<ProductDetail> productvo = productFeign.getProduct(form.getProductId());
//		ProductDetail product=productvo.getData();

		//商品是否存在
		if (product == null) {
			return ResponseVo.error(ResponseEnum.PRODUCT_NOT_EXIST);
		}

		//商品是否正常在售
		if (!product.getStatus().equals(ProductStatusEnum.ON_SALE.getCode())) {
			return ResponseVo.error(ResponseEnum.PRODUCT_OFF_SALE_OR_DELETE);
		}

		//商品库存是否充足
		if (product.getStock() <= 0) {
			return ResponseVo.error(ResponseEnum.PROODUCT_STOCK_ERROR);
		}

		//写入到redis
		//key: cart_1
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = String.format(CART_REDIS_KEY_TEMPLATE, uid);

		Cart cart;
		String value = opsForHash.get(redisKey, String.valueOf(product.getId()));
		if (StringUtils.isEmpty(value)) {
			//没有该商品, 新增
			cart = new Cart(product.getId(), quantity, form.getSelected());
		}else {
			//已经有了，数量+1
			cart = gson.fromJson(value, Cart.class);
			cart.setQuantity(cart.getQuantity() + quantity);
		}

		opsForHash.put(redisKey,
				String.valueOf(product.getId()),
				gson.toJson(cart));

		return list(uid);
	}

	@Override
	public ResponseVo<CartVo> list(Integer uid) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = String.format(CART_REDIS_KEY_TEMPLATE, uid);
		Map<String, String> entries = opsForHash.entries(redisKey);

		boolean selectAll = true;
		Integer cartTotalQuantity = 0;
		BigDecimal cartTotalPrice = BigDecimal.ZERO;
		CartVo cartVo = new CartVo();
		List<CartProductVo> cartProductVoList = new ArrayList<>();
		for (Map.Entry<String, String> entry : entries.entrySet()) {
			Integer productId = Integer.valueOf(entry.getKey());
			Cart cart = gson.fromJson(entry.getValue(), Cart.class);

		//	Product product = productMapper.selectByPrimaryKey(productId);


			Response<ProductDetail> productvo = productFeign.getProduct(productId);

			ProductDetail product=productvo.getData();


			if (product != null) {
				CartProductVo cartProductVo = new CartProductVo(productId,
						cart.getQuantity(),
						product.getName(),
						product.getSubtitle(),
						product.getMainImage(),
						product.getPrice(),
						product.getStatus(),
						product.getPrice().multiply(BigDecimal.valueOf(cart.getQuantity())),
						product.getStock(),
						cart.getProductSelected()
				);
				cartProductVoList.add(cartProductVo);

				if (!cart.getProductSelected()) {
					selectAll = false;
				}

				//计算总价(只计算选中的)
				if (cart.getProductSelected()) {
					cartTotalPrice = cartTotalPrice.add(cartProductVo.getProductTotalPrice());
				}
			}

			cartTotalQuantity += cart.getQuantity();
		}

		//有一个没有选中，就不叫全选
		cartVo.setSelectedAll(selectAll);
		cartVo.setCartTotalQuantity(cartTotalQuantity);
		cartVo.setCartTotalPrice(cartTotalPrice);
		cartVo.setCartProductVoList(cartProductVoList);
		return ResponseVo.success(cartVo);
	}

	@Override
	public ResponseVo<CartVo> update(Integer uid, Integer productId, CartUpdateForm form) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = String.format(CART_REDIS_KEY_TEMPLATE, uid);

		String value = opsForHash.get(redisKey, String.valueOf(productId));
		if (StringUtils.isEmpty(value)) {
			//没有该商品, 报错
			return ResponseVo.error(ResponseEnum.CART_PRODUCT_NOT_EXIST);
		}

		//已经有了，修改内容
		Cart cart = gson.fromJson(value, Cart.class);
		if (form.getQuantity() != null
				&& form.getQuantity() >= 0) {
			cart.setQuantity(form.getQuantity());
		}
		if (form.getSelected() != null) {
			cart.setProductSelected(form.getSelected());
		}

		opsForHash.put(redisKey, String.valueOf(productId), gson.toJson(cart));
		return list(uid);
	}

	@Override
	public ResponseVo<CartVo> delete(Integer uid, Integer productId) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = String.format(CART_REDIS_KEY_TEMPLATE, uid);

		String value = opsForHash.get(redisKey, String.valueOf(productId));
		if (StringUtils.isEmpty(value)) {
			//没有该商品, 报错
			return ResponseVo.error(ResponseEnum.CART_PRODUCT_NOT_EXIST);
		}

		opsForHash.delete(redisKey, String.valueOf(productId));
		return list(uid);
	}

	@Override
	public Response deleteByUidAndProID(Integer uid, Integer productId) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = String.format(CART_REDIS_KEY_TEMPLATE, uid);

		String value = opsForHash.get(redisKey, String.valueOf(productId));
		if (StringUtils.isEmpty(value)) {
			//没有该商品, 报错
			return Response.error(ResponseEnum.CART_PRODUCT_NOT_EXIST);
		}
		opsForHash.delete(redisKey, String.valueOf(productId));
		return Response.success();
	}

	@Override
	public ResponseVo<CartVo> selectAll(Integer uid) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = String.format(CART_REDIS_KEY_TEMPLATE, uid);

		for (Cart cart : listForCart(uid)) {
			cart.setProductSelected(true);
			opsForHash.put(redisKey,
					String.valueOf(cart.getProductId()),
					gson.toJson(cart));
		}

		return list(uid);
	}

	@Override
	public ResponseVo<CartVo> unSelectAll(Integer uid) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = String.format(CART_REDIS_KEY_TEMPLATE, uid);

		for (Cart cart : listForCart(uid)) {
			cart.setProductSelected(false);
			opsForHash.put(redisKey,
					String.valueOf(cart.getProductId()),
					gson.toJson(cart));
		}

		return list(uid);
	}

	@Override
	public ResponseVo<Integer> sum(Integer uid) {
		Integer sum = listForCart(uid).stream()
				.map(Cart::getQuantity)
				.reduce(0, Integer::sum);
		return ResponseVo.success(sum);
	}

	public List<Cart> listForCart(Integer uid) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = String.format(CART_REDIS_KEY_TEMPLATE, uid);
		Map<String, String> entries = opsForHash.entries(redisKey);

		List<Cart> cartList = new ArrayList<>();
		for (Map.Entry<String, String> entry : entries.entrySet()) {
			cartList.add(gson.fromJson(entry.getValue(), Cart.class));
		}

		return cartList;
	}

}
