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
import com.subodh.TblSubtaxheadMaster;
import com.subodh.TblTaxheadMaster;
import com.esaya.util.QuickUtil;

public class SubTaxHeadMaster extends DispatchAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_getName = "getName"; 

    // Local Forwards

    
    public SubTaxHeadMaster() {
    }
    
    public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("SubTaxHeadMaster.add()");
    	System.out.println(request.getParameter("txtsubtaxheadname"));
    	System.out.println(request.getParameter("txtpercent"));
    	System.out.println(request.getParameter("drptaxhead"));
    	System.out.println(request.getParameter("drpyear"));
    	System.out.println(request.getParameter("drpstatus"));
    	try{
        	TblSubtaxheadMaster objempcat = new TblSubtaxheadMaster();
        	
        	//QuickUtil.doGetNextPK("tbl_runningid_master", "Run_Nos", "Run_Name = 'EMPCAT'");
        	String subtaxheadid = QuickUtil.doGetNextPK("SUBTAXHEAD");
        	objempcat.setSubtaxheadId(subtaxheadid);
        	objempcat.setSubtaxheadName(request.getParameter("txtsubtaxheadname"));
        	objempcat.setSubtaxheadPercent(Double.valueOf(request.getParameter("txtpercent")));
        	objempcat.setSubtaxheadStatus(request.getParameter("drpstatus"));
        	objempcat.setSubtaxheadYear(request.getParameter("drpyear"));
        	objempcat.setTaxheadId(request.getParameter("drptaxhead"));
        	
        	        	      	
        	//System.out.println("PartyMaster.add()2");
        	QuickUtil.saveToNew(objempcat);
        	//System.out.println("PartyMaster.add()3");
        	response.setContentType("text/xml; charset=UTF-8");
	    	//response.setHeader("Cache-Control", "no-cache"); 
			response.getWriter().write("true");
        	
    	}catch(Exception ex){
    		
    		System.out.println(ex.getMessage());
    		ex.printStackTrace();
    		response.getWriter().write("false");
    	}
    	return null;
        	
    }
  
    /*public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("ParticularsMaster.execute()");
    	return null;
    }*/
    
    public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("SubTaxHeadMaster.edit()");
    	System.out.println(request.getParameter("txtsubtaxheadname"));
    	System.out.println(request.getParameter("txtpercent"));
    	System.out.println(request.getParameter("drptaxhead"));
    	System.out.println(request.getParameter("drpyear"));
    	System.out.println(request.getParameter("drpstatus"));
    	try{
    		
    		TblSubtaxheadMaster objempcat = new TblSubtaxheadMaster();
    		    		
    		objempcat.setSubtaxheadId(request.getParameter("subtaxid"));
        	objempcat.setSubtaxheadName(request.getParameter("txtsubtaxheadname"));
        	objempcat.setSubtaxheadPercent(Double.valueOf(request.getParameter("txtpercent")));
        	objempcat.setSubtaxheadStatus(request.getParameter("drpstatus"));
        	objempcat.setSubtaxheadYear(request.getParameter("drpyear"));
        	objempcat.setTaxheadId(request.getParameter("drptaxhead"));
        	        	        	
        	//System.out.println("PartyMaster.add()2");
        	QuickUtil.updateToOld(objempcat);
        	//System.out.println("PartyMaster.add()3");
        	response.setContentType("text/xml; charset=UTF-8");
	    	//response.setHeader("Cache-Control", "no-cache"); 
			response.getWriter().write("true");
        	
    	}catch(Exception ex){
    		
    		System.out.println(ex.getMessage());
    		ex.printStackTrace();
    		response.getWriter().write("false");
    	}
    	return null;
        	
    }
    
    public ActionForward getSubTaxheadAll(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("SubTaxHeadMaster.getSubTaxheadAll()");
    	List<TblSubtaxheadMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblSubtaxheadMaster(), "TblSubtaxheadMaster", "");//("select * from tbl_employeecategory_master");
		String [] returnvalue=null;
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			for (TblSubtaxheadMaster objtemp : objempcat) {
								
				json = new JSONObject();
														
				String percent = String.valueOf(objtemp.getSubtaxheadPercent());
				json.put("id", objtemp.getSubtaxheadId());
				json.put("taxid", objtemp.getTaxheadId());
				json.put("name", objtemp.getSubtaxheadName());
				json.put("year", objtemp.getSubtaxheadYear() );	
				json.put("percent", percent );	
				json.put("status",  objtemp.getSubtaxheadStatus() );	
				
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
