package com.subodh.struts.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.axis2.databinding.types.soapencoding.Decimal;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.json.JSONArray;
import org.json.JSONObject;

import sun.rmi.runtime.NewThreadAction;

import com.subodh.TblParticularsMaster;
import com.subodh.TblPartytypeMaster;
import com.subodh.TblStateMaster;
import com.subodh.TblCityMaster;
import com.subodh.TblPartyMaster;
import com.subodh.TblRoleMaster;
import com.subodh.TblPartydepartmenttypeMaster;
import com.esaya.util.QuickUtil;

public class ParticularsMaster extends DispatchAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_getName = "getName"; 

    // Local Forwards

    
    public ParticularsMaster() {
    }
    
    public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("PartyMaster.add()");
    	System.out.println(request.getParameter("name"));
    	System.out.println(request.getParameter("amount"));
    	try{
        	TblParticularsMaster objempcat = new TblParticularsMaster();
        	
        	//QuickUtil.doGetNextPK("tbl_runningid_master", "Run_Nos", "Run_Name = 'EMPCAT'");
        	String particularsid = QuickUtil.doGetNextPK("PARTICULARS");
        	objempcat.setParticularsId(particularsid);
        	objempcat.setParticularsName(request.getParameter("name"));
        	objempcat.setParticularsAmt(Long.parseLong((request.getParameter("amount"))));
        	        	
        	//System.out.println("PartyMaster.add()2");
        	QuickUtil.saveToNew(objempcat);
        	//System.out.println("PartyMaster.add()3");
        	response.setContentType("text/xml; charset=UTF-8");
	    	//response.setHeader("Cache-Control", "no-cache"); 
			response.getWriter().write("true");
        	
    	}catch(Exception ex){
    		System.out.println("addEmployeeMaster.execute()");
    		System.out.println(ex.getMessage());
    	}
    	return null;
        	
    }
    public ActionForward demo(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	System.out.println("ParticularsMaster.demo()");
    	return null;
    }
    /*public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("ParticularsMaster.execute()");
    	return null;
    }*/
    
    public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("ParticularsMaster.edit()");
    	System.out.println(request.getParameter("name"));
    	System.out.println(request.getParameter("amount"));
    	System.out.println(request.getParameter("particularsid"));
    	try{
    		
    		TblParticularsMaster objempcat = new TblParticularsMaster();
    		objempcat.setParticularsId(request.getParameter("particularsid"));
        	objempcat.setParticularsName(request.getParameter("name"));
        	objempcat.setParticularsAmt(Long.parseLong((request.getParameter("amount"))));
        	        	
        	//System.out.println("PartyMaster.add()2");
        	QuickUtil.updateToOld(objempcat);
        	//System.out.println("PartyMaster.add()3");
        	response.setContentType("text/xml; charset=UTF-8");
	    	//response.setHeader("Cache-Control", "no-cache"); 
			response.getWriter().write("true");
        	
    	}catch(Exception ex){
    		System.out.println("addEmployeeMaster.execute()");
    		System.out.println(ex.getMessage());
    	}
    	return null;
        	
    }
    
    public ActionForward getParticularsAll(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("PartyMaster.getParticularsAll()");
    	List<TblParticularsMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblParticularsMaster(), "TblParticularsMaster", "");//("select * from tbl_employeecategory_master");
		String [] returnvalue=null;
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			for (TblParticularsMaster objtemp : objempcat) {
				
				
				json = new JSONObject();
				
										
				String amt = String.valueOf(objtemp.getParticularsAmt());
				json.put("id", objtemp.getParticularsId());
				json.put("name", objtemp.getParticularsName());
				json.put("amount", amt );			
				
				jsonarr.put(intRow, json);
			
				intRow++;
				
			}
			
			
			System.out.println("Listarray: "+ jsonarr.toString());
			
			response.setContentType("text/xml; charset=UTF-8");
	    	//response.setHeader("Cache-Control", "no-cache"); 
			response.getWriter().write(jsonarr.toString());
			
    	return null;
    }
    return null;
    }
    
}
