package com.suwon.ezen.controller;

import java.util.HashMap;
import java.util.Map;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suwon.ezen.service.MemberService;
import com.suwon.ezen.vo.EmailAuthVO;
import com.suwon.ezen.vo.MemberVO;

import lombok.Setter;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@Setter(onMethod_ =@Autowired )
	BCryptPasswordEncoder passEncoder;
	
	@Setter(onMethod_ = @Autowired)
	private JavaMailSenderImpl mailSender;
	
	@GetMapping(value = "login")
	public String loginPage(HttpSession session) {
		if(session.getAttribute("loginMember")!=null) return "redirect:/ipet/index";
		else return "/member/login";
	}
	
	@PostMapping(value = "login")
	public ResponseEntity login(HttpSession session, MemberVO vo) {
		MemberVO loginMember = service.login(vo);
		String message;
		if(loginMember == null) {
			Map<String, String> map = new HashMap();
			message ="존재하지 않는 id 입니다";
			map.put("message", message);
			session.removeAttribute("loginMember");
			return new ResponseEntity<Map>(map,HttpStatus.OK);
		}
		else if(loginMember.getId() != null && passEncoder.matches(vo.getPassword(), loginMember.getPassword()) ) {
			Map<String, String> map = new HashMap();
			map.put("message", "1");
			session.setAttribute("loginMember", loginMember);
			return new ResponseEntity<Map>(map,HttpStatus.OK);
		}
		else if(loginMember.getId() != null && !passEncoder.matches(vo.getPassword(), loginMember.getPassword())) {
			Map<String, String> map = new HashMap();
			message ="비밀번호가 틀렸습니다.";
			map.put("message", message);
			session.removeAttribute("loginMember");
			return new ResponseEntity<Map>(map,HttpStatus.OK);
		}
		else return new ResponseEntity<String>("페이지 오류",HttpStatus.INTERNAL_SERVER_ERROR);
		
	}
	@GetMapping(value = "logout")
	public String logout(HttpSession session) {
		
		session.removeAttribute("loginMember");
		return "redirect:/ipet/index";
	}
	
	@GetMapping(value = "register")
	public void register() {
		
	}
	// 중복 아이디 확인
	@PostMapping(value = "/checkId")
	public ResponseEntity<HashMap<String, String>> checkId(@RequestBody HashMap<String, String> map) {
		System.out.println("들어온 id값: " + map.get("id"));
		MemberVO result = service.checkIdDupli(map.get("id"));
	    System.out.println("결과: " + result);
	    if(result == null) {
	    	map.put("result", "사용가능한 아이디 입니다.");
	    	map.put("status", "0");
	    	}
	    else {
	    	map.put("result", "이미 사용중인 아이디 입니다.");
	    	map.put("status", "1");
	    }
        return new ResponseEntity<HashMap<String,String>>(map, HttpStatus.OK);
	    
	}
	
	@PostMapping(value = "register")
	public String regist(MemberVO vo) {
		MemberVO mVo = vo;
//		mVo.setPassword(passEncoder.encode(vo.getPassword()));
//		service.regist(mVo);
		System.out.println(vo);
		return "redirect:/ipet/index";
	}
//	0510 민경 추가부분
	@PostMapping("/emailCheck")
	@ResponseBody
	public void emailCheck(@RequestBody HashMap<String, String> map) {
		String email = map.get("email");
		String auth = "";
		for (int i=0;i<8;i++) 
			auth += (int)(Math.random()*10);
		
		if (service.selectAuth(email) != null)
			service.deleteAuth(email);
		
		System.out.println("email: " + email + ", auth: " + auth);
		String mailContext = "i-Pet 회원 가입을 위한 이메일입니다. <br> 입력창에 인증번호 <b>" + auth + "</b> 을/를 입력해주세요.";
		
		try {
			MimeMessage mailMessage = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(mailMessage, true, "utf-8");
			helper.setFrom("milkyway3676@gamil.com");
			helper.setTo(email);
			helper.setSubject("i-Pet 회원 가입 이메일 인증");
			helper.setText(mailContext, true);
			mailSender.send(mailMessage);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		EmailAuthVO emailAuth = new EmailAuthVO();
		emailAuth.setAuth(auth);
		emailAuth.setEmail(email);
		
		service.insertAuth(emailAuth);
	}
	
	@PostMapping("/vaildAuth")
	@ResponseBody
	public ResponseEntity<HashMap<String, String>> vaildAuth(@RequestBody EmailAuthVO vo) {
		String authNum = vo.getAuth();
		String email = vo.getEmail();
		String auth = service.selectAuth(email);
		
		System.out.println("authNum: " + authNum + ", email: " + email + ", auth: " + auth);
		HashMap<String, String> map = new HashMap<String, String>();
		
		if (authNum.equals(auth)) {
			map.put("word", "인증되었습니다.");
			map.put("status", "1");
			service.deleteAuth(email);
		}
		else {
			map.put("word", "실패하였습니다. 다시 입력해주세요.");
	    	map.put("status", "0");
		}
		
		return new ResponseEntity<HashMap<String, String>>(map, HttpStatus.OK);
	}
	
}
