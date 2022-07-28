package com.chinasofti.pay.feign;

import com.chinasofti.mall.common.dto.Response;
import com.chinasofti.mall.common.vo.OrderVo;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@FeignClient(value = "mall-order")
public interface OrderFeign {

    @RequestMapping(value ="/orders/uoid/{userid}/{orderNo}",method = RequestMethod.GET)
    public Response<OrderVo> getOrderByUOID(@PathVariable(value="userid") Integer userid, @PathVariable(value="orderNo") Long orderNo);

}
