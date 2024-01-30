<%@page import="com.commons.CommonUtil"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<script language="javascript">
var xmlhttp=null; 

<%if(request.getParameter("TAXID")!=null&&!(request.getParameter("TAXID").trim().equals(""))){%>
var isEdit = true;
var parampartyid = <%=request.getParameter("TAXID")%>;
<%}else{%>
var isEdit = false;
<%}%>

function loaddoc(){
	
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	
}

loaddoc();

function popstate(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;
			
		    var arr = JSON.parse(resp);
		    $('#drpstate').empty()
		   	$('#drpstate').append('<option value="0">--Select--</option>');
		   	for(var x=0;x<arr.length;x++){
		   	
				$('#drpstate').append('<option value="' + arr[x].id + '">' + arr[x].name + '</option>');
		   	}
	     }
	  }
	xmlhttp.open("GET","CommonAction.do?methodtocall=getstate&countryid=" + document.getElementById("drpcountry").value,true);
	xmlhttp.send();

}
function popcity(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		    var arr = JSON.parse(resp);
		    $('#drpcity').empty()
		   	$('#drpcity').append('<option value="0">--Select--</option>');
		   
		   	for(var x=0;x<arr.length;x++){
		   	 
				$('#drpcity').append('<option value="' + arr[x].id + '">' + arr[x].city + '</option>');
		   	}
		 
	     }
	  }

	xmlhttp.open("GET","CommonAction.do?methodtocall=getcity&stateid=" + document.getElementById("drpstate").value,true);
	xmlhttp.send();

}

function validation(){
	loaddoc();
	if(document.getElementById('txttaxheadname').value == ""){
		alert("Please enter Tax Head Name");
		return false;
	}  
	if(document.getElementById('txtpercent').value == ""){
		alert("Please enter percentage");
		return false;
	} 
	if(document.getElementById('drpyear').value == "0"){
		alert("Please select Year");
		return false;
	} 
	if(document.getElementById('drpstatus').value == "0"){
		alert("Please select Status");
		return false;
	}   
		return true;
}

function updateGrid(){
	
		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
			  var resp = xmlhttp.responseText;
			 	var arr = JSON.parse(resp);
			   	var bodystr="";
			   	bodystr = bodystr+'<table class="table table-hover table-nomargin table-bordered dataTable-columnfilter dataTable">';
				bodystr = bodystr+'<thead><tr class="thefilter"><th>Name</th><th>Party Type</th>  <th>Role</th><th>Edit</th></tr><tr><th>Name</th><th>Party Type</th><th>Role</th> <th>Edit</th></tr></thead>';
				bodystr = bodystr+' <tbody>';
			   	for(var x=0;x<arr.length;x++){
			   	
					bodystr = bodystr+'<tr>';
					bodystr = bodystr+'<td>' +arr[x].name;
					bodystr = bodystr+'</td>';
					bodystr = bodystr+'<td>'+arr[x].partytype;
					bodystr = bodystr+'</td>';
					bodystr = bodystr+'<td>'+arr[x].role;
					bodystr = bodystr+'</td>';
					bodystr = bodystr+'<td><a href="'+arr[x].role+'">Edit</a>';
					bodystr = bodystr+'</td>';
					bodystr = bodystr+'</tr>';
					
					
			   	}
			   	bodystr = bodystr+'</tbody></table>';
				$("#Grid1").html(bodystr);
		    }
		  }

		var url = 'PartyMaster.do?methodtocall=getPartyAll';
		
		xmlhttp.open("POST",url ,true);
		
		xmlhttp.send();
}

function editsave(){

	//alert("editsave");
	if(validation()==true){
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		    if(xmlhttp.responseText=="true"){
		    	alert("Data Saved Successfully");
			
	    	//updateGrid();
			document.location = "taxhead.do"; 
	    	//window.location("particulars.do");
		
		    }else{
			    	alert("Data Not Saved Successfully");
			}
			
	    }
	  }

	
	
	var url = 'TaxHeadMaster.do?methodtocall=edit&taxid=<%=request.getParameter("TAXID")%>&txttaxheadname=' + document.getElementById('txttaxheadname').value + '&txtpercent=' + document.getElementById('txtpercent').value + '&drpyear=' + document.getElementById('drpyear').value + '&drpstatus=' + document.getElementById('drpstatus').value;	//var url='";
	
	alert(" after call" + url);
	xmlhttp.open("POST",url ,true);
	//alert(" after call" + url);
	xmlhttp.send();
	}
	
	
}

