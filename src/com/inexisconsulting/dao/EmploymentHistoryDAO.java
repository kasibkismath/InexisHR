package com.inexisconsulting.dao;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
@Component("employmentHistoryDAO")
public class EmploymentHistoryDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	public void addEmploymentHistory(EmploymentHistory empHistory) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		Date date = new Date();
		String stringDate = sdf.format(date);
		
		empHistory.setAddedDate(sdf.parse(stringDate));
		
		session().saveOrUpdate(empHistory);
	}

	@SuppressWarnings("unchecked")
	public List<EmploymentHistory> getEmpHistory() {
		String hql = "from EmploymentHistory order by employee.firstName, employee.lastName";
		
		Query query = session().createQuery(hql);
		
		List<EmploymentHistory> employmentHistories = query.list();
		return employmentHistories;
	}

	public void updateEmpHistory(EmploymentHistory empHistory) throws ParseException {
		// format
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date effectiveDate = empHistory.getEffectiveDate();
		String stringEffectiveDate = sdf.format(effectiveDate);
		
		Criteria crit = session().createCriteria(EmploymentHistory.class);
		crit.add(Restrictions.eq("emp_history_id", empHistory.getEmp_history_id()));

		EmploymentHistory updateEmpHistory= (EmploymentHistory) crit.uniqueResult();
		updateEmpHistory.setEffectiveDate(sdf.parse(stringEffectiveDate));
		
		session().saveOrUpdate(updateEmpHistory);
	}

	public EmploymentHistory getEmpHistoryById(EmploymentHistory empHistory) {
		Criteria crit = session().createCriteria(EmploymentHistory.class);
		crit.add(Restrictions.eq("emp_history_id", empHistory.getEmp_history_id()));
		EmploymentHistory result = (EmploymentHistory) crit.uniqueResult();
		return result;
	}

}
