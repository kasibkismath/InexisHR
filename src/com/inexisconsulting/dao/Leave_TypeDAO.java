package com.inexisconsulting.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("leaveTypeDao")
public class Leave_TypeDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	public List<Leave_Type> getLeaveTypes() {
		return session().createQuery("from Leave_Type").list();
	}
	
	public int getCasualLeaveTypeId() {
		Criteria crit = session().createCriteria(Leave_Type.class);
		crit.add(Restrictions.eq("name", "Casual Leave"));
		Leave_Type result = (Leave_Type)crit.uniqueResult();
		return result.getLeave_type_id();
	}

	public Leave_Type getLeaveTypeId(Leave_Type leaveType) {
		Criteria crit = session().createCriteria(Leave_Type.class);
		crit.add(Restrictions.eq("leave_type_id", leaveType.getLeave_type_id()));
		Leave_Type result = (Leave_Type)crit.uniqueResult();
		return result;
	}

	public int getMedicalLeaveTypeId() {
		Criteria crit = session().createCriteria(Leave_Type.class);
		crit.add(Restrictions.eq("name", "Medical Leave"));
		Leave_Type result = (Leave_Type)crit.uniqueResult();
		return result.getLeave_type_id();
	}
}
