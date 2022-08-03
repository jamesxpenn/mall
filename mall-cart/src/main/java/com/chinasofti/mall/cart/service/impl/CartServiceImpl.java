package com.chinasofti.mall.cart.service.impl;

import com.chinasofti.mall.cart.feign.ProductFeign;
import com.chinasofti.mall.cart.utils.ConstantPropertiesUtil;
import com.chinasofti.mall.common.dto.Cart;
import com.chinasofti.mall.common.dto.ProductDetail;
import com.chinasofti.mall.common.dto.Response;
import com.chinasofti.mall.common.enums.ResponseEnum;
import com.fasterxml.jackson.core.JsonProcessingException;
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
import com.google.gson.reflect.TypeToken;
import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.IOException;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;
import java.util.stream.Collectors;

/**
 * Created by xuepeng@chinasofti
 */
@Service
public class CartServiceImpl implements ICartService {

	private final static String CART_REDIS_KEY_TEMPLATE = "cart_%d";

	private static final String DAPR_STATE_STORE = "statestore";

	private static final HttpClient httpClient = HttpClient.newBuilder()
			.version(HttpClient.Version.HTTP_2)
			.connectTimeout(Duration.ofSeconds(10))
			.build();

	private static final String DAPR_HTTP_PORT = System.getenv().getOrDefault("DAPR_HTTP_PORT", "3500");
	private static String DAPR_HOST = System.getenv().getOrDefault("DAPR_HOST", "http://localhost");
	@Autowired
	private ProductFeign productFeign;

	@Autowired
	private StringRedisTemplate redisTemplate;

	private Gson gson = new Gson();

	@Override
	public ResponseVo<CartVo> add(Integer uid, CartAddForm form) {
		URI baseUrl = null;
		try {
			baseUrl = new URI(DAPR_HOST+":"+DAPR_HTTP_PORT);
		} catch (URISyntaxException e) {
			throw new RuntimeException(e);
		}

		Integer quantity = 1;

		boolean hasProduct = false;

		/**
		 * add dapr service invocation
		 */
		String dapr_url = "http://localhost:"+DAPR_HTTP_PORT+"/products/"+form.getProductId();

		HttpRequest request = HttpRequest.newBuilder().GET()
				.uri(URI.create(dapr_url))
				.header("dapr-app-id", "mallproduct")
				.build();
		HttpResponse<String> httpResponse;
		try {
			 httpResponse = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
		} catch (IOException e) {
			throw new RuntimeException(e);
		} catch (InterruptedException e) {
			throw new RuntimeException(e);
		}
		ObjectMapper objectMapper = new ObjectMapper();
		Response<ProductDetail> response = null;
		try {
			response = objectMapper.readValue(httpResponse.body(), Response.class);
		} catch (JsonProcessingException e) {
			throw new RuntimeException(e);
		}
		ProductDetail product = objectMapper.convertValue(response.getData(), new TypeReference<ProductDetail>(){});

		//Response<ProductDetail> productvo = productFeign.getProduct(form.getProductId());
		//ProductDetail product=productvo.getData();

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
		String redisDapyKey  = String.format(CART_REDIS_KEY_TEMPLATE, uid);


		List<Cart> cartList=new ArrayList<>();
		Cart cart;
		//String value = opsForHash.get(redisKey, "data");

		/**
		 * add dapr state management
		 * read data from redis
		 */
		URI getStateURL = null;
		try {
			getStateURL = new URI(baseUrl + "/v1.0/state/"+DAPR_STATE_STORE+"/"+redisDapyKey);
		} catch (URISyntaxException e) {
			throw new RuntimeException(e);
		}

		request = HttpRequest.newBuilder()
				.GET()
				.uri(getStateURL)
				.build();
		HttpResponse<String> stateResponse=null;
		try {
			stateResponse = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
		} catch (IOException e) {
			throw new RuntimeException(e);
		} catch (InterruptedException e) {
			throw new RuntimeException(e);
		}


//		if (StringUtils.isEmpty(value)) {
//			//没有该商品, 新增
//			cart = new Cart(product.getId(), quantity, form.getSelected());
//			cartList.add(cart);
//		}else {
//
//			cartList = gson.fromJson((String)value, new TypeToken<ArrayList<Cart>>(){}.getType());
//
//			for(Cart item: cartList){
//				//已经有了，数量+1
//				if(item.getProductId().equals(product.getId())){
//					hasProduct=true;
//					item.setQuantity(item.getQuantity() + quantity);
//				}
//			}
//			if(!hasProduct){
//				cart = new Cart(product.getId(), quantity, form.getSelected());
//				cartList.add(cart);
//			}
//
//		}


		if (StringUtils.isEmpty(stateResponse.body())) {
			//没有该商品, 新增
			cart = new Cart(product.getId(), quantity, form.getSelected());
			cartList.add(cart);
		}else {

			cartList = gson.fromJson((String)stateResponse.body(), new TypeToken<ArrayList<Cart>>(){}.getType());

			for(Cart item: cartList){
				//已经有了，数量+1
				if(item.getProductId().equals(product.getId())){
					hasProduct=true;
					item.setQuantity(item.getQuantity() + quantity);
				}
			}
			if(!hasProduct){
				cart = new Cart(product.getId(), quantity, form.getSelected());
				cartList.add(cart);
			}

		}


		/**
		 * add dapr state management
		 * 写入到redis
		 */

//		opsForHash.put(redisKey,
//				"data",
//				gson.toJson(cartList));

		URI stateStoreUrl=null;
		try {
			 stateStoreUrl = new URI(baseUrl + "/v1.0/state/"+DAPR_STATE_STORE);
		} catch (URISyntaxException e) {
			throw new RuntimeException(e);
		}

		State state = new State(redisDapyKey, cartList);
		State[] payload = new State[] {state};
		try {
			request = HttpRequest.newBuilder()
					.POST(HttpRequest.BodyPublishers.ofString(objectMapper.writeValueAsString(payload)))
					.uri(stateStoreUrl)
					.build();
		} catch (JsonProcessingException e) {
			throw new RuntimeException(e);
		}

		try {
			httpClient.send(request, HttpResponse.BodyHandlers.ofString());
		} catch (IOException e) {
			throw new RuntimeException(e);
		} catch (InterruptedException e) {
			throw new RuntimeException(e);
		}


		return list(uid);
	}

