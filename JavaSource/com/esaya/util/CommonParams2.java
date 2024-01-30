package com.esaya.util;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;

//import javax.faces.application.FacesMessage;
//import javax.faces.context.ExternalContext;
//import javax.faces.context.FacesContext;
//import javax.faces.event.ActionEvent;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import org.primefaces.context.RequestContext;
//
//import com.caddybook.TblCityMaster;
//import com.caddybook.TblUsergolfMaster;
//import com.caddybook.TblUsersessionDetails;
//import com.caddybook.services.UserMasterController;;
 
public class CommonParams2 {

 
//	public static <T> boolean  checkDuplicateEntryUpdate(T a,String tablename,String column,String oldid,String newid)
//	{
//		if(!oldid.equals(newid))
//		{
//			List retrieveWherClause = QuickUtil.retrieveWherClause(a, tablename, column+" != '"+oldid+"' AND "+column+" ='"+newid+"' ");
//			if(retrieveWherClause.size()>0)
//			{
//				return true;
//			}
//			else
//			{
//				return false;
//			}
//		}
//		else
//		{
//			return false;
//		}
//	}
//	
//	
//	/**
//	 * Acept cityid and return citty name
//	 * @param param is city id
//	 * @return
//	 */
//	public String doGetCityName(String param)
//	{
//		System.out.println("CommonParams2.doGetCityName()");
//		try {
//			if(param==null || param.trim().isEmpty())
//			{
//				System.err.println("Sorry the param was null");
//				return null;
//			}
//			List<TblCityMaster> retrieveWherClause = QuickUtil.retrieveWherClause(new TblCityMaster(), "TblCityMaster", "city_id='"+param+"' ");
//			if(retrieveWherClause.size()>0)
//			{
//				TblCityMaster tblCityMaster = retrieveWherClause.get(0);
//				return tblCityMaster.getCityName();
//			}
//		} catch (Exception e) {
//			System.err.println("Sorry error here "+e.getMessage());
//			e.printStackTrace();
//		}
//		return "";
//	}
//
//	/**
//	 * If user is not logged then redirect to loginpage
//	 * 
//	 * @param sessionname
//	 * @param urltoredirect
//	 */
//	public void checkCredentialsForLoggedOut(String sessionname,
//			String urltoredirect) {
//		ExternalContext ctx = FacesContext.getCurrentInstance()
//				.getExternalContext();
//		HttpSession session = (HttpSession) ctx.getSession(false);
//
//		if (session.getAttribute(sessionname) != null) {
//			HttpServletResponse resp = (HttpServletResponse) ctx.getResponse();
//			 
//			 
//			if (sessionname.equals("userMaster")) {
//				UserMasterController user2 = (UserMasterController) session
//						.getAttribute(sessionname);
//				
//				if (user2.getUUserName() != null
//						&& user2.getUUserName().isEmpty() == false) {
//					CommonParams2.showMessageOnLog(getClass(),
//							"checkcredentials user2 is not null");
//					return;
//				}
//			}
//			CommonParams2.showMessageOnLog(getClass(),
//					"checkCredentials working before redirect");
//			// resp.sendRedirect(urltoredirect);
//			try {
//				ctx.redirect(urltoredirect);
//			} catch (IOException e) {
//				System.out
//						.println("checkCredentialsForLoggedOut mehod cannot redirect");
//				e.printStackTrace();
//			}
//
//			CommonParams2.showMessageOnLog(getClass(),
//					"checkCredentials working after redirect");
//
//		} else {
//			CommonParams2.showMessageOnLog(getClass(),
//					"checkCredentials working before redirect");
//			// resp.sendRedirect(urltoredirect);
//			try {
//				ctx.redirect(urltoredirect);
//			} catch (IOException e) {
//				System.out
//						.println("checkCredentialsForLoggedOut mehod cannot redirect");
//				e.printStackTrace();
//			}
//
//		}
//
//	}
//
//	/**
//	 * If user is already logged in direct to the required page
//	 * 
//	 * @param sessionname
//	 * @param urltoredirect
//	 */
//	public void checkCredentialsForLoggedIn(String sessionname,
//			String urltoredirect) {
//		ExternalContext ctx = FacesContext.getCurrentInstance()
//				.getExternalContext();
//
//		HttpSession session = (HttpSession) ctx.getSession(false);
//		Map<String, Object> sessionMap = ctx.getSessionMap();
//		for (String va2 : sessionMap.keySet()) {
//
//			System.out.println(" Key is :" + va2 + " Value is :"
//					+ sessionMap.get(va2));
//		}
//		if (session.getAttribute(sessionname) != null) {
//			HttpServletResponse resp = (HttpServletResponse) ctx.getResponse();
//			 
//			 
//			 
//			if (sessionname.equals("userMaster")) {
//				UserMasterController user2 = (UserMasterController) session
//						.getAttribute(sessionname);
//				if (user2.getUUserName() == null
//						|| user2.getUUserName().isEmpty()) {
//					CommonParams2.showMessageOnLog(getClass(),
//							"checkCredentials usermaster is null");
//					return;
//				}
//			}
//			try {
//				CommonParams2.showMessageOnLog(getClass(),
//						"checkCredentials working before redirect");
//				// resp.sendRedirect(urltoredirect);
//				ctx.redirect(urltoredirect);
//
//				CommonParams2.showMessageOnLog(getClass(),
//						"checkCredentials working after redirect");
//
//			} catch (IOException e) {
//				System.out
//						.println("checkCredentialsForLoggedIn mehod cannot redirect");
//				e.printStackTrace();
//			}
//		}
//
//	}
//	public static void showMessageOnScreen(String message) {
//		FacesContext context = FacesContext.getCurrentInstance();
//		context.addMessage("growlkey" ,new FacesMessage(message, message));
//	}
//	
//	public static void executeCommand(String message)
//	{
//		System.out.println("CommonParams2.showDialogBox()");
//		RequestContext currentInstance = RequestContext.getCurrentInstance();
//		String command=message;
//		if(currentInstance!=null)
//		{
//			System.out.println("In Requestcontext method");
//			currentInstance.execute(command);
//			
//		}
//		else
//		{
//			System.err.println("Sorry Mith RequestContext is null");
//		}
//		System.out.println("Shown command from server = "+command);
//	}
//	
//	
//	public static void showAlertBox(String message)
//	{
//		System.out.println("CommonParams2.showAlertBox()");
//		RequestContext currentInstance = RequestContext.getCurrentInstance();
//		String command="alert('"+message+"')";
//		if(currentInstance!=null)
//		{
//			System.out.println("In Requestcontext method");
//			currentInstance.execute(command);
//			
//		}
//		else
//		{
//			System.err.println("Sorry Mith RequestContext is null");
//		}
//		System.out.println("Shown Alert from server = "+command);
//	}
//	/* 
//	 * Java Script to refresh page 
//	 */
//	public static void refreshPage()
//	{
//		System.out.println("CommonParams2.refreshPage()");
//		RequestContext currentInstance = RequestContext.getCurrentInstance();
//		
//		String command="document.location.reload(true)";
//		if(currentInstance!=null)
//		{
//			System.out.println("In Requestcontext method");
//			currentInstance.execute(command);
//			
//		}
//		else
//		{
//			System.err.println("Sorry Mith RequestContext is null");
//		}
//		System.out.println("done calling refreshpage");
//	}
//
//	public static void showMessageOnLog(Class a, String message) {
//		Logger l = Logger.getLogger(a.getName());
//		l.setLevel(Level.INFO);
//		// l.warning(message);
//		l.info(message);
//	}
//	
//	public static Boolean sendMail2(String emailto,String firstname)
//	{
//		final String username = "atulmith@gmail.com";
//		final String password = "opentaps";
// 
//		Properties props = new Properties();
//		props.put("mail.smtp.auth", "true");
//		props.put("mail.smtp.starttls.enable", "true");
//		props.put("mail.smtp.host", "smtp.gmail.com");
//		props.put("mail.smtp.port", "587");
// 
//		Session session = Session.getInstance(props,
//		  new javax.mail.Authenticator() {
//			protected PasswordAuthentication getPasswordAuthentication() {
//				return new PasswordAuthentication(username, password);
//			}
//		  });
//		String message2="Hello "+firstname+" , \n";
//		message2+="\n To Activate hit this URL: http://wwww.fasttechinfo.biz:8080/CaddyBook/1-start.jsp?UserId=5345&Activate=true";
//		message2+="\n To Deactivate hit this url: http://wwww.fasttechinfo.biz:8080/CaddyBook/1-start.jsp?UserId=893&Activate=false";
//		try {
// 
//			Message message = new MimeMessage(session);
//			message.setFrom(new InternetAddress("atulmith@gmail.com"));
//			message.setRecipients(Message.RecipientType.TO,
//				InternetAddress.parse(emailto));
//			message.setSubject("Testing Subject");
//			message.setText(message2);
// 
//			Transport.send(message);
// 
//			System.out.println("Done");
//			return true;
// 
//		} catch (Exception e) {
//			System.err.println("Sorry sending error " +e.getMessage());
//			e.printStackTrace();
//			return false;
//		}
//	}
//	
//	public static long saveToSession(TblUsergolfMaster objUserMasterParam, String loginType){
//		System.out.println("CommonParams2.saveToSession()");
//		try{
//			
//			long sessionid2 = new Date().getTime();
//			
//			TblUsersessionDetails objUserSess = new TblUsersessionDetails();
//			
//			objUserSess.setUsersessId(sessionid2);
//			objUserSess.setTblUsergolfMaster(objUserMasterParam);
//			objUserSess.setUsersessLogintime(new Date());
//			objUserSess.setUsersessLogouttime(null);
//			objUserSess.setUsersessTimespend( 0l);
//			objUserSess.setUsersessLogintype(loginType);
//			
//			QuickUtil.saveToNew(objUserSess);
//			
//			System.out.println("DONE Saving UserSession");
//			return sessionid2;
//			
//		}catch(Exception ex1)
//		{
//			System.err.println("Exception: " + ex1.getMessage());
//			
//			return 0;
//		}
//	//return 0;
//		
//	}
//	
//	public String destroySessions(String e)
//	{
//		ExternalContext ctx = FacesContext.getCurrentInstance()
//				.getExternalContext();
//		 Map<String, Object> sessionMap = ctx.getSessionMap();
//		 System.out.println("No of sessions ="+sessionMap.size());
//		 for (String key2 : sessionMap.keySet()) {
//			
//			System.out.println("Session name="+sessionMap.get(key2)); 
//			String packagename = sessionMap.get(key2).getClass().getPackage().getName();
//			HttpSession session = (HttpSession) ctx.getSession(false);
//			if(sessionMap.get(key2) instanceof UserMasterController)
//			{
//				System.out.println("not Deleting user master controller");
//				//session.removeAttribute(key2);
//			}
//			else if(packagename.contains("caddybook.services"))
//			{
//				System.out.println("Deleting service ="+key2);
//				session.removeAttribute(key2);
//			}
//			
//		 }
//		 return e;
////		return retvalue + "?redirect=true";
//	}
 }
