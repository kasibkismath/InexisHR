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

	public float getPendingLeaveCountByYear(Leave leave) {
		return leaveDao.getPendingLeaveCountByYear(leave);
	}

	public float getApprovedLeaveCount(Leave leave) {
		return leaveDao.getApprovedLeaveCount(leave);
	}

	public List<Object[]> getLeaveTypeSumByYear(Leave leave) {
		return leaveDao.getLeaveTypeSumByYear(leave);
	}

	public List<Leave> getAllLeavesByYear() {
		return leaveDao.getAllLeavesByYear();
	}

	public void updateLeaveStatus(Leave leave) {
		leaveDao.updateLeaveStatus(leave);
	}

	public List<Object[]> getLeaveSummaryForCEO() {
		return leaveDao.getLeaveSummaryForCEO();
	}

	public float getPendingLeaveCountByYearForCEO() {
		return leaveDao.getPendingLeaveCountByYearForCEO();
	}

	public List<Leave> generateLeavesReport(Leave leave) throws HibernateException, ParseException {
		return leaveDao.generateLeavesReport(leave);
	}
}
