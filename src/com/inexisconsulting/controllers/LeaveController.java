package com.inexisconsulting.controllers;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.dao.Leave;
import com.inexisconsulting.dao.Leave_Type;
import com.inexisconsulting.service.LeaveService;
import com.inexisconsulting.service.LeaveTypeService;

@Controller
public class LeaveController {

	@Autowired
	private LeaveService leaveService;

	@Autowired
	private LeaveTypeService leaveTypeService;

	@RequestMapping("/Leave")
	@SuppressWarnings("unchecked")
	public String showLeaveMainPage(Model model, Principal principal) {

		// get current role
		Collection<SimpleGrantedAuthority> authorities = (Collection<SimpleGrantedAuthority>) SecurityContextHolder
				.getContext().getAuthentication().getAuthorities();

		// get logged in username and user role
		String loggedInUser = principal.getName();
		model.addAttribute("loggedInUser", loggedInUser);
		model.addAttribute("loggedInUserRole", authorities);

		return "Leave/leaveMain";
	}

	// get all leave types
	@RequestMapping(value = "/Leave/GetLeaveTypes", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public List<Leave_Type> getLeaveTypes() {
		List<Leave_Type> leaveTypes = leaveTypeService.getLeaveTypes();
		return leaveTypes;
	}

	// get all leaves for an employee for the current year.
	@RequestMapping(value = "/Leave/GetLeavesForLoggedInEmployee", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Leave> getLeavesForLoggedInEmployeeByYear(@RequestBody Leave leave) {
		List<Leave> leaves = leaveService.getLeavesForLoggedInEmployeeByYear(leave);
		return leaves;
	}

	// get causal leave type id
	@RequestMapping(value = "/Leave/GetCasualLeaveTypeId", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public int getCasualLeaveTypeId() {
		return leaveTypeService.getCasualLeaveTypeId();
	}

	// get leave by leave_id
	@RequestMapping(value = "/Leave/GetLeaveByLeaveId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Leave getLeaveByLeaveId(@RequestBody Leave leave) {
		return leaveService.getLeaveByLeaveId(leave);
	}

	// get medical leave type id
	@RequestMapping(value = "/Leave/GetMedicalLeaveTypeId", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public int getMedicalLeaveTypeId() {
		return leaveTypeService.getMedicalLeaveTypeId();
	}

	// get all leave types
	@RequestMapping(value = "/Leave/GetLeaveTypeId", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Leave_Type getLeaveTypeId(@RequestBody Leave_Type leaveType) {
		return leaveTypeService.getLeaveTypeId(leaveType);
	}

	// get leave no of days sum by year and leave type
	@RequestMapping(value = "/Leave/GetLeaveSumByLeaveTypeAndYear", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Long getLeaveSumByLeaveTypeAndYear(@RequestBody Leave leave) {
		return leaveService.getLeaveSumByLeaveTypeAndYear(leave);
	}

	// get leave no of days sum by year for casual and medical leaves
	@RequestMapping(value = "/Leave/GetLeaveSumByYearForCausalAndMedicalLeaves", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public float getLeaveSumByYearForCausalAndSickLeaves(@RequestBody Leave leave) {
		return leaveService.getLeaveSumByYearForCausalAndMedicalLeaves(leave);
	}

	// check for duplicate leave
	@RequestMapping(value = "/Leave/CheckDuplicateLeave", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public boolean checkDuplicateLeave(@RequestBody Leave leave) throws HibernateException, ParseException {
		return leaveService.checkDuplicateLeave(leave);
	}

	// add leave
	@RequestMapping(value = "/Leave/AddLeave", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void addLeave(@RequestBody Leave leave) throws ParseException {
		leaveService.addLeave(leave);
	}

	// add leave
	@RequestMapping(value = "/Leave/UpdateLeave", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void updateLeave(@RequestBody Leave leave) throws ParseException {
		leaveService.updateLeave(leave);
	}

	// send mail to leave request
	@RequestMapping(value = "/Leave/SendLeaveRequestMail", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void sendLeaveRequestMail(@RequestBody Leave leave) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		final String username = "kasibtest@gmail.com";
		final String password = "kasibtest@123";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});

		String ceoEmailId = "kasib@inexisconsulting.com";
		String empEmailId = "kasibkismath@gmail.com";

		String fromDate = sdf.format(leave.getLeave_from());
		String toDate = sdf.format(leave.getLeave_to());

		try {
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress("kasibtest@gmail.com", "Inexis Consulting"));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(ceoEmailId + "," + empEmailId));
			message.setSubject("Leave Request Notification (" + leave.getLeaveType().getName() + ") by: "
					+ leave.getEmployee().getFirstName() + " " + leave.getEmployee().getLastName());
			message.setText("Hi, \n\nI will be on " + leave.getLeaveType().getName() + " from " + fromDate + " to "
					+ toDate + " (" + leave.getLeave_option() + ").\n\nReason : " + leave.getReason()
					+ "\n\n\nThank You, \n" + leave.getEmployee().getFirstName() + " "
					+ leave.getEmployee().getLastName());
			Transport.send(message);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Sending email failed");
		}
	}
	
	// send mail to leave request
		@RequestMapping(value = "/Leave/SendUpdatedLeaveRequestMail", method = RequestMethod.POST, produces = "application/json")
		@ResponseBody
		public void sendUpdatedLeaveRequestMail(@RequestBody Leave leave) {

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			final String username = "kasibtest@gmail.com";
			final String password = "kasibtest@123";

			Properties props = new Properties();
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");

			Session session = Session.getInstance(props, new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(username, password);
				}
			});

			String ceoEmailId = "kasib@inexisconsulting.com";
			String empEmailId = "kasibkismath@gmail.com";

			String fromDate = sdf.format(leave.getLeave_from());
			String toDate = sdf.format(leave.getLeave_to());

			try {
				Message message = new MimeMessage(session);
				message.setFrom(new InternetAddress("kasibtest@gmail.com", "Inexis Consulting"));
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(ceoEmailId + "," + empEmailId));
				message.setSubject("Updated Leave Request Notification (" + leave.getLeaveType().getName() + ") by: "
						+ leave.getEmployee().getFirstName() + " " + leave.getEmployee().getLastName());
				message.setText("Hi, \n\nI will be on " + leave.getLeaveType().getName() + " from " + fromDate + " to "
						+ toDate + " (" + leave.getLeave_option() + ").\n\nReason : " + leave.getReason()
						+ "\n\n\nThank You, \n" + leave.getEmployee().getFirstName() + " "
						+ leave.getEmployee().getLastName());
				Transport.send(message);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("Sending email failed");
			}
		}
}