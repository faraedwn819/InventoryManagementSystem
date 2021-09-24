package com.example.demo.repositories;

import org.springframework.data.repository.CrudRepository;

import com.example.demo.models.OrderDetail;

public interface OrderDetailRepository extends CrudRepository<OrderDetail,Integer> {

}
