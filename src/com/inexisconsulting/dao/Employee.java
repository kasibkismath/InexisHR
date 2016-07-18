package com.inexisconsulting.dao;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "employee")
public class Employee {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "emp_id")
	private int emp_id;
	private String firstName;
	private String lastName;
	
	@Column(unique = true)
	private String nicNo;
	private boolean status;
	private String email;
	private String phoneNumber;
	private String mobileNumber;
	private Date hireDate;

	@OneToOne
	@JoinColumn(name = "designation_id")
	private Designation designation;

	private String employmentType;
	private int salary;
	private Date birthday;
	private String education;
	private String pastWork;
	private String imageURL;

	public Employee() {
	}

	public Employee(int emp_id, String firstName, String lastName, String nicNo, boolean status,
			String email, String phoneNumber,
			String mobileNumber, Date hireDate, Designation designation, String employmentType, int salary,
			Date birthday, String education, String pastWork, String imageURL) {
		this.emp_id = emp_id;
		this.firstName = firstName;
		this.lastName = lastName;
		this.nicNo = nicNo;
		this.status = status;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.mobileNumber = mobileNumber;
		this.hireDate = hireDate;
		this.designation = designation;
		this.employmentType = employmentType;
		this.salary = salary;
		this.birthday = birthday;
		this.education = education;
		this.pastWork = pastWork;
		this.imageURL = imageURL;
	}

	public int getEmpId() {
		return emp_id;
	}

	public void setEmpId(int emp_id) {
		this.emp_id = emp_id;
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

	public String getNicNo() {
		return nicNo;
	}

	public void setNicNo(String nicNo) {
		this.nicNo = nicNo;
	}
	
	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
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

	public Designation getDesignation() {
		return designation;
	}

	public void setDesignation(Designation designation) {
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

	public String getImageURL() {
		return imageURL;
	}

	public void setImageURL(String imageURL) {
		this.imageURL = imageURL;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}
	
}
