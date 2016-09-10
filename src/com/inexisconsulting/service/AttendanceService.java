package com.inexisconsulting.service;

import java.text.ParseException;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Attendance;
import com.inexisconsulting.dao.AttendanceDAO;

@Service("attendanceService")
public class AttendanceService {
	
	@Autowired
	private AttendanceDAO attendanceDao;

	public boolean checkAttendanceDuplicate(Attendance attendance) throws HibernateException, ParseException {
		return attendanceDao.checkAttendanceDuplicate(attendance);
	}

	public void addAttendance(Attendance attendance) throws ParseException {
		attendanceDao.addAttendance(attendance);
	}

}
