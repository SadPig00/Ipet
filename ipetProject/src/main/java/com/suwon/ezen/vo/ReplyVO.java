package com.suwon.ezen.vo;

import lombok.Data;

@Data
public class ReplyVO {
	private int bno;
	private int rno;
	private String id;
	private String reply;
	private String isFileExist;
	private String fileName;
}
