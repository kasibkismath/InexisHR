package com.inexisconsulting.dao;

import java.util.Date;

public class TrainingReportSentData {
	private Date fromDate;
	private Date toDate;
	private String type_of_budget;

	public TrainingReportSentData() {
	}

	public Date getFromDate() {
		return fromDate;
	}

	public void setFromDate(Date fromDate) {
		this.fromDate = fromDate;
	}

	public Date getToDate() {
		return toDate;
	}

	public void setToDate(Date toDate) {
		this.toDate = toDate;
	}

	public String getType_of_budget() {
		return type_of_budget;
	}

	public void setType_of_budget(String type_of_budget) {
		this.type_of_budget = type_of_budget;
	}
}
