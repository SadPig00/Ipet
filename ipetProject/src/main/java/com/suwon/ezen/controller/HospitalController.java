package com.suwon.ezen.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.mysql.cj.Session;
import com.suwon.ezen.service.HospitalService;
import com.suwon.ezen.vo.HospitalVO;

import lombok.Setter;

@RestController
@RequestMapping("/hospital/*")
public class HospitalController {
	@Setter
	(onMethod_ =@Autowired )
	private HospitalService service;
	
	@GetMapping(value = "check_hos")
	public ModelAndView getList(ModelAndView mnv, @Param("add")String add){
		List<HospitalVO> voList = service.getList(add);
		ModelAndView model = new ModelAndView();
		model.setViewName("hospital");
		model.addObject("voList",voList );
		return model;
	}
}
