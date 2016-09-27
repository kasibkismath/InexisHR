package com.inexisconsulting.service;

import java.text.ParseException;
import java.util.List;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.AllAttendanceReport;
import com.inexisconsulting.dao.Attendance;
import com.inexisconsulting.dao.AttendanceDAO;
import com.inexisconsulting.dao.EmployeeHoursWorked;

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

	public List<Attendance> getAttendancesByEmpId(Attendance attendance) {
		return attendanceDao.getAttendancesByEmpId(attendance);
	}

	public Attendance getAttendanceByAttendanceId(Attendance attendance) {
		return attendanceDao.getAttendanceByAttendanceId(attendance);
	}

	public void updateAttendance(Attendance attendance) throws ParseException {
		attendanceDao.updateAttendance(attendance);
	}

	public void deleteAttendance(Attendance attendance) {
		attendanceDao.deleteAttendance(attendance);
	}

	public float getDailyHoursByLoggedInEmp(Attendance attendance) throws HibernateException, ParseException {
		return attendanceDao.getDailyHoursByLoggedInEmp(attendance);
	}

	public float getWeeklyHoursByLoggedInEmp(Attendance attendance) {
		return attendanceDao.getWeeklyHoursByLoggedInEmp(attendance);
	}

	public List<Object[]> userLeadAndHRSummaryChart(Attendance attendance) {
		return attendanceDao.userLeadAndHRSummaryChart(attendance);
	}

	public List<Object[]> hrAndCeoSummaryChart() {
		return attendanceDao.hrAndCeoSummaryChart();
	}

	public List<Attendance> getAttendancesForCurrentYear() {
		return attendanceDao.getAttendancesForCurrentYear();
	}

	public List<Attendance> getAllAttendacesForReport(AllAttendanceReport allAttendaceReport) throws HibernateException, ParseException {
		return attendanceDao.getAllAttendacesForReport(allAttendaceReport);
	}

	public List<EmployeeHoursWorked> getEmployeeHoursWorkedReport(AllAttendanceReport attendance) throws HibernateException, ParseException {
		return attendanceDao.getEmployeeHoursWorkedReport(attendance);
	}

}
