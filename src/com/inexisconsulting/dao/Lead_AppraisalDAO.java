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

	public boolean checkDuplicateLeadAppraisal(Lead_Appraisal lead_Appraisal)
			throws HibernateException, ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from lead appraisal object
		Date date = lead_Appraisal.getPerformance().getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);

		String hql = "select count(leadApp.lead_appraisal_id) from Lead_Appraisal as leadApp "
				+ "inner join leadApp.performance as perf where leadApp.employee.emp_id=:emp_id and"
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

	public Long getCompleteLeadAppraisalCountByEmpId(Lead_Appraisal lead_Appraisal) throws HibernateException, ParseException {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from lead appraisal object
		Date date = lead_Appraisal.getPerformance().getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);
		
		String hql = "select count(leadApp.lead_appraisal_id) from Lead_Appraisal as leadApp where " 
				+ "leadApp.employee.emp_id=:empId and leadApp.performance.date=:date " 
				+ "and leadApp.status=:status";

		Query query = session().createQuery(hql);
		query.setParameter("empId", lead_Appraisal.getEmployee().getEmpId());
		query.setParameter("date", sdf.parse(stringDate));
		query.setParameter("status", "Completed");

		Long count = (Long) query.uniqueResult();
		return count;
	}

	@SuppressWarnings("unchecked")
	public List<Lead_Appraisal> getLeadAppraisalsByLeadId(Lead_Appraisal leadAppraisal) {
		
		String hql = "from Lead_Appraisal as leadApp inner join leadApp.team as team where "
				+ "team.employee.emp_id=:empId";
		
		Query query = session().createQuery(hql);
		query.setParameter("empId", leadAppraisal.getEmployee().getEmpId());
		
		List<Lead_Appraisal> lead_appraisals = query.list();
		return lead_appraisals;
	}

	public Lead_Appraisal getLeadAppraisalByLeadAppraisalId(Lead_Appraisal leadAppraisal) {
		Criteria crit = session().createCriteria(Lead_Appraisal.class);
		crit.add(Restrictions.eq("lead_appraisal_id", leadAppraisal.getLead_appraisal_id()));
		Lead_Appraisal getEditLeadAppraisal = (Lead_Appraisal)crit.uniqueResult(); 
		return getEditLeadAppraisal;
	}

	public void updateLeadAppraisal(Lead_Appraisal lead_Appraisal) {
		Criteria crit = session().createCriteria(Lead_Appraisal.class);
		crit.add(Restrictions.eq("lead_appraisal_id", lead_Appraisal.getLead_appraisal_id()));
		
		Lead_Appraisal updatedLeadAppraisal = (Lead_Appraisal)crit.uniqueResult();
		updatedLeadAppraisal.setStatus(lead_Appraisal.getStatus());
		updatedLeadAppraisal.setScore_skill(lead_Appraisal.getScore_skill());
		updatedLeadAppraisal.setScore_mentorship(lead_Appraisal.getScore_mentorship());
		updatedLeadAppraisal.setScore_task_completion(lead_Appraisal.getScore_task_completion());
		updatedLeadAppraisal.setScore_current_performance(lead_Appraisal.getScore_current_performance());
		updatedLeadAppraisal.setTotal_score(lead_Appraisal.getTotal_score());
		
		session().saveOrUpdate(updatedLeadAppraisal);
	}

	public void deleteLeadAppraisal(Lead_Appraisal lead_Appraisal) {
		Query query = session().createQuery("delete from Lead_Appraisal where lead_appraisal_id=:leadAppraisalId");
		query.setInteger("leadAppraisalId", lead_Appraisal.getLead_appraisal_id());
		query.executeUpdate();
	}

	@SuppressWarnings("unchecked")
	public List<Lead_Appraisal> getLeadAppraisals() {
		String hql = "from Lead_Appraisal";
		
		Query query = session().createQuery(hql);
		
		List<Lead_Appraisal> result = query.list();
		return result;
	}
}
