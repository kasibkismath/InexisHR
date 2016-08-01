package com.inexisconsulting.dao;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "team_lead_appraisal")
public class Team_Lead_Appraisal {

	@Id
	@Column(name = "team_lead_appraisal_id")
	private int team_lead_appraisal_id;

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

	public Team_Lead_Appraisal(int team_lead_appraisal_id, Employee employee, Performance performance, 
			int score_skill, int score_mentorship, int score_task_completion, int score_current_performance,
			String status) {
		this.team_lead_appraisal_id = team_lead_appraisal_id;
		this.employee = employee;
		this.performance = performance;
		this.score_skill = score_skill;
		this.score_mentorship = score_mentorship;
		this.score_task_completion = score_task_completion;
		this.score_current_performance = score_current_performance;
		this.status = status;
	}

	public int getTeam_lead_appraisal_id() {
		return team_lead_appraisal_id;
	}

	public void setTeam_lead_appraisal_id(int team_lead_appraisal_id) {
		this.team_lead_appraisal_id = team_lead_appraisal_id;
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
}
