package com.commons;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.json.JSONArray;
import org.json.JSONObject;

import com.esaya.util.QuickUtil;
import com.subodh.TblAcyearMaster;
import com.subodh.TblBillDetails;
import com.subodh.TblBillparticularsDetails;
import com.subodh.TblBillreferencesDetails;
import com.subodh.TblBillreferencesMaster;
import com.subodh.TblBillsubtaxheadDetails;
import com.subodh.TblBilltaxheadDetails;
import com.subodh.TblCityMaster;
import com.subodh.TblClientpricelistDetails;
import com.subodh.TblClientpricelistMaster;
import com.subodh.TblCountryMaster;
import com.subodh.TblPartyMaster;
import com.subodh.TblPartydepartmenttypeMaster;
import com.subodh.TblPartytypeMaster;
import com.subodh.TblParticularsMaster;
import com.subodh.TblRoleMaster;
import com.subodh.TblStateMaster;
import com.subodh.TblSubtaxheadMaster;
import com.subodh.TblTaxheadMaster;
import com.subodh.VwClientpricelistDetails;
import com.subodh.VwClientpricelistDetailsId;

public class CommonUtil {

	
	public CommonUtil() {
    }
    
	public static JSONArray getDepartment(){
	 
	 List<TblPartydepartmenttypeMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblPartydepartmenttypeMaster(), "TblPartydepartmenttypeMaster", "");//("select * from tbl_employeecategory_master");

		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			
			ArrayList<HashMap> list=new ArrayList<HashMap>();
			//list.toString(); 
			
			for (TblPartydepartmenttypeMaster objtemp : objempcat) {
				
				//map=new HashMap<String,String>();
				json = new JSONObject();
				
				HashMap <String,HashMap> mapbase = new HashMap<String,HashMap>();
				
				
				json.put("id", objtemp.getPartyDepTypeId());
				json.put("name", objtemp.getPartyDepTypeName());
				
				jsonarr.put(intRow, json);
				
				//System.out.print("objtemp: " + intRow + " - " + objtemp.getEmpCatId());
				intRow++;
				
			}
			
