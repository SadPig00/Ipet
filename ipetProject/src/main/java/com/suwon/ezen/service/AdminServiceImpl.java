package com.suwon.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suwon.ezen.vo.MemberVO;

import jdk.jfr.SettingDefinition;
import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService{

	@Setter(onMethod_ =@Autowired )
	private MemberService memberService;
	// 고객 정보 가져오기
	@Override
	public List<MemberVO> getMemberList(int offset) {
		return memberService.getMemberList(offset);
	}
	//총 고객갯수 가져오기
	@Override
	public int getMemberCount() {
		return memberService.getMemberCount();
	}
	//mno로 회원 정보 가져오기
	@Override
	public MemberVO getByMno(int mno) {
		 
		return memberService.getByMno(mno);
	}
	
	@Override
	public int memberUpdate(MemberVO vo) {
		
		return memberService.update(vo);
	}
	@Override
	public int delete(int mno) {
		 
		return memberService.delete(mno);
	}

}
