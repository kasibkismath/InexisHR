package com.inexisconsulting.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.inexisconsulting.dao.Contract;
import com.inexisconsulting.dao.ContractDAO;

@Service("contractService")
public class ContractService {
	
	@Autowired
	private ContractDAO contractDao;

	public void addContract(Contract contract) {
		contractDao.addContract(contract);
	}

	public int getFilesCountByEmpId(Contract contract) {
		return contractDao.getFilesCountByEmpId(contract);
	}

	public List<Contract> getAllContracts() {
		return contractDao.getAllContracts();
	}

	public void deleteContractInfoFromDB(Contract contract) {
		contractDao.deleteContractInfoFromDB(contract);
	}
	
	
}
