package com.inexisconsulting.dao;

import java.util.Date;

public class AppraisalReport {

	private String firstName;
	private String lastName;
	private Date date;
	private String status;
	private int final_score;
	private String description;

	public AppraisalReport() {
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getFinal_score() {
		return final_score;
	}

	public void setFinal_score(int final_score) {
		this.final_score = final_score;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
