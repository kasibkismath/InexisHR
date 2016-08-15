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
@Component("leadAppraisalDao")
public class Lead_AppraisalDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	public void addLeadAppraisal(Lead_Appraisal lead_appraisal) {
		session().saveOrUpdate(lead_appraisal);
	}

	public boolean checkDuplicateLeadAppraisal(Lead_Appraisal lead_Appraisal) throws HibernateException, ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		// date from lead appraisal object
		Date date = lead_Appraisal.getPerformance().getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);
		
		String hql = "select count(leadApp.lead_appraisal_id) from Lead_Appraisal as leadApp " +
		"inner join leadApp.performance as perf where leadApp.employee.emp_id=:emp_id and"
		+ " leadApp.team.team_Id=:team_id and perf.date=:date";
		
		// get count
		Query query = session().createQuery(hql);
		query.setParameter("emp_id", lead_Appraisal.getEmployee().getEmpId());
		query.setParameter("team_id", lead_Appraisal.getTeam().getTeam_Id());
		query.setParameter("date", sdf.parse(stringDate));
		long count = ((Long) query.uniqueResult()).intValue();

		if (count == 1)
			return true;
		
		return false;
	}
}
