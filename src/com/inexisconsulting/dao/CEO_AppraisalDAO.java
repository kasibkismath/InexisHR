package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("ceoAppraisalDao")
public class CEO_AppraisalDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	public void addCEOAppraisal(CEO_Appraisal ceo_appraisal) {
		session().saveOrUpdate(ceo_appraisal);
	}

	public Long checkDuplicateCEOExists(CEO_Appraisal ceo_appraisal) throws HibernateException, ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from lead appraisal object
		Date date = ceo_appraisal.getPerformance().getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);
		
		String hql = "select count(ceoApp.ceo_appraisal_id) as count from CEO_Appraisal as ceoApp "
				+ "where ceoApp.employee.emp_id=:empId and ceoApp.performance.date=:date ";
		
		Query query = session().createQuery(hql);
		query.setParameter("empId", ceo_appraisal.getEmployee().getEmpId());
		query.setParameter("date", sdf.parse(stringDate));
		
		Long count = (Long)query.uniqueResult();
		return count;
	}

}
