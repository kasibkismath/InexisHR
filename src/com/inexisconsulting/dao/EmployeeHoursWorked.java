package com.inexisconsulting.dao;

import java.util.Date;

public class EmployeeHoursWorked {

	private String EmployeeName;
	private Date FromDate;
	private Date ToDate;
	private String HoursWorked;

	public EmployeeHoursWorked() {
	}

	public String getEmployeeName() {
		return EmployeeName;
	}

	public void setEmployeeName(String employeeName) {
		EmployeeName = employeeName;
	}

	public Date getFromDate() {
		return FromDate;
	}

	public void setFromDate(Date fromDate) {
		FromDate = fromDate;
	}

	public Date getToDate() {
		return ToDate;
	}

	public void setToDate(Date toDate) {
		ToDate = toDate;
	}

	public String getHoursWorked() {
		return HoursWorked;
	}

	public void setHoursWorked(String hoursWorked) {
		HoursWorked = hoursWorked;
	}

}
