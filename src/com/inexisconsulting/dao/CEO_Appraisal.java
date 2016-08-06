package com.inexisconsulting.dao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "ceo_appraisal")
public class CEO_Appraisal {

	@Id
	@Column(name = "ceo_appraisal_id")
	private int ceo_appraisal_id;
	
	@OneToOne
	@JoinColumn(name = "emp_id")
	private Employee employee;

	@OneToOne
	@JoinColumn(name = "performance_id")
	private Performance performance;

	private int score_skill;
	private int score_mentorship;
	private int score_task_completion;
	private int score_current_performance;
	private String status;
	private String description;
	private int total_score;
	
	public CEO_Appraisal(int ceo_appraisal_id, Employee employee, Performance performance, int score_skill,
			int score_mentorship, int score_task_completion, int score_current_performance, String status,
			String description, int total_score) {
		this.ceo_appraisal_id = ceo_appraisal_id;
		this.employee = employee;
		this.performance = performance;
		this.score_skill = score_skill;
		this.score_mentorship = score_mentorship;
		this.score_task_completion = score_task_completion;
		this.score_current_performance = score_current_performance;
		this.status = status;
		this.description = description;
		this.total_score = total_score;
	}

	public int getCeo_appraisal_id() {
		return ceo_appraisal_id;
	}

	public void setCeo_appraisal_id(int ceo_appraisal_id) {
		this.ceo_appraisal_id = ceo_appraisal_id;
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

	public int getScore_skill() {
		return score_skill;
	}

	public void setScore_skill(int score_skill) {
		this.score_skill = score_skill;
	}

	public int getScore_mentorship() {
		return score_mentorship;
	}

	public void setScore_mentorship(int score_mentorship) {
		this.score_mentorship = score_mentorship;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getTotal_score() {
		return total_score;
	}

	public void setTotal_score(int total_score) {
		this.total_score = total_score;
	}
}
