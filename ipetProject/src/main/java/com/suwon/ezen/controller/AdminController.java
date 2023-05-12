package com.suwon.ezen.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.suwon.ezen.service.AdminService;
import com.suwon.ezen.vo.MemberVO;
import com.suwon.ezen.vo.Paging;

import lombok.Setter;

@RestController
@RequestMapping("/admin/*")
public class AdminController {
	
	@Setter(onMethod_ =@Autowired )
	private AdminService service;
	
	@GetMapping("/member")
	public ModelAndView member(Integer pageNum, ModelAndView mav, HttpServletRequest req) {
		Paging pagin = new Paging(service.getMemberCount(),pageNum);
		mav.addObject("memberList", service.getMemberList(pagin.getOffset()));
		mav.addObject("paging", pagin);
		mav.addObject("index", 0);
		mav.setViewName("/admin/member");
		
		return mav;
	}
	@GetMapping("/update")
	public ModelAndView update(int mno,ModelAndView mav) {
		MemberVO vo = service.getByMno(mno);
		mav.addObject("member", vo);
		mav.addObject("index", 0);
		mav.setViewName("/admin/update");
		return mav;
	}
	
	@Transactional
	@PutMapping("/update")
	public ResponseEntity<HashMap<String, String>> updateComplete(@RequestBody MemberVO vo){
		System.out.println("데이터 확인 : "+ vo);
		int result = service.memberUpdate(vo);
		Map<String,String> map = new HashMap<>();
		if(result==1)map.put("message", "고객 번호: "+vo.getMno()+"번 수정 완료");
		else map.put("message", "수정실패");
		return new ResponseEntity(map,HttpStatus.OK);
			
	}
	@Transactional
	@DeleteMapping("/delete/{mno}")
	public ResponseEntity<HashMap<String, String>> delete(@PathVariable("mno")int mno){
		System.out.println("데이터 확인 : "+ mno);
		Map<String,String> map = new HashMap<>();
		int result = service.delete(mno);
		if(result==1)map.put("message", "고객 번호: "+mno+"번 삭제 완료");
		else map.put("message", "삭제 실패");
		return new ResponseEntity(map,HttpStatus.OK);
			
	}
}
