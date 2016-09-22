package com.inexisconsulting.dao;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "vacancy")
public class Vacancy {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "vacancy_id")
	private int vacancy_id;
	private String vacancy_title;
	private String job_desc;
	private String roles_responsibilities;
	private String experience;
	private String qualification;
	private Date added_date;
	private Date expiry_date;
	private String status;

	public Vacancy() {
	}

	public int getVacancy_id() {
		return vacancy_id;
	}

	public void setVacancy_id(int vacancy_id) {
		this.vacancy_id = vacancy_id;
	}

	public String getVacancy_title() {
		return vacancy_title;
	}

	public void setVacancy_title(String vacancy_title) {
		this.vacancy_title = vacancy_title;
	}

	public String getJob_desc() {
		return job_desc;
	}

	public void setJob_desc(String job_desc) {
		this.job_desc = job_desc;
	}

	public String getRoles_responsibilities() {
		return roles_responsibilities;
	}

	public void setRoles_responsibilities(String roles_responsibilities) {
		this.roles_responsibilities = roles_responsibilities;
	}

	public String getExperience() {
		return experience;
	}

	public void setExperience(String experience) {
		this.experience = experience;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public Date getAdded_date() {
		return added_date;
	}

	public void setAdded_date(Date added_date) {
		this.added_date = added_date;
	}

	public Date getExpiry_date() {
		return expiry_date;
	}

	public void setExpiry_date(Date expiry_date) {
		this.expiry_date = expiry_date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
