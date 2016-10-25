package com.inexisconsulting.controllers;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.security.Principal;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.inexisconsulting.dao.Contract;
import com.inexisconsulting.service.ContractService;

@Controller
public class ContractsController {

	@Autowired
	private ContractService contractService;

	private static final String FILE_PATH = "E:\\Eclipse Mars Working Files\\InexisHR\\WebContent"
			+ "\\resources\\Employee Contracts\\";
	private static final String APPLICATION_PDF = "application/pdf";

	@RequestMapping("/Contracts")
	@SuppressWarnings("unchecked")
	public String showContractsMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Contracts/contractsMain";
	}

	// get all contracts
	@RequestMapping(value = "/Contracts/GetAllContracts", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Contract> getAllContracts() {
		return contractService.getAllContracts();
	}

	// add new contract
	@RequestMapping(value = "/Contracts/AddContract", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addContract(@RequestBody Contract contract) {
		contractService.addContract(contract);
	}

	// get files count by empId
	@RequestMapping(value = "/Contracts/GetFilesCountByEmpId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public int getFilesCountByEmpId(@RequestBody Contract contract) {
		return contractService.getFilesCountByEmpId(contract);
	}

	@RequestMapping(value = "/Contracts/ContractsFileUpload", method = RequestMethod.POST)
	@ResponseBody
	public void fileUpload(@RequestParam("fileName") String fileName, @RequestParam("file") MultipartFile file,
			HttpServletRequest request) {

		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();

				String fullPath = "E:\\Eclipse Mars Working Files\\InexisHR\\WebContent"
						+ "\\resources\\Employee Contracts\\";

				// Create the file on server
				File serverFile = new File(fullPath + File.separator + fileName);

				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();

			} catch (Exception e) {
				System.out.println(e);
			}
		} else {
			System.out.println("Couldn't upload file");
		}
	}

	private File getFile(String fileName) throws FileNotFoundException {
		File file = new File(FILE_PATH + fileName);
		if (!file.exists()) {
			throw new FileNotFoundException("file with path: " + FILE_PATH + "Declaration-2.pdf" + " was not found.");
		}
		return file;
	}

	@RequestMapping(value = "/Contracts/DownloadContract", method = RequestMethod.GET, 
			produces = "application/pdf")
	
	public @ResponseBody Resource downloadContract
	(HttpServletRequest request, HttpServletResponse response, @RequestParam("fileName") String fileName) throws FileNotFoundException {
		
		File file = getFile(fileName);
	    response.setContentType(APPLICATION_PDF);
	    response.setHeader("Content-Disposition", "attachment; filename=" + file.getName());
	    response.setHeader("Content-Length", String.valueOf(file.length()));
	    return new FileSystemResource(file);
		
	}
}
