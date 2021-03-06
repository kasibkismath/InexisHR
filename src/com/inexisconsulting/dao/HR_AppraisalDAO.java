package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("hrAppraisalDao")
public class HR_AppraisalDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}
	
	public void addHRAppraisal(HR_Appraisal hr_appraisal) {
		session().saveOrUpdate(hr_appraisal);
	}
	 
	public Long checkHRAppraisalExists(HR_Appraisal hr_Appraisal) throws HibernateException, ParseException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from lead appraisal object
		Date date = hr_Appraisal.getPerformance().getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);
		
		String hql = "select count(hrApp.hr_appraisal_id) as count from HR_Appraisal as hrApp "
				+ "where hrApp.employee.emp_id=:empId and hrApp.performance.date=:date "
				+ "and hrApp.status=:status";
		
		Query query = session().createQuery(hql);
		query.setParameter("empId", hr_Appraisal.getEmployee().getEmpId());
		query.setParameter("date", sdf.parse(stringDate));
		query.setParameter("status", "Completed");
		
		Long count = ((Number)query.uniqueResult()).longValue();
		return count;
	}

	@SuppressWarnings("unchecked")
	public List<HR_Appraisal> getHRAppraisals() {
		String hql = "from HR_Appraisal";
		
		Query query = session().createQuery(hql);
		
		List<HR_Appraisal> hr_appraisals = query.list();
		return hr_appraisals;
	}

	public HR_Appraisal getHRAppraisalsByAppraisalId(HR_Appraisal hrAppraisal) {
		Criteria crit = session().createCriteria(HR_Appraisal.class);
		crit.add(Restrictions.eq("hr_appraisal_id", hrAppraisal.getHr_appraisal_id()));
		HR_Appraisal hrAppraisalResult = (HR_Appraisal)crit.uniqueResult(); 
		return hrAppraisalResult;
	}

	public void updateHRAppraisal(HR_Appraisal hr_Appraisal) {
		
		Criteria crit = session().createCriteria(HR_Appraisal.class);
		crit.add(Restrictions.eq("hr_appraisal_id", hr_Appraisal.getHr_appraisal_id()));
		
		HR_Appraisal updatedHRAppraisal = (HR_Appraisal)crit.uniqueResult();
		updatedHRAppraisal.setStatus(hr_Appraisal.getStatus());
		updatedHRAppraisal.setScore_current_performance(hr_Appraisal.getScore_current_performance());
		updatedHRAppraisal.setScore_task_completion(hr_Appraisal.getScore_task_completion());
		updatedHRAppraisal.setTotal_score(hr_Appraisal.getTotal_score());
		
		session().saveOrUpdate(updatedHRAppraisal);
	}

	public void deleteHRAppraisal(HR_Appraisal hr_Appraisal) {
		Query query = session().createQuery("delete from HR_Appraisal where hr_appraisal_id=:hrAppraisalId");
		query.setInteger("hrAppraisalId", hr_Appraisal.getHr_appraisal_id());
		query.executeUpdate();
	}
}
