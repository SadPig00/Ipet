package com.suwon.ezen.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ProductVO {
	
	private int pno;
	private String cate;
	private String item;
	private String price;
	private String des;
	private String img;
	private Date regtime;
	private Date uptime;
	
}