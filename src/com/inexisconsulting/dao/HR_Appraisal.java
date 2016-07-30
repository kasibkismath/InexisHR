package com.inexisconsulting.dao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "hr_appraisal")
public class HR_Appraisal {

	@Id
	@Column(name = "hr_appraisal_id")
	private int hr_appraisal_id;

	@OneToOne
	@JoinColumn(name = "emp_id")
	private Employee employee;

	@OneToOne
	@JoinColumn(name = "performance_id")
	private Performance performance;

	private int score_task_completion;
	private int score_current_performance;
	private String status;

	public HR_Appraisal(int hr_appraisal_id, Employee employee, Performance performance, 
			int score_task_completion, int score_current_performance, String status) {
		this.hr_appraisal_id = hr_appraisal_id;
		this.employee = employee;
		this.performance = performance;
		this.score_task_completion = score_task_completion;
		this.score_current_performance = score_current_performance;
		this.status = status;
	}

	public int getHr_appraisal_id() {
		return hr_appraisal_id;
	}

	public void setHr_appraisal_id(int hr_appraisal_id) {
		this.hr_appraisal_id = hr_appraisal_id;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public Performance getPerformance() {
		return performance;
	}

	public void setPerformance(Performance performance) {
		this.performance = performance;
	}

	public int getScore_task_completion() {
		return score_task_completion;
	}

	public void setScore_task_completion(int score_task_completion) {
		this.score_task_completion = score_task_completion;
	}

	public int getScore_current_performance() {
		return score_current_performance;
	}

	public void setScore_current_performance(int score_current_performance) {
		this.score_current_performance = score_current_performance;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
