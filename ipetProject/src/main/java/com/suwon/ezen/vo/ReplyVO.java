package com.suwon.ezen.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	private int bno;
	private int rno;
	private String id;
	private String reply;
	private String isFileExist;
	private Date replyDate;
}
