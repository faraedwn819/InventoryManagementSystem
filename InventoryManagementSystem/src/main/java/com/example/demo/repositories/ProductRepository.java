package com.example.demo.repositories;

import org.springframework.data.repository.CrudRepository;

import com.example.demo.models.Product;

public interface ProductRepository extends CrudRepository<Product, Integer> {

}
