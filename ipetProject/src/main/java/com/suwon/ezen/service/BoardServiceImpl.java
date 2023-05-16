package com.suwon.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suwon.ezen.mapper.BoardMapper;
import com.suwon.ezen.vo.BoardVO;
import com.suwon.ezen.vo.ImageTableVO;
import com.suwon.ezen.vo.ReplyVO;

import lombok.Setter;

@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper bmapper;
	
	// 전체 목록 가져오기
	@Override
	public List<BoardVO> getListAll(int offset) {
		List<BoardVO> boardList = bmapper.getListAll(offset);
		
		return boardList;
	}

	// 새 글 하나 추가하기
	@Override
	public void insertPost(BoardVO vo) {
		bmapper.insertPost(vo);
		
	}
	
	// 글 하나 가져오기
	@Override
	public BoardVO getOneContent(int bno) {
		BoardVO vo = bmapper.getOneContent(bno);
		
		return vo;
	}
	
	// 글 하나 수정하기
	@Override
	public void modifyOneContent(BoardVO vo) {
		bmapper.modifyOneContent(vo);
	}
	
	// 글 하나 삭제하기
	@Override
	public void deleteOneContent(int bno) {
		bmapper.deleteOneContent(bno);
	}

	// 글 목록 갯수 가져오기
	@Override
	public int getCount() {
		return bmapper.getCount();
	}

	@Override
	public void insertImage(ImageTableVO vo) {
		bmapper.insertImage(vo);
		
	}

	@Override
	public ImageTableVO selectImage(String fileName) {
		ImageTableVO vo = bmapper.selectImage(fileName);
		
		return vo;
	}
	
	// 댓글 추가하기
		@Override
		public void insertReply(ReplyVO vo) {
			bmapper.insertReply(vo);
		}
		
		// 모든 댓글 가져오기
		@Override
		public List<ReplyVO> getAllReply(int bno) {
			List<ReplyVO> ReplyList = bmapper.getAllReply(bno);
			
			return ReplyList;
		}

}
