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

import com.subodh.TblBillDetails;
import com.subodh.TblParticularsMaster;
import com.subodh.TblPartytypeMaster;
import com.subodh.TblStateMaster;
import com.subodh.TblCityMaster;
import com.subodh.TblPartyMaster;
import com.subodh.TblRoleMaster;
import com.subodh.TblPartydepartmenttypeMaster;
import com.subodh.TblTaxheadMaster;
import com.commons.CommonUtil;
import com.esaya.util.QuickUtil;

public class Bill extends DispatchAction {
    
    // Global Forwards
    public static final String GLOBAL_FORWARD_getName = "getName"; 

    // Local Forwards

    
    public Bill() {
    }
    
    public ActionForward add(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("Bill.add()");
    	try{
    		
        	TblBillDetails objempcat = new TblBillDetails();
        	
            String billid = QuickUtil.doGetNextPK("BILL");
        	objempcat.setBillNos(billid);
        	
//        	objempcat.setBillDate(); yet to be assigned in ui
        	
        	objempcat.setPartyId(request.getParameter("drpclient"));
        	objempcat.setBillPartitotal(Double.valueOf(request.getParameter("txttotal")));
        	objempcat.setBillTaxtotal(Double.valueOf(request.getParameter("txttaxes")));
        	objempcat.setBillDiscount(Double.valueOf(request.getParameter("txtdiscount")));
        	
//        	objempcat.setBillDistotal(Double.valueOf(request.getParameter("txttaxheadname"))); not sure
        	
        	objempcat.setBillFinaltotal(Double.valueOf(request.getParameter("txtfinal")));
//        	objempcat.setBillRoundoff();  yet to be assigned in ui ???????????????????
        	QuickUtil.saveToNew(objempcat);
        	
        	boolean savebillparticulars=CommonUtil.saveBillParticulars(billid, request);
        	boolean savebillreference=CommonUtil.saveBillReference(billid, request);
        	boolean savebilltaxation=CommonUtil.saveBillTaxation(billid, request,Double.valueOf(request.getParameter("txttotal")));
        	
        	response.setContentType("text/xml; charset=UTF-8");
	    
			response.getWriter().write(billid);
        	
    	}catch(Exception ex){
    		System.out.println("Bill.add()");
    		System.out.println(ex.getMessage());
    		ex.printStackTrace();
    		response.setContentType("text/xml; charset=UTF-8");
    	    
			response.getWriter().write("false");
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
    
    public ActionForward getAmount(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("Bill.getAmount()");
    	
    	List objempcat= QuickUtil.CreateSQLQuery("select particulars_id,clientpricedet_disc,clientpricedet_amt,party_id from vw_clientpricelist_details where party_id = '" + request.getParameter("drpclient") + "' and particulars_id = '" + request.getParameter("drpparticulars") + "'");
   	 
    	
		if (objempcat.size() > 0)
		{
		
			Object[] row=(Object[]) objempcat.get(0);
			 double amt= row[2]!=null?(Double)row[2]:0;
			response.setContentType("text/xml; charset=UTF-8");
	    	//response.setHeader("Cache-Control", "no-cache"); 
			response.getWriter().write(Double.toString(amt));
			return null;
		}else{
			
			List<TblParticularsMaster> objempcat2 = QuickUtil.retrieveWherClause(new TblParticularsMaster(), "TblParticularsMaster", "particularsId='" + request.getParameter("drpparticulars") + "'");//("select * from tbl_employeecategory_master");
			if(objempcat2.size()>0){
				TblParticularsMaster objempcat3= objempcat2.get(0);
				
				response.setContentType("text/xml; charset=UTF-8");
		    	//response.setHeader("Cache-Control", "no-cache"); 
				response.getWriter().write(objempcat3.getParticularsAmt()!=null?Double.toString(objempcat3.getParticularsAmt()):"0");
				return null;
			}
		}
		
		response.setContentType("text/xml; charset=UTF-8");
    	//response.setHeader("Cache-Control", "no-cache"); 
		response.getWriter().write("0");
		return null;
    }
    public ActionForward getTaxheadAll(ActionMapping mapping, ActionForm form, HttpServletRequest equest, HttpServletResponse response) throws Exception {
    	
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
    
    
    
    public ActionForward getTaxhead(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	System.out.println("Bill.getTaxhead()");
    	List objempcat= QuickUtil.CreateSQLQuery("select taxhead_id,taxhead_name,taxhead_percent from vw_taxhead_acyear");
   	 	
    	JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		System.out.println("size: " + objempcat.size());
		
		Object[] row2=(Object[]) objempcat.get(0);
		
		System.out.println("taxhead: "+ row2[0]);
		if (objempcat.size() > 0)
		{
			for(int i=0;i<objempcat.size();i++){
				
			json = new JSONObject();
			Object[] row=(Object[]) objempcat.get(i);
			double percent= row[2]!=null?(Double)row[2]:0;
			System.out.println("i: " + i + " taxhead:" + row[0] + " percent: " + percent);
			json.put("id", row[0]!=null?row[0]:"-");
			json.put("name", row[1]!=null?row[1]:"-");
			json.put("percent", String.valueOf(percent));
			json.put("subtaxhead",CommonUtil.getSubTaxHeadFromTaxId(row[0]!=null?String.valueOf(row[0]):"-"));
			jsonarr.put(i, json);
			
			}
			response.setContentType("text/xml; charset=UTF-8");
			System.out.println("Bill.getTaxhead(): " + jsonarr.toString());
	    	//response.setHeader("Cache-Control", "no-cache"); 
			response.getWriter().write(jsonarr.toString());
			return null;
		}
    	return null;
    }
}
