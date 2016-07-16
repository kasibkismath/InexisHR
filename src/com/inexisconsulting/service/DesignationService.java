package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Designation;
import com.inexisconsulting.dao.DesignationDAO;

@Service("designationService")
public class DesignationService {
	
	@Autowired
	private DesignationDAO designationDao;
	
	public List<Designation> getDesignations(){
		return designationDao.getDesignations();
	}

	public Designation getDesignationById(Designation designation) {
		return designationDao.getDesignationById(designation);
	}

	public boolean checkDesignationExists(Designation designation) {
		return designationDao.checkDesignationExists(designation);
	}

	public void updateDesignation(Designation designation) {
		designationDao.updateDesignation(designation);
	}

	public void deleteDesignationById(Designation designation) {
		designationDao.deleteDesingationById(designation);
	}
}
