package com.suwon.ezen.service;

import java.util.List;

import com.suwon.ezen.vo.ProductVO;

public interface ProductService {
	public ProductVO getProduct(int pno);
	public List<ProductVO> getProducts();
	public void insertProduct(ProductVO vo);
    public void updateProduct(ProductVO vo);
    public void deleteProduct(int pno);
}
