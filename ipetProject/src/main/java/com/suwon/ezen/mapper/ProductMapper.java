package com.suwon.ezen.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.suwon.ezen.vo.ProductVO;

public interface ProductMapper {
	//글하나가져오기
	public ProductVO getProduct(int pno);
	//리스트가져오기
	public List<ProductVO> getProducts();
	//추가
	public void insertProduct(ProductVO vo);
    //수정
	public void updateProduct(ProductVO vo);
    //삭제
	public void deleteProduct(int pno);
	
	
	
	public void addAttach(@Param("image") String image, @Param("pcode") String pcode);
	public List<String> getAttach(String pcode);
	public void delAttach(String pcode);


}
