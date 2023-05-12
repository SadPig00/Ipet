package com.suwon.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suwon.ezen.mapper.ProductMapper;
import com.suwon.ezen.vo.ProductVO;

@Service
public class ProductServiceImpl implements ProductService {
	
	@Autowired
	private ProductMapper mapper;
	
	@Override
    public ProductVO getProduct(int pno) {
        return mapper.getProduct(pno);
    }
    
    @Override
    public List<ProductVO> getProducts() {
        return mapper.getProducts();
    }
    
    @Override
    public void insertProduct(ProductVO vo) {
        mapper.insertProduct(vo);
    }
    
    @Override
    public void updateProduct(ProductVO vo) {
        mapper.updateProduct(vo);
    }
    
    @Override
    public void deleteProduct(int pno) {
        mapper.deleteProduct(pno);
    }
	
}
