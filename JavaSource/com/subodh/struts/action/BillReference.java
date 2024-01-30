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

import com.mysql.jdbc.jdbc2.optional.SuspendableXAConnection;
import com.subodh.TblBillreferencesMaster;
import com.subodh.TblParticularsMaster;
import com.subodh.TblPartytypeMaster;
import com.subodh.TblStateMaster;
import com.subodh.TblCityMaster;
import com.subodh.TblPartyMaster;
import com.subodh.TblRoleMaster;
import com.subodh.TblPartydepartmenttypeMaster;
import com.esaya.util.QuickUtil;

public class BillReference extends DispatchAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_getName = "getName"; 

    // Local Forwards

    
    public BillReference() {
    }
    
    public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("BillReference.add()");
    	System.out.println(request.getParameter("name"));
    
    	try{
        	TblBillreferencesMaster objempcat = new TblBillreferencesMaster();
        	
        	//QuickUtil.doGetNextPK("tbl_runningid_master", "Run_Nos", "Run_Name = 'EMPCAT'");
        	String particularsid = QuickUtil.doGetNextPK("BILLREF");
        	objempcat.setReferenceId(particularsid);
        	objempcat.setReferenceName(request.getParameter("name"));
        
        	        	
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
    	
    	System.out.println("BillReference.edit()");
    	System.out.println(request.getParameter("name"));
    	
    	System.out.println(request.getParameter("referenceid"));
    	try{
    		
    		TblBillreferencesMaster objempcat = new TblBillreferencesMaster();
    		objempcat.setReferenceId(request.getParameter("referenceid"));
        	objempcat.setReferenceName(request.getParameter("name"));
        	        	
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
    
    public ActionForward getBillReferencesAll(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("BillReference.getBillReferencesAll()");
    	List<TblBillreferencesMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblBillreferencesMaster(), "TblBillreferencesMaster", "");//("select * from tbl_employeecategory_master");
		String [] returnvalue=null;
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			for (TblBillreferencesMaster objtemp : objempcat) {
				
				
				json = new JSONObject();
				
										
				
				json.put("id", objtemp.getReferenceId());
				json.put("name", objtemp.getReferenceName());
						
				
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
