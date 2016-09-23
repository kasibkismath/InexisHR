package com.inexisconsulting.service;

import java.text.ParseException;
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

	public void addApplicant(Applicant applicant) throws ParseException {
		applicantDao.addApplicant(applicant);
	}

}