	@Override
	public ResponseVo<CartVo> list(Integer uid) {
		String redisKey  = ConstantPropertiesUtil.APP_NAME+"||"+String.format(CART_REDIS_KEY_TEMPLATE, uid);

		BoundHashOperations<String, Object, Object> operations = redisTemplate.boundHashOps(redisKey);
		Object data = operations.get("data");


		BigDecimal cartTotalPrice = BigDecimal.ZERO;
		boolean selectAll = true;
		Integer cartTotalQuantity = 0;
		CartVo cartVo = new CartVo();

		if(data!=null){
			List<Cart> cartList = gson.fromJson((String)data, new TypeToken<ArrayList<Cart>>(){}.getType());
			List<CartProductVo> cartProductVoList = cartList.stream().map((obj) -> {

				Integer productId = obj.getProductId();
				Response<ProductDetail> productvo = productFeign.getProduct(productId);
				ProductDetail product = productvo.getData();
				CartProductVo cartProductVo = new CartProductVo(productId,
						obj.getQuantity(),
						product.getName(),
						product.getSubtitle(),
						product.getMainImage(),
						product.getPrice(),
						product.getStatus(),
						product.getPrice().multiply(BigDecimal.valueOf(obj.getQuantity())),
						product.getStock(),
						obj.getProductSelected()
				);
				return cartProductVo;
			}).collect(Collectors.toList());


			for(CartProductVo cartProductVo: cartProductVoList){
				if (!cartProductVo.getProductSelected()) {
					selectAll = false;
				}

				//计算总价(只计算选中的)
				if (cartProductVo.getProductSelected()) {
					cartTotalPrice = cartTotalPrice.add(cartProductVo.getProductTotalPrice());
				}

				cartTotalQuantity += cartProductVo.getQuantity();
			}

			cartVo.setSelectedAll(selectAll);
			cartVo.setCartTotalQuantity(cartTotalQuantity);
			cartVo.setCartTotalPrice(cartTotalPrice);
			cartVo.setCartProductVoList(cartProductVoList);
		}
		return ResponseVo.success(cartVo);
	}

	@Override
	public ResponseVo<CartVo> update(Integer uid, Integer productId, CartUpdateForm form) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = ConstantPropertiesUtil.APP_NAME+"||"+String.format(CART_REDIS_KEY_TEMPLATE, uid);

		String value = opsForHash.get(redisKey, "data");
		if (StringUtils.isEmpty(value)) {
			//没有该商品, 报错
			return ResponseVo.error(ResponseEnum.CART_PRODUCT_NOT_EXIST);
		}

