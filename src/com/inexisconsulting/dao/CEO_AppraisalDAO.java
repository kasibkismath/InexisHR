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

	@SuppressWarnings("unchecked")
	public List<CEO_Appraisal> getCEOAppraisals() {
		String hql = "from CEO_Appraisal as ceoApp";
		Query query = session().createQuery(hql);
		
		List<CEO_Appraisal> ceo_appraisals = query.list();
		return ceo_appraisals;
	}

	public CEO_Appraisal getCEOAppraisalByAppraisalId(CEO_Appraisal ceoAppraisal) {
		Criteria crit = session().createCriteria(CEO_Appraisal.class);
		crit.add(Restrictions.eq("ceo_appraisal_id", ceoAppraisal.getCeo_appraisal_id()));
		CEO_Appraisal ceoAppraisalResult = (CEO_Appraisal)crit.uniqueResult(); 
		return ceoAppraisalResult;
	}

	public void updateCEOAppraisal(CEO_Appraisal ceo_Appraisal) {
		
		Criteria crit = session().createCriteria(CEO_Appraisal.class);
		crit.add(Restrictions.eq("ceo_appraisal_id", ceo_Appraisal.getCeo_appraisal_id()));
		
		CEO_Appraisal updatedCEOAppraisal = (CEO_Appraisal)crit.uniqueResult();
		updatedCEOAppraisal.setScore_skill(ceo_Appraisal.getScore_skill());
		updatedCEOAppraisal.setScore_mentorship(ceo_Appraisal.getScore_mentorship());
		updatedCEOAppraisal.setScore_current_performance(ceo_Appraisal.getScore_current_performance());
		updatedCEOAppraisal.setScore_task_completion(ceo_Appraisal.getScore_task_completion());
		updatedCEOAppraisal.setStatus(ceo_Appraisal.getStatus());
		updatedCEOAppraisal.setDescription(ceo_Appraisal.getDescription());
		updatedCEOAppraisal.setTotal_score(ceo_Appraisal.getTotal_score());
		
		session().saveOrUpdate(updatedCEOAppraisal);
	}

	public void deleteCEOAppraisal(CEO_Appraisal ceo_Appraisal) {
		Query query = session().createQuery("delete from CEO_Appraisal where ceo_appraisal_id=:ceoAppraisalId");
		query.setInteger("ceoAppraisalId", ceo_Appraisal.getCeo_appraisal_id());
		query.executeUpdate();
	}

}
