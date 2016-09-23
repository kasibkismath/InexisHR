package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Applicant;
import com.inexisconsulting.dao.ApplicantDAO;

@Service("applicantService")
public class ApplicantService {
	
	@Autowired
	private ApplicantDAO applicantDao;

	public List<Applicant> getAllApplicantsByCurrentYear() {
		return applicantDao.getAllApplicantsByCurrentYear();
	}

}
