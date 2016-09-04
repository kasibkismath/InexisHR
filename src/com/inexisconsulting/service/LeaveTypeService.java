package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Leave_Type;
import com.inexisconsulting.dao.Leave_TypeDAO;

@Service("leaveTypeService")
public class LeaveTypeService {

	@Autowired
	private Leave_TypeDAO leaveTypeDao;

	public List<Leave_Type> getLeaveTypes() {
		return leaveTypeDao.getLeaveTypes();
	}

	public int getCasualLeaveTypeId() {
		return leaveTypeDao.getCasualLeaveTypeId();
	}

	public Leave_Type getLeaveTypeId(Leave_Type leaveType) {
		return leaveTypeDao.getLeaveTypeId(leaveType);
	}
}
