package com.inexisconsulting.dao;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "project")
public class Project {

	@Id
	@Column(name="project_id")
	private int project_id;
	private String project_name;
	private String status;
	private Date project_start;
	private String project_client;

	public Project() {
	}

	public Project(int project_id, String project_name, String status, Date project_start, String project_client) {
		this.project_id = project_id;
		this.project_name = project_name;
		this.status = status;
		this.project_start = project_start;
		this.project_client = project_client;
	}

	public int getProject_id() {
		return project_id;
	}

	public void setProject_id(int project_id) {
		this.project_id = project_id;
	}

	public String getProject_name() {
		return project_name;
	}

	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getProject_start() {
		return project_start;
	}

	public void setProject_start(Date project_start) {
		this.project_start = project_start;
	}

	public String getProject_client() {
		return project_client;
	}

	public void setProject_client(String project_client) {
		this.project_client = project_client;
	}
}
