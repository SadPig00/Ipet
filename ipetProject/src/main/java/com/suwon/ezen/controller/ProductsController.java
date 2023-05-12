package com.suwon.ezen.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.suwon.ezen.mapper.ProductMapper;
import com.suwon.ezen.service.ProductService;
import com.suwon.ezen.vo.BoardVO;
import com.suwon.ezen.vo.ProductVO;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/products/*")
@Log4j
public class ProductsController {
	
//	@Resource(name="uploadPath")
//	private String path;
	
	@Autowired
	private ProductService service;
	
//	@Autowired
//	private ProductMapper mapper;
	
	// 추가 화면 이동
	@GetMapping("insert")
	public ModelAndView insertproduct() {
		ModelAndView model = new ModelAndView();
		model.setViewName("/products/insert");
		
		return model;
	}
	
	// 추가
	@PostMapping(value = "/insert", consumes = "application/json", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ProductVO> insertproduct(@RequestBody ProductVO vo) {
		service.insertProduct(vo);
		return new ResponseEntity<ProductVO>(vo, HttpStatus.OK);
	}
	
	// 수정 화면 이동
	@GetMapping("/update")
	public ModelAndView updateproduct(int pno) {
		ModelAndView model = new ModelAndView();
		model.setViewName("/products/update");
		model.addObject("vo", service.getProduct(pno));
		
		return model;
	}
	
	// 수정
	@PutMapping(value = "/update" , consumes = "application/json", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ProductVO> updateproduct(@RequestBody ProductVO vo) {
		service.updateProduct(vo);
		return new ResponseEntity<ProductVO>(vo, HttpStatus.OK);
	}
	
	// 삭제
	@DeleteMapping("/delete")
	public ResponseEntity deleteproduct(@RequestBody int pno) {
		service.deleteProduct(pno);
		return new ResponseEntity(HttpStatus.OK);
	}
	
	@GetMapping(value = "/food")
	public ModelAndView petFood(ModelAndView mnv) {
		mnv.addObject("index", 1);
		mnv.setViewName("products/food");
		return mnv;
	}
	@GetMapping(value = "/pad")
	public ModelAndView petPad(ModelAndView mnv) {
		mnv.addObject("index", 1);
		mnv.setViewName("products/pad");
		return mnv;
	}
	@GetMapping(value = "/bath")
	public ModelAndView petBath(ModelAndView mnv) {
		mnv.addObject("index", 1);
		mnv.setViewName("products/bath");
		return mnv;
	}
	

}