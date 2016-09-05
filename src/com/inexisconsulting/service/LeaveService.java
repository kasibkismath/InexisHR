package com.inexisconsulting.service;

import java.text.ParseException;

import org.hibernate.HibernateException;
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

	public boolean checkDuplicateLeave(Leave leave) throws HibernateException, ParseException {
		return leaveDao.checkDuplicateLeave(leave);
	}
}