			//System.out.println("List: "+ list.toString());
			System.out.println("ListJson: "+ json.toString());
			System.out.println("Listarray: "+ jsonarr.toString());
			
			
			return jsonarr;
		}
		return null;
 }
 
 public static JSONArray getRoleMaster(){
	 
	
	 	List<TblRoleMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblRoleMaster(), "TblRoleMaster", "");//("select * from tbl_employeecategory_master");
		
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		//List<TblStateMaster> objliststate = QuickUtil.retrieveWherClause(new TblStateMaster(), "TblStateMaster", "tblCountryMaster.countryId='"+countryId+"' ");
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			
			ArrayList<HashMap> list=new ArrayList<HashMap>();
			//list.toString(); 
			
			for (TblRoleMaster objtemp : objempcat) {
				
				//map=new HashMap<String,String>();
				json = new JSONObject();
				
				HashMap <String,HashMap> mapbase = new HashMap<String,HashMap>();
				
				
				json.put("id", objtemp.getRoleId());
				json.put("name", objtemp.getRoleName());
				
				jsonarr.put(intRow, json);
				//jsonarrbase.put(intRow,jsonarr);
				//System.out.print("objtemp: " + intRow + " - " + objtemp.getEmpCatId());
				intRow++;
				
			}
			
			
			System.out.println("Listarray: "+ jsonarr.toString());
			//System.out.println("jsonarrbase: "+ jsonarrbase.toString());
			
	        
			
			return jsonarr;
		}
		return null;
 }
 
 public static JSONArray getPartyType(){
		
    	List<TblPartytypeMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblPartytypeMaster(), "TblPartytypeMaster", "");//(new TblCityMaster(), "TblCityMaster", "State_Id='" + request.getParameter("stateid") + "'");//("select * from tbl_employeecategory_master");

		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			
			ArrayList<HashMap> list=new ArrayList<HashMap>();
			//list.toString(); 
			
			for (TblPartytypeMaster objtemp : objempcat) {
				
				//map=new HashMap<String,String>();
				json = new JSONObject();
				
				HashMap <String,HashMap> mapbase = new HashMap<String,HashMap>();
				
				
				json.put("id", objtemp.getPartyTypeId());
				json.put("name", objtemp.getPartyTypeName());
				
							
				//list.add(mapbase);
				jsonarr.put(intRow, json);
				
				//System.out.print("objtemp: " + intRow + " - " + objtemp.getEmpCatId());
				intRow++;
				
			}
			
			
    	return jsonarr;
    	
    }
		return null;
    	
 }
 public static JSONArray getCountry(){
		
    	List<TblCountryMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblCountryMaster(), "TblCountryMaster", "");//(new TblCityMaster(), "TblCityMaster", "State_Id='" + request.getParameter("stateid") + "'");//("select * from tbl_employeecategory_master");

		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			
			ArrayList<HashMap> list=new ArrayList<HashMap>();
			//list.toString(); 
			
			for (TblCountryMaster objtemp : objempcat) {
				
				//map=new HashMap<String,String>();
				json = new JSONObject();
				
				HashMap <String,HashMap> mapbase = new HashMap<String,HashMap>();
				
				
				json.put("id", objtemp.getCountryId());
				json.put("name", objtemp.getCountryName());
				
							
				//list.add(mapbase);
				jsonarr.put(intRow, json);
				
				//System.out.print("objtemp: " + intRow + " - " + objtemp.getEmpCatId());
				intRow++;
				
			}
			
			
    	return jsonarr;
    	
    }
		return null;
    	
 }
 
 
 public static JSONArray getPartyAll() {
 	
 	List<TblPartyMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblPartyMaster(), "TblPartyMaster", "");//("select * from tbl_employeecategory_master");

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

			
 	return jsonarr;
 }
 return jsonarr;
 }
 
 public static JSONArray getClient() {
	 	
	 	List<TblPartyMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblPartyMaster(), "TblPartyMaster", "partyTypeId='CLIENT'");//("select * from tbl_employeecategory_master");

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

				
	 	return jsonarr;
	 }
	 return jsonarr;
	 }

 
 
 public static JSONArray getPartyEdit(String partyid) {
	 	
	 System.out.println("CommonUtil.getPartyEdit()");
	 
	 List<TblPartyMaster> objempcat = QuickUtil.retrieveWherClause(new TblPartyMaster(), "TblPartyMaster", "partyId='" + partyid + "'");//("select * from tbl_employeecategory_master");

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
					json.put("fname", objtemp.getPartyFname());
					json.put("mname",objtemp.getPartyMname());
					json.put("lname",objtemp.getPartyLname());
					
					json.put("username",objtemp.getPartyUsername());
					json.put("emailid",objtemp.getPartyEmailid());
					json.put("phoneno",objtemp.getPartyPhonenos());
					json.put("address",objtemp.getPartyAddress());
					json.put("pincode",objtemp.getPartyPhonenos());
					
					json.put("partytype",objtemp.getPartyTypeId());
					json.put("role",objtemp.getTblRoleMaster().getRoleId());
					json.put("department",objtemp.getPartyDepTypeId());
					
					
					json.put("city",objtemp.getCityId());
					List<TblCityMaster> objcity = QuickUtil.retrieveWherClause(new TblCityMaster(), "TblCityMaster", "cityId='" + objtemp.getCityId() + "'");//("select * from tbl_employeecategory_master");
					TblCityMaster objcity2 = objcity.get(0);
					
					
//					json.put("citydata",getcity(objcity2.getTblStateMaster().getStateId() ));
					
					
					List<TblStateMaster> objstate = QuickUtil.retrieveWherClause(new TblStateMaster(), "TblStateMaster", "stateId='" + objcity2.getTblStateMaster().getStateId() + "'");//("select * from tbl_employeecategory_master");
					TblStateMaster objstate2 = objstate.get(0);
					
					
//					json.put("statedata",getstate(objstate2.getCountryId()));
					
					json.put("state",objcity2.getTblStateMaster().getStateId());
					
					json.put("country",objstate2.getCountryId());
					
					jsonarr.put(intRow,json); 
					intRow++;
					
				}
				
				System.out.println("CommonUtil.getPartyEdit()Listarray: " + jsonarr.toString());
								
	 	return jsonarr;
	 }
	 return jsonarr;
	 }
 
 public static JSONArray getParticularsEdit(String partyid) {
	 	
	System.out.println("CommonUtil.getParticularsEdit()");
	 
	 List<TblParticularsMaster> objempcat = QuickUtil.retrieveWherClause(new TblParticularsMaster(), "TblParticularsMaster", "particularsId='" + partyid + "'");//("select * from tbl_employeecategory_master");

			JSONObject json = null;
			JSONArray jsonarr = null;
			
			jsonarr = new JSONArray();
			
			if (objempcat.size() > 0)
			{
				int intRow = 0;
				
				for (TblParticularsMaster objtemp : objempcat) {
					
					
					json = new JSONObject();
					
					
									
					json.put("id", objtemp.getParticularsId() );
					json.put("name", objtemp.getParticularsName());
					json.put("amount",objtemp.getParticularsAmt());
						
					jsonarr.put(intRow,json); 
					intRow++;
					
				}
				
				System.out.println("CommonUtil.getParticularsedit()Listarray: " + jsonarr.toString());
								
	 	return jsonarr;
	 }
	 return jsonarr;
	 }

 
 public static JSONArray getstate(String countryid){
 	
 	List<TblStateMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblStateMaster(), "TblStateMaster", "country_id='" +countryid + "'");//("select * from tbl_employeecategory_master");

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
			
			
 	
 	
		}
		return jsonarr;
 }
 
 public static JSONArray getcity(String stateid) {
 	
 
 	List<TblCityMaster> objempcat = QuickUtil.retrieveWherClause(new TblCityMaster(), "TblCityMaster", "State_Id='" + stateid + "'");//(new TblCityMaster(), "TblCityMaster", "State_Id='" + request.getParameter("stateid") + "'");//("select * from tbl_employeecategory_master");
		
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
			
			
 	return jsonarr;
 }
 return jsonarr;
 }
 
 public static JSONArray getParticularsAll() {
	 	
	 
	 	List<TblParticularsMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblParticularsMaster(), "TblParticularsMaster", "order by particularsId asc");//("select * from tbl_employeecategory_master");
		
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
				
				
	 	return jsonarr;
	 }
	 return jsonarr;
	 }

 public static String getdiscountamt(String clientid) {
	 List<TblClientpricelistMaster> objempcat2 = QuickUtil.retrieveWherClause(new TblClientpricelistMaster(), "TblClientpricelistMaster", "partyId = '"  + clientid + "'");
	 
	 if(objempcat2.size()>0){
		 TblClientpricelistMaster obj=objempcat2.get(0);
		 String ab= String.valueOf(obj.getClientpriceDiscount());
		 return ab ;
		 
	 }else{
		 return "";
	 }
 }
 public static boolean deleteclientpricelist(String clientid) {
	 List<TblClientpricelistMaster> objempcat2 = QuickUtil.retrieveWherClause(new TblClientpricelistMaster(), "TblClientpricelistMaster", "partyId = '"  + clientid + "'");
	 
	 if(objempcat2.size()>0){
		 TblClientpricelistMaster obj=objempcat2.get(0);
		 QuickUtil.deleteFromDB("TblClientpricelistDetails", "clientpriceId='" + obj.getClientpriceId() + "'");
		 QuickUtil.deleteFromDB("TblClientpricelistMaster", "partyId='" + clientid + "'");
		 return true ;
		 
	 }else{
		 return false;
	 }
 }
 
