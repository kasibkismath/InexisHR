package com.inexisconsulting.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Leave;
import com.inexisconsulting.dao.LeaveDAO;

@Service("leaveService")
public class LeaveService {
	
	@Autowired
	private LeaveDAO leaveDao;

	public Long getLeaveSumByLeaveTypeAndYear(Leave leave) {
		return leaveDao.getLeaveSumByLeaveTypeAndYear(leave);
	}

	public float getLeaveSumByYearForCausalAndMedicalLeaves(Leave leave) {
		return leaveDao.getLeaveSumByYearForCausalAndMedicalLeaves(leave);
	}
}
