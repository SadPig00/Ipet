package com.suwon.ezen.controller;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;


@RestController
@RequestMapping("/sample/*")
@Log4j
public class IpetController {

	@GetMapping(value = "/index")
	public ModelAndView index(ModelAndView mnv) {
		mnv.addObject("index", 0);
		mnv.setViewName("index");
		return mnv;
	}
	@GetMapping(value = "/pro")
	public ModelAndView pro(ModelAndView mnv) {
		mnv.addObject("index", 1);
		mnv.setViewName("product");
		return mnv;
	}
	@GetMapping(value = "/hos")
	public ModelAndView hos(ModelAndView mnv) {
		mnv.addObject("index", 2);
		mnv.setViewName("hospital");
		return mnv;
	}
	@GetMapping(value = "/commu")
	public ModelAndView commu(ModelAndView mnv) {
		mnv.addObject("index", 3);
		mnv.setViewName("community");
		return mnv;
	}
	
	
	
	
	
}