public static JSONArray getParticularsAll(String clientid) {
	 	
	
	System.out.println("CommonUtil.getParticularsAll(): " + clientid);
	 List<TblParticularsMaster> objempcat2 = QuickUtil.retrieveALLwithHB(new TblParticularsMaster(), "TblParticularsMaster", "order by particularsId asc");//("select * from tbl_employeecategory_master");
	 System.out.println("select particulars_id,clientpricedet_disc,clientpricedet_amt,party_id from vw_clientpricelist_details where party_id = '" + clientid + "'");
	 List objlist= QuickUtil.CreateSQLQuery("select particulars_id,clientpricedet_disc,clientpricedet_amt,party_id from vw_clientpricelist_details where party_id = '" + clientid + "'");
	  
	  
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat2.size() > 0)
		{
			int intRow = 0;
			
			for (int i=0;i<objempcat2.size();i++) {
				
				String particularid="";
				double disc=  0;
				double finalamt=0;
				if(i<objlist.size()){
				
				Object[] row=(Object[]) objlist.get(i);
				 particularid= (String)row[0];
				 System.out.println("Listvalueparti: " + particularid);
				 disc=  row[1]!=""?(Double)row[1]:0;
				 finalamt= row[2]!=""?(Double)row[2]:0;;
								
				}
				
				json = new JSONObject();
				TblParticularsMaster objparti = objempcat2.get(i);
				System.out.println("Particualrsmaster: " + objparti.getParticularsId());
				String amt = String.valueOf(objparti.getParticularsAmt());
				
				if(objparti.getParticularsId().equals(particularid)){
				
				
					String disc2 = String.valueOf(disc);
					String finalamt2 = String.valueOf(finalamt);
					json.put("id", objparti.getParticularsId());
					json.put("name", objparti.getParticularsName());
					json.put("amount", amt );
					json.put("discount", disc2 );
					json.put("finalamount", finalamt2 );
				
				}else{
					
					json.put("id", objparti.getParticularsId());
					json.put("name", objparti.getParticularsName());
					json.put("amount", amt );	
					json.put("discount", "" );	
					json.put("finalamount", "" );
					
				}
				jsonarr.put(i, json);
			
			}
				System.out.println("Clientpricelist: " + jsonarr.toString());
	 	return jsonarr;
	 }
	 return jsonarr;
	 }

