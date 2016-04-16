package com.inexisconsulting.controllers;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.inexisconsulting.service.UserService;

@Controller
public class MainController {

	@Autowired
	private UserService userService;

	@RequestMapping("/header")
	public String headerPage() {
		return "header";
	}

	@RequestMapping(value = "/backupDatabase", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public Map<String, Boolean> backupDataWithDatabase() {

		String dumpExePath = "mysqldump";
		String host = "localhost";
		String port = "3306";
		String user = "root";
		String password = "RootAdmin@123";
		String database = "test";
		String backupPath = System.getProperty("user.home")+"\\Downloads\\";
		
		boolean status = false;
		try {
			DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy 'at time' HH-mm-ss");
			Date date = new Date();
			String filepath =  database + "-DB-Backup-" + dateFormat.format(date) + ".sql";
			
			String batchCommand = "";
			if (password != "") {
				// Backup with database
				batchCommand = dumpExePath + " -h " + host + " --port " + port + " -u " + user +" -p" + password
						+ " --add-drop-database -B " + database + " -r \"" + backupPath + "" + filepath + "\"";
			} else {
				batchCommand = dumpExePath + " -h " + host + " --port " + port + " -u " + user
						+ " --add-drop-database -B " + database + " -r \"" + backupPath + "" + filepath + "\"";
			}

			Process runtime = Runtime.getRuntime().exec(batchCommand);
			int processComplete = runtime.waitFor();

			if (processComplete == 0) {
				status = true;
			} else {
				status = false;
			} 
		} catch (IOException ioe) {
			System.out.println(ioe);
		} catch (Exception e) {
			System.out.println(e);
		}
		return Collections.singletonMap("success", status);
	}
	
	@RequestMapping(value = "/restoreDatabase", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public Map<String, Boolean> restoreDatabase(@RequestBody Map<String, Object> data) {
		String dbUserName = "root";
		String dbPassword = "RootAdmin@123";
		String database = "test";
		String source = "C:\\Users\\Kasib\\Desktop\\" + data.get("fileName").toString();
		 
        String[] executeCmd = new String[]{"mysql", "--user=" + dbUserName, "--password=" + dbPassword, "-e", "source " + source};
        
        boolean status = false;
        Process runtimeProcess;
        try {
            runtimeProcess = Runtime.getRuntime().exec(executeCmd);
            int processComplete = runtimeProcess.waitFor();
 
            if (processComplete == 0) {
                status = true;
            }
        } catch (Exception ex) {
           System.out.println(ex);
        }
        return Collections.singletonMap("success", status);
    }
}
