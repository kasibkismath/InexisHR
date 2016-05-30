package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Designation;
import com.inexisconsulting.dao.DesignationDAO;

@Service("designationService")
public class DesignationService {
	
	@Autowired
	private DesignationDAO desginationDao;
	
	public List<Designation> getDesignations(){
		return desginationDao.getDesignations();
	}

}