public static JSONArray getTaxheadAll() {
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
		
	}
	return jsonarr;
}
public static JSONArray getTaxHeadEdit(String taxid) {
 	
	System.out.println("CommonUtil.getTaxHeadEdit()");
	 
	 List<TblTaxheadMaster> objempcat = QuickUtil.retrieveWherClause(new TblTaxheadMaster(), "TblTaxheadMaster", "taxheadId='" + taxid + "'");//("select * from tbl_employeecategory_master");

			JSONObject json = null;
			JSONArray jsonarr = null;
			
			jsonarr = new JSONArray();
			
			if (objempcat.size() > 0)
			{
				int intRow = 0;
				
				for (TblTaxheadMaster objtemp : objempcat) {
					
					json = new JSONObject();
									
					json.put("id", objtemp.getTaxheadId() );
					json.put("name", objtemp.getTaxheadName());
					json.put("percent",objtemp.getTaxheadPercent());
					json.put("year",objtemp.getTaxheadYear());
					json.put("status",objtemp.getTaxheadStatus());
						
					jsonarr.put(intRow,json); 
					intRow++;
					
				}
				
				System.out.println("CommonUtil.getTaxHeadEdit()Listarray: " + jsonarr.toString());
								
	 	return jsonarr;
	 }
	 return jsonarr;
	 }


public static JSONArray getSubTaxHeadEdit(String subtaxid) {
 	
	System.out.println("CommonUtil.getSubTaxHeadEdit()");
	 
	 List<TblSubtaxheadMaster> objempcat = QuickUtil.retrieveWherClause(new TblSubtaxheadMaster(), "TblSubtaxheadMaster", "subtaxheadId='" + subtaxid + "'");//("select * from tbl_employeecategory_master");

			JSONObject json = null;
			JSONArray jsonarr = null;
			
			jsonarr = new JSONArray();
			
			if (objempcat.size() > 0)
			{
				int intRow = 0;
				
				for (TblSubtaxheadMaster objtemp : objempcat) {
					
					json = new JSONObject();
									
					json.put("id", objtemp.getSubtaxheadId());
					json.put("taxid", objtemp.getTaxheadId());
					json.put("name", objtemp.getSubtaxheadName());
					json.put("percent",objtemp.getSubtaxheadPercent());
					json.put("year",objtemp.getSubtaxheadYear());
					json.put("status",objtemp.getSubtaxheadStatus());
						
					jsonarr.put(intRow,json); 
					intRow++;
					
				}
				
				System.out.println("CommonUtil.getSubTaxHeadEdit()Listarray: " + jsonarr.toString());
								
	 	return jsonarr;
	 }
	 return jsonarr;
}
//get Sub tax from taxid
public static JSONArray getSubTaxHeadFromTaxId(String taxid) {
 	
	System.out.println("CommonUtil.getSubTaxHeadFromTaxId()");
	 
	 List<TblSubtaxheadMaster> objempcat = QuickUtil.retrieveWherClause(new TblSubtaxheadMaster(), "TblSubtaxheadMaster", "taxheadId='" + taxid + "'");//("select * from tbl_employeecategory_master");

			JSONObject json = null;
			JSONArray jsonarr = null;
			
			jsonarr = new JSONArray();
			
			if (objempcat.size() > 0)
			{
				int intRow = 0;
				
				for (TblSubtaxheadMaster objtemp : objempcat) {
					
					json = new JSONObject();
					
					double percent = objtemp.getSubtaxheadPercent();
					json.put("id", objtemp.getSubtaxheadId());
					json.put("taxid", objtemp.getTaxheadId());
					json.put("name", objtemp.getSubtaxheadName());
					json.put("percent",String.valueOf(percent));
					json.put("year",objtemp.getSubtaxheadYear());
					json.put("status",objtemp.getSubtaxheadStatus());
						
					jsonarr.put(intRow,json); 
					intRow++;
					
				}
				
				System.out.println("CommonUtil.getSubTaxHeadEdit()Listarray: " + jsonarr.toString());
								
	 	return jsonarr;
	 }
	 return jsonarr;
}

