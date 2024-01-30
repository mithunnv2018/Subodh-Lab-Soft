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
import com.subodh.TblTaxheadMaster;
import com.esaya.util.QuickUtil;

public class TaxHeadMaster extends DispatchAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_getName = "getName"; 

    // Local Forwards

    
    public TaxHeadMaster() {
    }
    
    public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("TaxHeadMaster.add()");
    	System.out.println(request.getParameter("txttaxheadname"));
    	System.out.println(request.getParameter("txtpercent"));
    	System.out.println(request.getParameter("drpyear"));
    	System.out.println(request.getParameter("drpstatus"));
    	try{
        	TblTaxheadMaster objempcat = new TblTaxheadMaster();
        	
        	//QuickUtil.doGetNextPK("tbl_runningid_master", "Run_Nos", "Run_Name = 'EMPCAT'");
        	String taxheadid = QuickUtil.doGetNextPK("TAXHEAD");
        	objempcat.setTaxheadId(taxheadid);
        	objempcat.setTaxheadName(request.getParameter("txttaxheadname"));
        	objempcat.setTaxheadPercent(Double.valueOf(request.getParameter("txtpercent")));
        	objempcat.setTaxheadStatus(request.getParameter("drpstatus"));
        	objempcat.setTaxheadYear(request.getParameter("drpyear"));
        	
        	      	
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
  
    /*public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("ParticularsMaster.execute()");
    	return null;
    }*/
    
    public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("TaxHeadMaster.edit()");
    	System.out.println(request.getParameter("txttaxheadname"));
    	System.out.println(request.getParameter("txtpercent"));
    	System.out.println(request.getParameter("drpyear"));
    	System.out.println(request.getParameter("drpstatus"));
    	try{
    		
    		TblTaxheadMaster objempcat = new TblTaxheadMaster();
    		
    		
    		objempcat.setTaxheadId(request.getParameter("taxid"));
        	objempcat.setTaxheadName(request.getParameter("txttaxheadname"));
        	objempcat.setTaxheadPercent(Double.valueOf(request.getParameter("txtpercent")));
        	objempcat.setTaxheadStatus(request.getParameter("drpstatus"));
        	objempcat.setTaxheadYear(request.getParameter("drpyear"));
        	
        	        	
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
    
    public ActionForward getTaxheadAll(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("TaxHeadMaster.getTaxheadAll()");
    	List<TblTaxheadMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblTaxheadMaster(), "TblTaxheadMaster", "");//("select * from tbl_employeecategory_master");
		String [] returnvalue=null;
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			for (TblTaxheadMaster objtemp : objempcat) {
								
				json = new JSONObject();
														
				String percent = String.valueOf(objtemp.getTaxheadPercent());
				json.put("id", objtemp.getTaxheadId());
				json.put("name", objtemp.getTaxheadName());
				json.put("year", objtemp.getTaxheadYear() );	
				json.put("percent", percent );	
				json.put("status",  objtemp.getTaxheadStatus() );	
				
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
