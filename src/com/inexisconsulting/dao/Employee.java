package com.inexisconsulting.dao;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name = "employee")
public class Employee {

	@Id
	@Column(name = "id")
	private int id;
	private String firstName;
	private String lastName;
	private String email;
	private String phoneNumber;
	private String mobileNumber;
	private Date hireDate;
	private String designation;
	private String employmentType;
	private Date birthday;
	private String education;
	private String pastWork;
	private MultipartFile image;

	public Employee() {
	}

	public Employee(int id, String firstName, String lastName, String email, String phoneNumber, String mobileNumber,
			Date hireDate, String designation, String employmentType, Date birthday, String education, String pastWork,
			MultipartFile image) {
		this.id = id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.mobileNumber = mobileNumber;
		this.hireDate = hireDate;
		this.designation = designation;
		this.employmentType = employmentType;
		this.birthday = birthday;
		this.education = education;
		this.pastWork = pastWork;
		this.image = image;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public Date getHireDate() {
		return hireDate;
	}

	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}

	public String getDesignation() {
		return designation;
	}

	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public String getEmploymentType() {
		return employmentType;
	}

	public void setEmploymentType(String employmentType) {
		this.employmentType = employmentType;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getPastWork() {
		return pastWork;
	}

	public void setPastWork(String pastWork) {
		this.pastWork = pastWork;
	}

	public MultipartFile getImage() {
		return image;
	}

	public void setImage(MultipartFile image) {
		this.image = image;
	}

}
