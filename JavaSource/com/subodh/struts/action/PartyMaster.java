package com.subodh.struts.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import org.json.JSONArray;
import org.json.JSONObject;

import sun.rmi.runtime.NewThreadAction;

import com.subodh.TblPartytypeMaster;
import com.subodh.TblStateMaster;
import com.subodh.TblCityMaster;
import com.subodh.TblPartyMaster;
import com.subodh.TblRoleMaster;
import com.subodh.TblPartydepartmenttypeMaster;
import com.esaya.util.QuickUtil;

public class PartyMaster extends DispatchAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_getName = "getName"; 

    // Local Forwards

    
    public PartyMaster() {
    }
    
    public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("PartyMaster.add()");
    	try{
        	TblPartyMaster objempcat = new TblPartyMaster();
        	
        	//QuickUtil.doGetNextPK("tbl_runningid_master", "Run_Nos", "Run_Name = 'EMPCAT'");
        	String partyid = QuickUtil.doGetNextPK("PARTY");
        	objempcat.setPartyId(partyid);
        	objempcat.setPartyFname(request.getParameter("txtfname"));
        	objempcat.setPartyMname(request.getParameter("txtmname"));
        	objempcat.setPartyLname(request.getParameter("txtlname"));
        	objempcat.setPartyUsername(request.getParameter("txtusername"));
        	objempcat.setPartyPass(request.getParameter("txtpassword"));
        	objempcat.setPartyPinCode(request.getParameter("txtpincode"));
        	objempcat.setPartyEmailid(request.getParameter("txtemailid"));
        	objempcat.setPartyPhonenos(request.getParameter("txtphonenos"));
        	objempcat.setPartyAddress(request.getParameter("txtaddress"));
        	objempcat.setCityId(request.getParameter("drpcity"));
        	objempcat.setPartyTypeId(request.getParameter("drppartytype"));
        	objempcat.setPartyDepTypeId(request.getParameter("drpdepartment"));
        	objempcat.setPartyStatus("Active");        
        	
        	TblRoleMaster objtemprole = new TblRoleMaster();
        	objtemprole.setRoleId(request.getParameter("drprole"));
        	objempcat.setTblRoleMaster(objtemprole);
        	        	
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
    
    public ActionForward edit(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("PartyMaster.add()");
    	try{
        	TblPartyMaster objempcat = new TblPartyMaster();
        	
        	//QuickUtil.doGetNextPK("tbl_runningid_master", "Run_Nos", "Run_Name = 'EMPCAT'");
        	
        	objempcat.setPartyId(request.getParameter("partyid"));
        	objempcat.setPartyFname(request.getParameter("txtfname"));
        	objempcat.setPartyMname(request.getParameter("txtmname"));
        	objempcat.setPartyLname(request.getParameter("txtlname"));
        	objempcat.setPartyUsername(request.getParameter("txtusername"));
        	objempcat.setPartyPass(request.getParameter("txtpassword"));
        	objempcat.setPartyPinCode(request.getParameter("txtpincode"));
        	objempcat.setPartyEmailid(request.getParameter("txtemailid"));
        	objempcat.setPartyPhonenos(request.getParameter("txtphonenos"));
        	objempcat.setPartyAddress(request.getParameter("txtaddress"));
        	objempcat.setCityId(request.getParameter("drpcity"));
        	objempcat.setPartyTypeId(request.getParameter("drppartytype"));
        	objempcat.setPartyDepTypeId(request.getParameter("drpdepartment"));
        	objempcat.setPartyStatus("Active");        
        	
        	TblRoleMaster objtemprole = new TblRoleMaster();
        	objtemprole.setRoleId(request.getParameter("drprole"));
        	objempcat.setTblRoleMaster(objtemprole);
        	        	
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
    
    public ActionForward getPartyAll(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	List<TblPartyMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblPartyMaster(), "TblPartyMaster", "");//("select * from tbl_employeecategory_master");
		String [] returnvalue=null;
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			for (TblPartyMaster objtemp : objempcat) {
				
				
				json = new JSONObject();
				
				HashMap <String,HashMap> mapbase = new HashMap<String,HashMap>();
								
				json.put("id", objtemp.getPartyId());
				json.put("name", objtemp.getPartyFname() + " " + objtemp.getPartyMname() + " " + objtemp.getPartyLname());
								
				List<TblPartytypeMaster> objpartytype = QuickUtil.retrieveWherClause(new TblPartytypeMaster(), "TblPartytypeMaster", "partyTypeId='" + objtemp.getPartyTypeId() + "'");//("select * from tbl_employeecategory_master");
				TblPartytypeMaster objpartytype2 = objpartytype.get(0);
				json.put("partytype", objpartytype2.getPartyTypeName());
				
				List<TblRoleMaster> objrole = QuickUtil.retrieveWherClause(new TblRoleMaster(), "TblRoleMaster", "roleId='" + objtemp.getTblRoleMaster().getRoleId() + "'");//("select * from tbl_employeecategory_master");
				TblRoleMaster objrole2 = objrole.get(0);
				
				json.put("role", objrole2.getRoleName());
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
