package com.suwon.ezen.service;

import java.util.List;

import com.suwon.ezen.vo.HospitalVO;

public interface HospitalService {
	public List<HospitalVO> getList(String address);
}