		List<Cart> cartList  = gson.fromJson((String)value, new TypeToken<ArrayList<Cart>>(){}.getType());

		for(Cart item: cartList){
			//已经有了，数量+1
			if(item.getProductId().equals(productId)) {
				item.setQuantity(form.getQuantity());
				item.setProductSelected(form.getSelected());
			}
		}

		opsForHash.put(redisKey, "data", gson.toJson(cartList));
		return list(uid);
	}

	@Override
	public ResponseVo<CartVo> delete(Integer uid, Integer productId) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = ConstantPropertiesUtil.APP_NAME+"||"+String.format(CART_REDIS_KEY_TEMPLATE, uid);

		String value = opsForHash.get(redisKey, "data");
		if (StringUtils.isEmpty(value)) {
			//没有该商品, 报错
			return ResponseVo.error(ResponseEnum.CART_PRODUCT_NOT_EXIST);
		}

		List<Cart> cartList  = gson.fromJson((String)value, new TypeToken<ArrayList<Cart>>(){}.getType());


		int deleteIndex=-1;
		for (int i = 0; i < cartList.size(); i++) {
			if(cartList.get(i).getProductId().equals(productId)){
				deleteIndex=i;
			}
		}

		if(deleteIndex!=-1){
			cartList.remove(deleteIndex);
		}

		if(cartList.size()==0){
			String versionStr = opsForHash.get(redisKey, "version");
			//这里只是为了兼容dapr，因为dapr的存储包含一个version字段。用dapr的delete statement方法删除就好。todo
			if (!StringUtils.isEmpty(versionStr)) {
				opsForHash.delete(redisKey,"version");
			}
			opsForHash.delete(redisKey, "data");
		}else{
			opsForHash.put(redisKey, "data", gson.toJson(cartList));
		}

		return list(uid);
	}

	@Override
	public Response deleteByUidAndProID(Integer uid, Integer productId) {

		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = ConstantPropertiesUtil.APP_NAME+"||"+String.format(CART_REDIS_KEY_TEMPLATE, uid);

		String value = opsForHash.get(redisKey, "data");
		if (StringUtils.isEmpty(value)) {
			//没有该商品, 报错
			return Response.error(ResponseEnum.CART_PRODUCT_NOT_EXIST);
		}

		List<Cart> cartList  = gson.fromJson((String)value, new TypeToken<ArrayList<Cart>>(){}.getType());

		int deleteIndex=-1;
		for (int i = 0; i < cartList.size(); i++) {
			if(cartList.get(i).getProductId().equals(productId)){
				deleteIndex=i;
			}
		}

		if(deleteIndex!=-1){
			cartList.remove(deleteIndex);
		}

		if(cartList.size()==0){
			String versionStr = opsForHash.get(redisKey, "version");
			if (!StringUtils.isEmpty(versionStr)) {
				opsForHash.delete(redisKey,"version");
			}
			opsForHash.delete(redisKey, "data");
		}else{
			opsForHash.put(redisKey, "data", gson.toJson(cartList));
		}

		return Response.success();
	}

	@Override
	public ResponseVo<CartVo> selectAll(Integer uid) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = ConstantPropertiesUtil.APP_NAME+"||"+String.format(CART_REDIS_KEY_TEMPLATE, uid);

		for (Cart cart : listForCart(uid)) {
			cart.setProductSelected(true);
			opsForHash.put(redisKey,
					"data",
					gson.toJson(cart));
		}

		return list(uid);
	}

	@Override
	public ResponseVo<CartVo> unSelectAll(Integer uid) {
		HashOperations<String, String, String> opsForHash = redisTemplate.opsForHash();
		String redisKey  = ConstantPropertiesUtil.APP_NAME+"||"+String.format(CART_REDIS_KEY_TEMPLATE, uid);

		for (Cart cart : listForCart(uid)) {
			cart.setProductSelected(false);
			opsForHash.put(redisKey,
					"data",
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
		String redisKey  = ConstantPropertiesUtil.APP_NAME+"||"+String.format(CART_REDIS_KEY_TEMPLATE, uid);

		List<Cart> cartList=new ArrayList<>();
		String value = opsForHash.get(redisKey, "data");
		if (StringUtils.isEmpty(value)) {
			return cartList;
		}

		cartList  = gson.fromJson((String)value, new TypeToken<ArrayList<Cart>>(){}.getType());

		return  cartList;
	}

}

@AllArgsConstructor
@Getter
class State {
	private String key;
	private List<Cart> value;
}
