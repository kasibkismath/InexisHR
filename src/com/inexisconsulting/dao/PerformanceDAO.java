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
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("performanceDao")
public class PerformanceDAO {

	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	public List<Performance> getPerformanceAppraisals() {
		return session().createQuery("from Performance").list();
	}

	public boolean checkPerformanceExists(Performance performance) throws HibernateException, ParseException {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from performance object
		Date date = performance.getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);

		// get count
		Query query = session()
				.createQuery("select count(*) from Performance where employee.emp_id = :emp_id" + " and date = :date");
		query.setParameter("emp_id", performance.getEmployee().getEmpId());
		query.setParameter("date", sdf.parse(stringDate));
		long count = ((Long) query.uniqueResult()).intValue();

		if (count == 1)
			return true;

		return false;
	}

	public Performance getPerformanceId(Performance performance) throws HibernateException, ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from performance object
		Date date = performance.getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);

		Criteria crit = session().createCriteria(Performance.class);
		crit.add(Restrictions.eq("employee.emp_id", performance.getEmployee().getEmpId()));
		crit.add(Restrictions.eq("date", sdf.parse(stringDate)));
		Performance getPerformance = (Performance) crit.uniqueResult();
		return getPerformance;
	}

	public int addPerformance(Performance performance) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from performance object
		Date date = performance.getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);

		// set date
		Date newDate = sdf.parse(stringDate);

		performance.setDate(newDate);

		session().saveOrUpdate(performance);
		int performance_id = performance.getPerformance_id();
		return performance_id;
	}

	public Long getSumOfTotalScore(Performance performance) throws HibernateException, ParseException {

		// initialize date format
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from performance object
		Date date = performance.getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);

		String sql = "select sum(teamLeadApp.total_score + hrApp.total_score + ceoApp.total_score)"
				+ " as sum from performance_appraisal as perfApp join team_lead_appraisal as teamLeadApp"
				+ " on perfApp.performance_id = teamLeadApp.performance_id join hr_appraisal as hrApp"
				+ " on perfApp.performance_id = hrApp.performance_id join ceo_appraisal as ceoApp"
				+ " on perfApp.performance_id = ceoApp.performance_id"
				+ " where perfApp.emp_id=:empId and perfApp.date=:date";

		Query query = session().createSQLQuery(sql);
		query.setParameter("empId", performance.getEmployee().getEmpId());
		query.setParameter("date", sdf.parse(stringDate));

		long sum = ((Number) query.uniqueResult()).longValue();
		return sum;
	}

	public Long getTotalScoreCount(Performance performance) throws HibernateException, ParseException {

		// initialize date format
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from performance object
		Date date = performance.getDate();

		// convert performance date to string
		String stringDate = sdf.format(date);
		
		// sql statement
		String sql = "select"
				+ " (select count(*) from team_lead_appraisal as leadApp inner join performance_appraisal"
				+ " as perfApp on leadApp.performance_id = perfApp.performance_id"
				+ " where perfApp.emp_id=:empId and perfApp.date=:date) +"
				+ " (select count(*) from hr_appraisal as hrApp inner join performance_appraisal"
				+ " as perfApp on hrApp.performance_id = perfApp.performance_id"
				+ " where perfApp.emp_id=:empId and perfApp.date=:date) +"
				+ " (select count(*) from ceo_appraisal as ceoApp inner join performance_appraisal"
				+ " as perfApp on ceoApp.performance_id = perfApp.performance_id"
				+ " where perfApp.emp_id=:empId and perfApp.date=:date) as Appraisal_Count";
		
		// process query with given parameters
		Query query = session().createSQLQuery(sql);
		query.setParameter("empId", performance.getEmployee().getEmpId());
		query.setParameter("date", sdf.parse(stringDate));

		long appraisalCount = ((Number) query.uniqueResult()).longValue();
		return appraisalCount;
	}

	public void updatePerformanceWithFinalScoreAndStatus(Performance performance) {
		
		Criteria crit = session().createCriteria(Performance.class);
		crit.add(Restrictions.eq("performance_id", performance.getPerformance_id()));
		
		Performance updatedPerformance = (Performance)crit.uniqueResult();
		updatedPerformance.setFinal_score(performance.getFinal_score());
		updatedPerformance.setStatus(performance.getStatus());
		
		session().saveOrUpdate(updatedPerformance);
	}
}
