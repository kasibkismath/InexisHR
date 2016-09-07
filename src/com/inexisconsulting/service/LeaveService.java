package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Employee;
import com.inexisconsulting.dao.Leave;
import com.inexisconsulting.dao.LeaveDAO;
import com.inexisconsulting.dao.Leave_Type;

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

	public void addLeave(Leave leave) throws ParseException {
		leaveDao.addLeave(leave);
	}

	public List<Leave> getLeavesForLoggedInEmployeeByYear(Leave leave) {
		return leaveDao.getLeavesForLoggedInEmployeeByYear(leave);
	}

	public Leave getLeaveByLeaveId(Leave leave) {
		return leaveDao.getLeaveByLeaveId(leave);
	}

	public void updateLeave(Leave leave) throws ParseException {
		leaveDao.updateLeave(leave);
	}

	public void deleteLeave(Leave leave) {
		leaveDao.deleteLeave(leave);
	}
}
