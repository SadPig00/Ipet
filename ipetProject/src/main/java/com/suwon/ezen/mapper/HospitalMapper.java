package com.suwon.ezen.mapper;

import java.util.List;

import com.suwon.ezen.vo.HospitalVO;

public interface HospitalMapper {
	public List<HospitalVO> getAll();
	public List<HospitalVO> getByAddress(String address);
}
