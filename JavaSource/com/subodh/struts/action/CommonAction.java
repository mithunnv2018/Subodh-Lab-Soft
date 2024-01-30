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

import com.subodh.TblStateMaster;
import com.subodh.TblCityMaster;
import com.esaya.util.QuickUtil;

public class CommonAction extends DispatchAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_getName = "getName"; 

    // Local Forwards

    
    public CommonAction() {
    }
    
    public ActionForward getstate(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	List<TblStateMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblStateMaster(), "TblStateMaster", "country_id='" + request.getParameter("countryid") + "'");//("select * from tbl_employeecategory_master");
		String [] returnvalue=null;
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			
			ArrayList<HashMap> list=new ArrayList<HashMap>();
			//list.toString(); 
			
			for (TblStateMaster objtemp : objempcat) {
				
				//map=new HashMap<String,String>();
				json = new JSONObject();
				
				HashMap <String,HashMap> mapbase = new HashMap<String,HashMap>();
				
				
				json.put("id", objtemp.getStateId());
				json.put("name", objtemp.getStateName());
				
							
				//list.add(mapbase);
				jsonarr.put(intRow, json);
				
				//System.out.print("objtemp: " + intRow + " - " + objtemp.getEmpCatId());
				intRow++;
				
			}
			
			//System.out.println("List: "+ list.toString());
			System.out.println("ListJson: "+ json.toString());
			System.out.println("Listarray: "+ jsonarr.toString());
			
			response.setContentType("text/xml; charset=UTF-8");
	    	//response.setHeader("Cache-Control", "no-cache"); 
			response.getWriter().write(jsonarr.toString());
			
    	
    	
		}
		return null;
    }
    
    public ActionForward getcity(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.print("state: " + request.getParameter("stateid"));
    	List<TblCityMaster> objempcat = QuickUtil.retrieveWherClause(new TblCityMaster(), "TblCityMaster", "State_Id='" + request.getParameter("stateid") + "'");//(new TblCityMaster(), "TblCityMaster", "State_Id='" + request.getParameter("stateid") + "'");//("select * from tbl_employeecategory_master");
		String [] returnvalue=null;
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			
			ArrayList<HashMap> list=new ArrayList<HashMap>();
			//list.toString(); 
			
			for (TblCityMaster objtemp : objempcat) {
				
				//map=new HashMap<String,String>();
				json = new JSONObject();
				
				HashMap <String,HashMap> mapbase = new HashMap<String,HashMap>();
				
				
				json.put("id", objtemp.getCityId());
				json.put("city", objtemp.getCityName());
				
							
				//list.add(mapbase);
				jsonarr.put(intRow, json);
				
				//System.out.print("objtemp: " + intRow + " - " + objtemp.getEmpCatId());
				intRow++;
				
			}
			
			
			response.setContentType("text/xml; charset=UTF-8");
	    	//response.setHeader("Cache-Control", "no-cache"); 
			response.getWriter().write(jsonarr.toString());
			
    	return null;
    }
    return null;
    }
}
