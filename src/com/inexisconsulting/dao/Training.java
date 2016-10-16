package com.inexisconsulting.dao;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "training")
public class Training {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "training_id")
	private int training_id;
	
	private String name;
	private String level_of_difficulty;
	private String objective;
	private String type_of_training;
	private int duration;
	private String trained_by;
	private int max_candidates;
	private int cost;
	private Date expected_start_date;
	private Date expected_end_date;
	
	public Training() {}

	public int getTraining_id() {
		return training_id;
	}

	public void setTraining_id(int training_id) {
		this.training_id = training_id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLevel_of_difficulty() {
		return level_of_difficulty;
	}

	public void setLevel_of_difficulty(String level_of_difficulty) {
		this.level_of_difficulty = level_of_difficulty;
	}

	public String getObjective() {
		return objective;
	}

	public void setObjective(String objective) {
		this.objective = objective;
	}

	public String getType_of_training() {
		return type_of_training;
	}

	public void setType_of_training(String type_of_training) {
		this.type_of_training = type_of_training;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public String getTrained_by() {
		return trained_by;
	}

	public void setTrained_by(String trained_by) {
		this.trained_by = trained_by;
	}

	public int getMax_candidates() {
		return max_candidates;
	}

	public void setMax_candidates(int max_candidates) {
		this.max_candidates = max_candidates;
	}

	public int getCost() {
		return cost;
	}

	public void setCost(int cost) {
		this.cost = cost;
	}

	public Date getExpected_start_date() {
		return expected_start_date;
	}

	public void setExpected_start_date(Date expected_start_date) {
		this.expected_start_date = expected_start_date;
	}

	public Date getExpected_end_date() {
		return expected_end_date;
	}

	public void setExpected_end_date(Date expected_end_date) {
		this.expected_end_date = expected_end_date;
	}
	
	
}
