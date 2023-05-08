package com.suwon.ezen.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.suwon.ezen.mapper.HospitalMapper;
import com.suwon.ezen.vo.HospitalVO;

import lombok.Setter;

@Service
public class HospitalServiceImpl implements HospitalService {
	@Setter
	(onMethod_ =@Autowired )
	private HospitalMapper mapper;
	
	@Override
	public List<HospitalVO> getList(String address) {
		 List<HospitalVO> voList = mapper.getByAddress(address);
		return voList;
	}

}
