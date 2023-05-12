package com.suwon.ezen.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class BoardVO {
	private int bno;
	private String title;
	private String content;
	private String writer;
	@JsonFormat(pattern="yyyy-MM-dd'T'HH:mm:ss")
	private Date regDate;
	@JsonFormat(pattern="yyyy-MM-dd'T'HH:mm:ss")
	private Date updateDate;
}