function savedata(){
	//alert("in save data");
	if(validation()==true){
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		    if(xmlhttp.responseText=="true"){
		    	alert("Data Saved Successfully");
			
	    	//updateGrid();
			document.location = "taxhead.do";
	    	
			/*document.getElementById('txtfname').value = ""; 
			document.getElementById('txtmname').value = ""; 
			document.getElementById('txtlname').value = ""; 
			document.getElementById('txtusername').value = ""; 
			document.getElementById('txtpassword').value = "";
			document.getElementById('drpcity').value = "";
			document.getElementById('txtaddress').value = ""; 
			document.getElementById('txtpincode').value = ""; 
			document.getElementById('drppartytype').value = ""; 
			document.getElementById('drpdepartment').value = ""; 
			$('#drpcity').empty()
			$('#drpstate').empty()
			
			document.getElementById('drprole').value = "0";
			
			isEdit=false;
			*/
			//alert(returnparamgrid());
			//alert("After timeout");
		   	 	
			//dijit.byId("grid").startup();
			//dijit.byId("grid").store.save();
		    //dijit.byId("grid").render();
		    //dijit.byId("grid").rowSelectCell.toggleRow(0, true);
		    //dijit.byId("grid").pagination.plugin.nextPage;
		    
			//cleardata();
		    }else{
			    	alert("Data Not Saved Successfully");
			}
			
	    }
	  }


	//alert("hidden: " + document.getElementById("txthiddenid").value + ", edit: " + isEdit);

	  /*if(document.getElementById("txtdepartment").value==""){
		alert("Please enter Department")
		  }
	  else if(isEdit==true){
		  if(document.getElementById("txthiddenid").value!=""){	
		//alert("inside add" + document.getElementById("txthiddenid").value);
	 	//alert("inside edit" + isEdit);
	 	var url = "addDepartmentsMaster.do?methodtocall=edit&txtdepartment=" + document.getElementById('txtdepartment').value + "&txtdepartmentid=" + document.getElementById('txthiddenid').value;
	 	alert(url);
	 	xmlhttp.open("GET",url,true);
	 	xmlhttp.send();
	 	 
		  }else{
			alert("Please select an entry from grid");
			  }
	}else{
		//alert("inside new");
		//alert("inside " + document.getElementById("txthiddenid").value);
		
	var strval;
	strval = '[';
	var x = introw;
	//alert(introw);
	for(var i=0;i<x;i++){
	strval = strval + '{';
	var comevent=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col2");
	var cominfo=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col3");
	strval = strval + '"comevent":"' + comevent + '","cominfo":"' + cominfo;
	strval = strval + '"}';
		if(i!=(x-1)){
			strval = strval + ',';
				
		}
	}

		strval = strval + ']';*/
		//alert(strval);
		
		
		
		var url = 'TaxHeadMaster.do?methodtocall=add&txttaxheadname=' + document.getElementById('txttaxheadname').value + '&txtpercent=' + document.getElementById('txtpercent').value + '&drpyear=' + document.getElementById('drpyear').value + '&drpstatus=' + document.getElementById('drpstatus').value;	//var url='";
		
		xmlhttp.open("POST",url ,true);
		
		xmlhttp.send();
	}
	//	} 
	//alert(xmlhttp.responseText); 	
}


</script>

