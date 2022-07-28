package com.chinasofti.pay.feign;


import com.chinasofti.mall.common.dto.ProductDetail;
import com.chinasofti.mall.common.dto.Response;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@FeignClient(value = "mall-product")
public interface ProductFeign {

    @RequestMapping(value = "/products/{productId}",method = RequestMethod.GET)
    public Response<ProductDetail> getProduct(@PathVariable(value="productId") Integer productId);

}
