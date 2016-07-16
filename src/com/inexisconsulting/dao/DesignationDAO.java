package com.inexisconsulting.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("designationDao")
public class DesignationDAO {
	
	@Autowired
	private SessionFactory sessionFactory;
	
	public Session session(){
		return sessionFactory.getCurrentSession();
	}
	
	@SuppressWarnings("unchecked")
	public List<Designation> getDesignations() {
		return session().createQuery("from Designation").list();
	}

	public Designation getDesignationById(Designation designation) {
		Criteria crit = session().createCriteria(Designation.class);
		crit.add(Restrictions.eq("designation_id", designation.getDesignationId()));
		Designation retreivedDesignation = (Designation)crit.uniqueResult(); 
		return retreivedDesignation;
	}

	public boolean checkDesignationExists(Designation designation) {
		Criteria crit = session().createCriteria(Designation.class);
		crit.add(Restrictions.eq("name", designation.getName()));
		Designation designationExists = (Designation)crit.uniqueResult();
		return designationExists == null;
	}

	public void updateDesignation(Designation designation) {
		Criteria crit = session().createCriteria(Designation.class);
		crit.add(Restrictions.eq("designation_id", designation.getDesignationId()));
		
		Designation updatedDesignation = (Designation)crit.uniqueResult();
		updatedDesignation.setName(designation.getName());
		
		session().saveOrUpdate(updatedDesignation);
	}
	
	public void deleteDesingationById(Designation designation) {
		Query query = session().createQuery("delete from Designation where designation_id=:designation_id");
		query.setInteger("designation_id", designation.getDesignationId());
		query.executeUpdate();
	}
}
