package com.suwon.ezen.service;

import java.util.List;

import com.suwon.ezen.vo.MemberVO;

public interface AdminService {
	//회원 정보 가져오기
	public List<MemberVO> getMemberList(int offset);
	//총 회원수
	public int getMemberCount();
	
	public MemberVO getByMno(int mno);
	
	public int memberUpdate(MemberVO vo);
	
	public int delete(int mno);

}
