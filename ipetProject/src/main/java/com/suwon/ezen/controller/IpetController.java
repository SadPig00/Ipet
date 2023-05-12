package com.suwon.ezen.controller;



import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.suwon.ezen.service.BoardService;
import com.suwon.ezen.service.ProductService;
import com.suwon.ezen.vo.BoardVO;
import com.suwon.ezen.vo.Paging;
import com.suwon.ezen.vo.ProductVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@RestController
@RequestMapping("/ipet/*")
@Log4j
public class IpetController {

	@Setter(onMethod_ = @Autowired)
	private BoardService bservice;
	@Setter(onMethod_ = @Autowired)
	private ProductService pservice;
	
	@GetMapping(value = "/index")
	public ModelAndView index(ModelAndView mnv,HttpSession session) {
		mnv.addObject("index", 0);
		mnv.setViewName("index");
		session.setAttribute("mno", "1");
		session.setAttribute("auth", "0");
		return mnv;
	}
	@GetMapping(value = "/pro")
	public ModelAndView pro(ModelAndView mnv) {
		mnv.addObject("index", 1);
		List<ProductVO> productList = pservice.getProducts();
		mnv.addObject("productList", productList);
		mnv.setViewName("/products/product");
		return mnv;
	}
	@GetMapping(value = "/hos")
	public ModelAndView hos(ModelAndView mnv) {
		mnv.addObject("index", 2);
		mnv.setViewName("hospital");
		return mnv;
	}
	@GetMapping(value = "/commu")
	public ModelAndView commu(ModelAndView mnv,@Param("pageNum")Integer pageNum) {
		int pageNumTemp=1;
		if(pageNum != null) pageNumTemp=pageNum;
		
		Paging paging = new Paging(bservice.getCount(), pageNumTemp);
		mnv.addObject("index", 3);
		List<BoardVO> boardList = bservice.getListAll(paging.getOffset());
		mnv.addObject("list", boardList);
		mnv.addObject("paging", paging);
		
		mnv.setViewName("/board/community");
		return mnv;
	}
	
	
	
	
	
}