public static JSONArray getacyear(){
	 
	 System.out.println("CommonUtil.getacyear()");
	 List<TblAcyearMaster> objempcat = QuickUtil.retrieveALLwithHB(new TblAcyearMaster(), "TblAcyearMaster", "");//("select * from tbl_employeecategory_master");

		JSONObject json = null;
		JSONArray jsonarr = null;
		
		jsonarr = new JSONArray();
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			
			for (TblAcyearMaster objtemp : objempcat) {
				
				json = new JSONObject();
				
			
				json.put("id", objtemp.getAcyearId());
				json.put("name", objtemp.getAcyearText());
				json.put("fromdate", objtemp.getAcyearFromdate());
				json.put("todate", objtemp.getAcyearTodate());
				json.put("currentyear", objtemp.getAcyearCurrentyear());
				
				jsonarr.put(intRow, json);
		
				intRow++;
				
			}
			
		
			System.out.println("Listarray: "+ jsonarr.toString());
			
			
			return jsonarr;
		}
		return null;
}

	public static JSONArray getBillReferencesAll() {
		
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
			
			
		return jsonarr;
	}
	return jsonarr;
   }
	
	public static JSONArray getBillReferencesEdit(String referenceid) {
	 	
		System.out.println("CommonUtil.getBillReferencesEdit()");
		 
		 List<TblBillreferencesMaster> objempcat = QuickUtil.retrieveWherClause(new TblBillreferencesMaster(), "TblBillreferencesMaster", "referenceId='" + referenceid + "'");//("select * from tbl_employeecategory_master");

				JSONObject json = null;
				JSONArray jsonarr = null;
				
				jsonarr = new JSONArray();
				
				if (objempcat.size() > 0)
				{
					int intRow = 0;
					
					for (TblBillreferencesMaster objtemp : objempcat) {
						
						
						json = new JSONObject();
						
						
										
						json.put("id", objtemp.getReferenceId() );
						json.put("name", objtemp.getReferenceName());
						
							
						jsonarr.put(intRow,json); 
						intRow++;
						
					}
					
					System.out.println("CommonUtil.getBillReferencesEdit()Listarray: " + jsonarr.toString());
									
		 	return jsonarr;
		 }
		 return jsonarr;
		 }
	
	public static JSONArray getSubTaxheadAll() {
		
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
		}
		return jsonarr;
	   }
	
	public static JSONArray getBillDetails(String billnos) {
		
		List<TblBillDetails> objempcat = QuickUtil.retrieveWherClause(new TblBillDetails(), "TblBillDetails", "billNos='" + billnos + "'");//("select * from tbl_employeecategory_master");
		
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			for (TblBillDetails objtemp : objempcat) {
								
				json = new JSONObject();
														
				json.put("billnos", objtemp.getBillNos());
				json.put("billdate", objtemp.getBillDate());
				json.put("discount", objtemp.getBillDiscount());
				json.put("totalminusdisc", objtemp.getBillDistotal());
				json.put("finaltotal", objtemp.getBillFinaltotal());
				json.put("particularstotal", objtemp.getBillPartitotal());
				json.put("roundoff", objtemp.getBillRoundoff());
				json.put("taxplustotalamt", objtemp.getBillTaxtotal());
				json.put("partydetails", getPartyEdit(objtemp.getPartyId()));
				json.put("billparticularsdetails", getBillParticulars(objtemp.getBillNos()));
				json.put("billreferences", getBillReferences(objtemp.getBillNos()));
				
							
			}
		}
		return jsonarr;
	}
	

	public static JSONArray getBillParticulars(String billnos) {
		
		List<TblBillparticularsDetails> objempcat2 = QuickUtil.retrieveWherClause(new TblBillparticularsDetails(), "TblBillparticularsDetails", "billNos='" + billnos + "'");//("select * from tbl_employeecategory_master");
		
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		if (objempcat2.size() > 0)
		{
			int intRow = 0;
			
			for (TblBillparticularsDetails objtemp : objempcat2) {
								
				json = new JSONObject();
														
				json.put("billnos", getParticularsName(objtemp.getParticularsId()));
				json.put("billdate", objtemp.getParticularsId());
				json.put("discount", objtemp.getBillpartiAmount());
				json.put("totalminusdisc", objtemp.getBillpartiQuantity());
				json.put("finaltotal", objtemp.getBillpartiTotalamt());
				
				
			}
		}
		return jsonarr;
	}

	public static JSONArray getBillReferences(String billnos) {
		
		List<TblBillreferencesDetails> objempcat = QuickUtil.retrieveWherClause(new TblBillreferencesDetails(), "TblBillreferencesDetails", "billNos='" + billnos + "'");//("select * from tbl_employeecategory_master");
		
		JSONObject json = null;
		JSONArray jsonarr = null;
		
		if (objempcat.size() > 0)
		{
			int intRow = 0;
			
			for (TblBillreferencesDetails objtemp : objempcat) {
								
				json = new JSONObject();
														
				json.put("referencename", geBillReferenceName(objtemp.getReferenceId()));
				
				json.put("value", objtemp.getBillrefValue());
				json.put("referenceid", objtemp.getReferenceId());
				
								
			}
		}
		return jsonarr;
	}

	private static String getParticularsName(String partiid) {
		
		List<TblParticularsMaster> objempcat = QuickUtil.retrieveWherClause(new TblParticularsMaster(), "TblParticularsMaster", "billNos='" + partiid + "'");//("select * from tbl_employeecategory_master");
	
		
		if (objempcat.size() > 0)
		{
			TblParticularsMaster tblParticularsMaster2 = objempcat.get(0);
			return tblParticularsMaster2.getParticularsName();
		}
		return "NONAME";
	}
	
	private static String geBillReferenceName(String billrefid) {
		
		List<TblBillreferencesMaster> objempcat = QuickUtil.retrieveWherClause(new TblBillreferencesMaster(), "TblBillreferencesMaster", "referenceId='" + billrefid + "'");//("select * from tbl_employeecategory_master");
	
		
		if (objempcat.size() > 0)
		{
			TblBillreferencesMaster objempcat2 = objempcat.get(0);
			return objempcat2.getReferenceName();
		}
		return "NONAME";
	}
	
	//Save bill particulars..
		
	public static boolean saveBillParticulars(String billnos,HttpServletRequest request) throws ParseException {
		
		System.out.println("CommonUtil.saveBillParticulars(): " + request.getParameter("getbillparti")!=null&&request.getParameter("getbillparti")!=""?request.getParameter("getbillparti"):"");
		try{
		JSONArray objarr = new JSONArray(request.getParameter("getbillparti")!=null&&request.getParameter("getbillparti")!=""?request.getParameter("getbillparti"):"");
    	
    	
    	JSONObject object = null;

	    for (int intloop=0;intloop<objarr.length();intloop++){	
	    object = objarr.getJSONObject(intloop);
	    
	    TblBillparticularsDetails objtemp = new TblBillparticularsDetails();
    	
		//saving
		objtemp.setBillNos(billnos);
		objtemp.setParticularsId(object.getString("id"));
		objtemp.setBillpartiQuantity(Integer.valueOf( object.getString("quantity")));
		objtemp.setBillpartiAmount(Double.valueOf(object.getString("amount")));
		objtemp.setBillpartiTotalamt(Double.valueOf(object.getString("amount"))*Double.valueOf(object.getString("quantity")));
	    	    
	    
	    System.out.println("ReadJSONObject amount: " + object.getString("amount"));	
	    System.out.println("ReadJSONObject amount: " + object.getString("id"));	
	
		QuickUtil.saveToNew(objtemp);
	    
	    }
	    return true;
	 }catch(Exception ex){
		System.out.println("CommonUtil.saveBillParticulars()");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
		return false;
	}		
	}
	
	//saving bill reference
	public static boolean saveBillReference(String billnos,HttpServletRequest request) throws ParseException {
		
		System.out.println("CommonUtil.saveBillReference()");
		try{
		JSONArray objarr = new JSONArray(request.getParameter("getbillref")!=null&&request.getParameter("getbillref")!=""?request.getParameter("getbillref"):"");
    	
    	
    	JSONObject object = null;

	    for (int intloop=0;intloop<objarr.length();intloop++){	
	    object = objarr.getJSONObject(intloop);
	    
	    TblBillreferencesDetails objtemp = new TblBillreferencesDetails();
    	
		//saving
		objtemp.setBillNos(billnos);		
		objtemp.setBillrefValue(object.getString("value"));
		objtemp.setReferenceId(object.getString("id"));
			
	    System.out.println("ReadJSONObject amount: " + object.getString("value"));	
	    System.out.println("ReadJSONObject amount: " + object.getString("id"));	
	
		QuickUtil.saveToNew(objtemp);
	    
	    }
	    return true;
	}catch(Exception ex){
		System.out.println("CommonUtil.saveBillReference()");
		System.out.println(ex.getMessage());
		ex.printStackTrace();
		return false;
	}
	
	    
	}
	

	//saving Bill Taxation
	public static boolean saveBillTaxation(String billnos,HttpServletRequest request,Double amount) throws ParseException {
		
		System.out.println("CommonUtil.saveBillTaxation()");
		try{
		List objempcat= QuickUtil.CreateSQLQuery("select taxhead_id,taxhead_name,taxhead_percent from vw_taxhead_acyear");
   	 	
		System.out.println("size: " + objempcat.size());
		
		Object[] row2=(Object[]) objempcat.get(0);
		
		System.out.println("taxhead: "+ row2[0]);
		if (objempcat.size() > 0)
		{
			for(int i=0;i<objempcat.size();i++){
				
				TblBilltaxheadDetails objtax = new TblBilltaxheadDetails();
				String billtaxheadid = QuickUtil.doGetNextPK("BILLTAXID");
			Object[] row=(Object[]) objempcat.get(i);
			double percent= row[2]!=null?(Double)row[2]:0;
			
			System.out.println("i: " + i + " taxhead:" + row[0] + " percent: " + percent);
			objtax.setBilltaxId(billtaxheadid);
			objtax.setTaxheadId(row[0]!=null?String.valueOf(row[0]):"-");
			objtax.setBilltaxPercent(row[2]!=null?(Double)row[2]:0);
			
			double taxheadAmount = amount/100;
			taxheadAmount = row[2]!=null?(Double)row[2]*taxheadAmount:0;
			objtax.setBilltaxAmount(taxheadAmount);
			objtax.setBillNos(billnos);
			
			QuickUtil.saveToNew(objtax);
			
			//Saving subtax heads
			
			JSONArray objarr = new JSONArray();
			objarr = getSubTaxHeadFromTaxId(row[0]!=null?String.valueOf(row[0]):"-");
	    	    	
	    	JSONObject object = null;

		    	for (int intloop=0;intloop<objarr.length();intloop++){	
				    object = objarr.getJSONObject(intloop);
				    
				    TblBillsubtaxheadDetails objtemp = new TblBillsubtaxheadDetails();
			    	
					//saving
					objtemp.setBilltaxId(billtaxheadid);	
					objtemp.setSubtaxheadId(object.getString("id"));
					double subtaxamount = taxheadAmount/100;
					objtemp.setSubtaxheadAmount(Double.valueOf(object.getString("percent"))*subtaxamount);
					
					objtemp.setSubtaxheadPercent(Double.valueOf(object.getString("percent")));									
				
				
					QuickUtil.saveToNew(objtemp);
				    
		    	}
			
			
			}
			return true;
		}
		return false;
		}catch(Exception ex){
    		System.out.println("CommonUtil.saveBillTaxation()");
    		System.out.println(ex.getMessage());
    		ex.printStackTrace();
    		return false;
    	}
		
	    
	}
	
}
