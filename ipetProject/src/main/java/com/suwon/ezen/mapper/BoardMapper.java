package com.suwon.ezen.mapper;

import java.util.List;

import com.suwon.ezen.vo.BoardVO;
import com.suwon.ezen.vo.ImageTableVO;

public interface BoardMapper {
	// 전체 목록 가져오기
	public List<BoardVO> getListAll(int offset);
	
	// 새 글 하나 추가하기
	public void insertPost(BoardVO vo);
	
	// 글 하나 가져오기
	public BoardVO getOneContent(int bno);
	
	// 글 하나 수정하기
	public void modifyOneContent(BoardVO vo);
	
	// 글 하나 삭제하기
	public void deleteOneContent(int bno);
	
	public int getCount();
	
	// 이미지 파일 추가하기
	public void insertImage(ImageTableVO vo);
	
	// 이미지 파일 가져오기
	public ImageTableVO selectImage(String fileName);
}