<div id="main">
			<div class="container-fluid">
				<div class="page-header">
					<div class="pull-left">
						
					</div>
					
				</div>
				<div class="breadcrumbs">
					<ul>
						<li>
							<a href="#">Home</a>
							<i class="icon-angle-right"></i>
						</li>
						<li>
							<a href="#"> Tax Head Master</a>
						</li>
					</ul>
					<div class="close-bread">
						<a href="#"><i class="icon-remove"></i></a>
					</div>
				</div>
				
				<div class="row-fluid">
					<div class="span12">
						<div class="box box-bordered box-color">
							<div class="box-title">
								<h3><i class="icon-th-list"> Tax Head Master</i> </h3>
							</div>
							<div class="box-content nopadding">
							<%JSONArray returnproject=null;%>
							<%if(request.getParameter("TAXID")!=null&&!(request.getParameter("TAXID").trim().equals(""))){%>
							<%JSONArray returnarr=null;%>
							<%returnarr=CommonUtil.getTaxHeadEdit(request.getParameter("TAXID"));%>
							<%JSONObject returnobj=returnarr.getJSONObject(0);%>
						<form action="" method="POST" class="form-horizontal form-bordered">
									
																
									
									<div class="control-group">
										<label for="textfield" class="control-label">Tax Head Name Name</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txttaxheadname" value="<%=returnobj.get("name") %>" value= type="text" placeholder="Head Name..."  class='ckeditor span12' rows="5" />
                                            
										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Percent Name</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txtpercent" value="<%=returnobj.get("percent") %>" value= type="text" placeholder="Percent..."  class='ckeditor span12' rows="5" />
                                            
										</div>
									</div>
									
									<div class="control-group">
										<label for="textfield" class="control-label">Ac Year</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <select id="drpyear" >
                                            <option value="0" >--Select--</option>
	                                        <%returnproject =CommonUtil.getacyear() ;%>
											<%String partiname="";%>
											<%if(returnproject!=null){%>
												<%for(int xp1=0;xp1<returnproject.length();xp1++){%>
	
													<%JSONObject objjson2= returnproject.getJSONObject(xp1);%>
													
													<%if(returnobj.get("year").toString().trim().equals((String)objjson2.get("id"))){
														partiname = (String)objjson2.get("name");
													
														}else{%>
													
														
														<option value="<%=objjson2.get("id")%>" ><%=objjson2.get("name")%></option>
														<%} %>
										  			<%}%>
											<%}%> 
                                            
                                            <%if(partiname!=""){ %>
                                            <option value="<%=returnobj.get("year")%>" selected><%=partiname%></option>
											<%} %>
                                       
                                            </select>

                                            
										</div>
									</div>
									
									<div class="control-group">
										<label for="textfield" class="control-label">Status</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <select id="drpstatus" >
                                            <option value="0" >--Select--</option>
	                                     	<%if(returnobj.get("status").equals("Active")){%>													
											
											<option value="Dormant">Dormant</option>
											<option value="Active" SELECTED>Active</option>
											<%}else{ %>
											<option value="Active" >Active</option>
											<option value="Dormant" SELECTED>Dormant</option>
											<%} %>
                                            </select>

                                            
										</div>
									</div>
									
									
									
									<div class="form-actions">
                                        
                                        <button type="button" class="btn btn-primary" onclick="editsave();">Save</button>
                                        
										<button type="button" class="btn">Cancel</button>
									</div>
								</form>
								<%}else{%>
								
														<form action="" method="POST" class="form-horizontal form-bordered">
									<div class="control-group">
										<label for="textfield" class="control-label">Tax Head Name Name</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txttaxheadname" value="" value= type="text" placeholder="Head Name..."  class='ckeditor span12' rows="5" />
                                            
										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Percent Name</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txtpercent" value="" value= type="text" placeholder="Percent..."  class='ckeditor span12' rows="5" />
                                            
										</div>
									</div>
									
									<div class="control-group">
										<label for="textfield" class="control-label">Ac Year</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <select id="drpyear" >
                                            
	                                        <%returnproject =CommonUtil.getacyear() ;%>
											<%String partiname="";%>
											<%if(returnproject!=null){%>
												<%for(int xp1=0;xp1<returnproject.length();xp1++){%>
	
													<%JSONObject objjson2= returnproject.getJSONObject(xp1);%>
														
														<option value="<%=objjson2.get("id")%>" selected><%=objjson2.get("name")%></option>
														
										  			<%}%>
											<%}%> 
                                            
                                            <option value="0" selected>--Select--</option>
                                       
                                            </select>

                                            
										</div>
									</div>
									
									<div class="control-group">
										<label for="textfield" class="control-label">Status</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <select id="drpstatus" >
                                            <option value="0" selected>--Select--</option>
	                                     														
											<option value="Active" >Active</option>
											<option value="Dormant">Dormant</option>
								
                                            </select>

                                            
										</div>
									</div>
									
									
									<div class="form-actions">
                                        
                                        <button type="button" class="btn btn-primary" onclick="savedata();">Save</button>

										<button type="button" class="btn">Cancel</button>
									</div>
								</form>
								
								<%} %>
							</div>
						</div>
					</div>
				</div>
				
                <div id="diverror"></div>
							
                
                <div class="row-fluid">
					<div class="span12">
						<div class="box">
							<div class="box-title">
								<h3>
									<i class="icon-table">Tax Head Master List</i>
									
								</h3>
							</div>
							<div id="Grid1" class="box-content nopadding">
								<table class="table table-hover table-nomargin table-bordered dataTable-columnfilter dataTable">
									<thead>
										<tr class="thefilter">
											<th>Tax Name</th>
                                            <th>Percent</th>
                                            <th>Year</th>
                                            <th>Status</th>
											<th>Edit</th>
										</tr>
										<tr>
											<th>Tax Name</th>
                                            <th>Percent</th>
                                            <th>Year</th>
                                            <th>Status</th>
                                            <th>Edit</th>
										</tr>
									</thead>
                                    <tbody>
                                    
					
					
					<%returnproject =CommonUtil.getTaxheadAll() ;%>
					<%int introw2=0;%>
					<%if(returnproject!=null){%>
							<%for(int xp1=0;xp1<returnproject.length();xp1++){%>

								<%JSONObject objjson2= returnproject.getJSONObject(xp1);%>
									 
								<tr>
									<td><%=objjson2.get("name")%>
									</td>
									<td><%=objjson2.get("percent")%>
									</td>
									<td><%=objjson2.get("year")%>
									</td>
									<td><%=objjson2.get("status")%>
									</td>
									<td><a href="taxhead.do?TAXID=<%=objjson2.get("id")%>">Edit</a>
									</td>
								</tr>
								<%introw2=introw2+1; %>
				  			<%}%>
				  	<%}%>                                                                            
					
                                    </tbody>
									
								</table>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>


               
  
