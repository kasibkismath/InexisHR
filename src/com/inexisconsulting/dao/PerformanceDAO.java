package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

	public Long getSumOfTotalScore(Performance performance) {

		String sql = "select sum(total_score) as totalScore from ( "
				+ "select sum(team_lead_appraisal.total_score) as total_score from team_lead_appraisal "
				+ "where team_lead_appraisal.performance_id=:performanceId "
				+ "union "
				+ "select sum(hr_appraisal.total_score) as total_score from hr_appraisal "
				+ "where hr_appraisal.performance_id=:performanceId "
				+ "union "
				+ "select sum(ceo_appraisal.total_score) as total_score from ceo_appraisal "
				+ "where ceo_appraisal.performance_id=:performanceId "
				+ ") as totalScore;";

		Query query = session().createSQLQuery(sql);
		query.setParameter("performanceId", performance.getPerformance_id());

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

	@SuppressWarnings("unchecked")
	public List<Object[]> getTotalScoresForEmployeeByLeadId(Team_And_Performance teamAndPerformance) throws HibernateException, ParseException {
		
		Team team = teamAndPerformance.getTeam();
		Performance performance = teamAndPerformance.getPerformance();
		
		// initialize date format
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from performance object
		Date date = performance.getDate();
		
		Calendar prevYear = Calendar.getInstance();
	    prevYear.add(Calendar.YEAR, -1);
	    
	    Calendar now = Calendar.getInstance();
	    int currentYear = now.get(Calendar.YEAR);
	    
	    int previousYear = prevYear.get(Calendar.YEAR);
	   
	    String previousYearString = previousYear + "-12-31";
	    
	    Date previousYearDate = sdf.parse(previousYearString);

		// convert performance date to string
		String stringDate = sdf.format(date);
		String stringPreviousYearDate = sdf.format(previousYearDate);
		
		String sql = "select EmpName, "
				+ "SUM(CASE WHEN appraisalYear=:PrevYear THEN totalScore ELSE 0 END) `PreviousYear`, "
				+ "SUM(CASE WHEN appraisalYear=:CurrYear THEN totalScore ELSE 0 END) `CurrentYear` "
				+ "from ( "
				+ "select concat(employee.firstName,' ',employee.lastName) as EmpName, "
				+ "year(performance_appraisal.date) as appraisalYear,  "
				+ "team_lead_appraisal.total_score as totalScore from employee "
				+ "join performance_appraisal on employee.emp_id = performance_appraisal.emp_id "
				+ "join team_lead_appraisal on performance_appraisal.performance_id = team_lead_appraisal.performance_id "
				+ "join team on team_lead_appraisal.team_id = team.team_id where "
				+ "team.emp_id_lead=:empId and employee.status=:statusSet "
				+ "and (performance_appraisal.date=:date or performance_appraisal.date=:previousYearDate) "
				+ "group by EmpName, appraisalYear, team_lead_appraisal.total_score "
				+ "order by EmpName, appraisalYear "
				+ ") as Result "
				+ "group by EmpName";
		
		// process query with given parameters
		Query query = session().createSQLQuery(sql);
		query.setParameter("empId", team.getEmployee().getEmpId());
		query.setParameter("date", sdf.parse(stringDate));
		query.setParameter("previousYearDate", previousYearDate);
		query.setParameter("statusSet", true);
		query.setParameter("PrevYear", previousYear);
		query.setParameter("CurrYear", currentYear);
		
		List<Object[]> result = query.list();
		return result;
	};
	
	@SuppressWarnings("unchecked")
	public List<Object[]> getTotalScoresForEmployeeByHR(Performance performance) throws HibernateException, ParseException {
				
		// initialize date format
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		// date from performance object
		Date date = performance.getDate();
		
		Calendar prevYear = Calendar.getInstance();
	    prevYear.add(Calendar.YEAR, -1);
	    
	    Calendar now = Calendar.getInstance();
	    int currentYear = now.get(Calendar.YEAR);
	    
	    int previousYear = prevYear.get(Calendar.YEAR);
	   
	    String previousYearString = previousYear + "-12-31";
	    
	    Date previousYearDate = sdf.parse(previousYearString);

		// convert performance date to string
		String stringDate = sdf.format(date);
		String stringPreviousYearDate = sdf.format(previousYearDate);
		
		String sql = "select EmpName, "
				+ "SUM(CASE WHEN appraisalYear=:PrevYear THEN totalScore ELSE 0 END) `PreviousYear`, "
				+ "SUM(CASE WHEN appraisalYear=:CurrYear THEN totalScore ELSE 0 END) `CurrentYear` "
				+ "from ( "
				+ "select concat(employee.firstName,' ',employee.lastName) as EmpName, "
				+ "year(performance_appraisal.date) as appraisalYear,  "
				+ "hr_appraisal.total_score as totalScore "
				+ "from employee "
				+ "join performance_appraisal "
				+ "on employee.emp_id = performance_appraisal.emp_id "
				+ "join hr_appraisal "
				+ "on performance_appraisal.performance_id = hr_appraisal.performance_id "
				+ "where "
				+ "employee.status=:statusSet "
				+ "and (performance_appraisal.date=:date or performance_appraisal.date=:previousYearDate) "
				+ "group by EmpName, appraisalYear, totalScore "
				+ "order by EmpName, appraisalYear "
				+ ") as Result "
				+ "group by EmpName";
		
		// process query with given parameters
		Query query = session().createSQLQuery(sql);
		query.setParameter("date", sdf.parse(stringDate));
		query.setParameter("previousYearDate", previousYearDate);
		query.setParameter("statusSet", true);
		query.setParameter("PrevYear", previousYear);
		query.setParameter("CurrYear", currentYear);
		
		List<Object[]> result = query.list();
		return result;
	};
}
