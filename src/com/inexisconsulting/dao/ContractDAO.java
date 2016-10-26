package com.inexisconsulting.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Component("contractDAO")
public class ContractDAO {
	
	@Autowired
	private SessionFactory sessionFactory;

	public Session session() {
		return sessionFactory.getCurrentSession();
	}

	public void addContract(Contract contract) {
		session().saveOrUpdate(contract);
	}

	public int getFilesCountByEmpId(Contract contract) {
		String sql = "select count(*) from contract where emp_id=:empId";
		
		Query query = session().createSQLQuery(sql);
		query.setParameter("empId", contract.getEmployee().getEmpId());
		
		if (query.uniqueResult() == null) {
			return 0;
		} else {
			int count = ((Number) query.uniqueResult()).intValue();
			
			return count;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Contract> getAllContracts() {
		return session().createQuery("from Contract").list();
	}

	public void deleteContractInfoFromDB(Contract contract) {
		Query query = session().createQuery("delete from Contract where contract_id=:contractId");
		query.setInteger("contractId", contract.getContract_id());
		query.executeUpdate();
	}

}
