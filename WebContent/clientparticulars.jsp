<%@page import="com.esaya.util.QuickUtil"%>
<%@page import="com.commons.CommonUtil"%>
<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="/WEB-INF/struts-html" prefix="html" %>    
<%JSONArray returnproject=null;%>
<script language="javascript">
var xmlhttp=null; 

<%if(request.getParameter("CLIENTID")!=null&&!(request.getParameter("CLIENTID").trim().equals(""))){%>
var isEdit = true;
var parampartyid = '<%=request.getParameter("CLIENTID")%>'; 
<%}else{%>
var isEdit = false;	
<%}%>

<%returnproject =CommonUtil.getParticularsAll() ;%>
var lengthdiscount = <%=returnproject.length()%>;
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
	if(document.getElementById('drpclient').value == "0"){
		alert("Please enter particulars name");
		return false;
	} 
	if(document.getElementById('txtdiscount').value == ""){
		alert("Please enter discount");
		return false;
	}
	for(var i=0;i<lengthdiscount;i++){
		if(document.getElementById('txtdiscount'+i).value == ""||document.getElementById('txtfinalamt'+i).value == "")
		{
			alert("Please enter appropriate data at Row: " + i+1);
			return false;
		}
	}
		return true;
}
function onclickclient(){

	document.location = "clientparticulars.do?CLIENTID=" + document.getElementById('drpclient').value;
	
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
			document.location = "particulars.do"; 
	    	//window.location("particulars.do");
		
		    }else{
			    	alert("Data Not Saved Successfully");
			}
			
	    }
	  }

	
	var url = 'ParticularsMaster.do?methodtocall=edit&particularsid=<%=request.getParameter("CLIENTID")%>&name=' + document.getElementById('name').value + '&amount=' + document.getElementById('amount').value ;
	
	//alert(" after call" + url);
	xmlhttp.open("POST",url ,true);
	//alert(" after call" + url);
	xmlhttp.send();
	}
	
	
}

function updateamt(txtindex){
	//alert("alert" + document.getElementById('txtdiscount'+txtindex).value + ":" + document.getElementById('txthiddenamt'+txtindex).value);
	if(document.getElementById('txtdiscount'+txtindex).value==""){
		document.getElementById('txtfinalamt'+txtindex).value = document.getElementById('txthiddenamt'+txtindex).value;
		return false;
	}
	var disamt =  parseFloat (document.getElementById('txthiddenamt'+txtindex).value) / 100 ;
	disamt =  parseFloat(document.getElementById('txtdiscount'+txtindex).value * disamt);
	//document.getElementById('txtdiscount'+xi).value = document.getElementById('txtdiscount').value;
	//alert(disamt);
	document.getElementById('txtfinalamt'+txtindex).value = parseFloat(document.getElementById('txthiddenamt'+txtindex).value - disamt);
	
}
function updatediscount(txtindex){

	if(document.getElementById('txtfinalamt'+txtindex).value!=""){
		
	var r=document.getElementById('txtfinalamt'+txtindex).value; 
	var r1=document.getElementById('txthiddenamt'+txtindex).value; 

		var b1=(+r1)-(+r);
	    var b2=(+b1)/(+r1);
	    var res=(+b2)*100;
	    document.getElementById('txtdiscount'+txtindex).value= res;

	}
	
}

function getgriddata(){

	
	var griddata='';

	griddata = griddata + '[';
	for(i=0;i<lengthdiscount;i++){

		var finalamt=document.getElementById('txtfinalamt'+i).value;
		var disc = document.getElementById('txtdiscount'+i).value;
		var gridid = document.getElementById('txthiddenid'+i).value;
		
		griddata = griddata + '{';

		griddata = griddata + '"id":' + '"'+ gridid + '",';
		griddata = griddata + '"amount":' + '"'+ finalamt + '",';
		griddata = griddata + '"discount":' + '"'+ disc + '"';

		griddata = griddata + '}';
		if(i!=0||i!=lengthdiscount-1){
			griddata = griddata + ",";
		}		
	}
	griddata = griddata + ']';
	
	return griddata;
}

function calcdiscountedamt(){
	for(xi=0;xi<lengthdiscount;xi++){
		var disamt =  parseFloat (document.getElementById('txthiddenamt'+xi).value) / 100 ;
		disamt =  parseFloat(document.getElementById('txtdiscount'+xi).value * disamt);
		//document.getElementById('txtdiscount'+xi).value = document.getElementById('txtdiscount').value;
		//alert(disamt);
		document.getElementById('txtfinalamt'+xi).value = parseFloat(document.getElementById('txthiddenamt'+xi).value - disamt);
		
	}
}

function apply(){

 	//alert("apply");
	for(xi=0;xi<lengthdiscount;xi++){
		//alert("disc" + xi);
		
		document.getElementById('txtdiscount'+xi).value = document.getElementById('txtdiscount').value;
		
	}
	calcdiscountedamt();
	
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
			document.location = "clientparticulars.do";
	    	
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
		
		
		
		var url = 'ClientParticularsMaster.do?methodtocall=add&drpclient=' + document.getElementById('drpclient').value + '&txtdiscount=' + document.getElementById('txtdiscount').value + '&griddata=' + getgriddata();	//var url='";
		
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
							<a href="#">Client-Wise Price Master</a>
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
								<h3><i class="icon-th-list">Client-Wise Price Master</i> </h3>
							</div>
							<div class="box-content nopadding">
							
							<%if(request.getParameter("CLIENTID")!=null&&!(request.getParameter("CLIENTID").trim().equals(""))){%>
							<%JSONArray returnarr=null;%>
							<%//returnarr=CommonUtil.getParticularsEdit(request.getParameter("CLIENTID"));%>
							<%//JSONObject returnobj=returnarr.getJSONObject(0);%>
						<form action="" method="POST" class="form-horizontal form-bordered">
								
									<div class="control-group">
										<label for="textarea" class="control-label">Select Client</label>
										<div class="controls">
                                                                                          
                                            <select id="drpclient" onchange="onclickclient();">
                                            <option value="0" >--Select--</option>
                                        <%returnproject =CommonUtil.getClient();%>
										<%String partiname="";%>
										<%if(returnproject!=null){%>
											<%for(int xp1=0;xp1<returnproject.length();xp1++){%>

												<%JSONObject objjson2= returnproject.getJSONObject(xp1);%>
													<%if(request.getParameter("CLIENTID").equals(objjson2.get("id"))){ 
														partiname= (String)objjson2.get("name");
													}else{ %>
													<option value="<%=objjson2.get("id")%>" ><%=objjson2.get("name")%></option>
													<%} %>
									  			<%}%>
										<%}%> 
                                            
                                            
                                            <option value="<%=request.getParameter("CLIENTID")%>" selected><%=partiname %></option>
                                            </select>
                                                                                                                              

										</div>
									</div>

									<div class="control-group">
										<label for="textfield" class="control-label">Discount</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txtdiscount" value="<%=CommonUtil.getdiscountamt(request.getParameter("CLIENTID"))%>" type="text" placeholder="Amount.."  class="input-xlarge" rows="5" /> %
                                            <button type="button" class="btn btn-primary" onclick="apply();">Apply</button>
										</div>
									</div>
 
									<div class="control-group">
																	<div id="Grid1" class="box-content nopadding">
								<table class="table table-hover table-nomargin table-bordered dataTable-columnfilter dataTable">
									<thead>
										<tr class="thefilter">
											<th>Name</th>
                                            <th>Amount</th>
                                            <th>Discount</th>
                                            <th>Final Amount</th>
											
										</tr>
										<tr>
											<th>Name</th>
                                            <th>Amount</th>
                                            <th>Discount</th>
                                            <th>Final Amount</th>
											
										</tr>
									</thead>
                                    <tbody>
                                    
					
						                                                         
					
					<%returnproject =CommonUtil.getParticularsAll(request.getParameter("CLIENTID")) ;%>
					<%int introw2=0;%>
					<%if(returnproject!=null){%>
							<%for(int xp1=0;xp1<returnproject.length();xp1++){%>

								<%JSONObject objjson2= returnproject.getJSONObject(xp1);%>
									 
								<tr>
									<td><%=objjson2.get("name")%>
									</td>
									<td><%=objjson2.get("amount")%>
									</td>									
									<td><input type="text" value="<%=objjson2.get("discount")%>"" onkeyup="updateamt(<%=introw2%>);" id="txtdiscount<%=introw2%>" name="txtdiscount<%=introw2%>"/>
									</td>
									<td><input type="text" value="<%=objjson2.get("finalamount")%>" onkeyup="updatediscount(<%=introw2%>);" id="txtfinalamt<%=introw2%>" name="txtfinalamt<%=introw2%>"/><input type="hidden" id="txthiddenamt<%=introw2%>" value="<%=objjson2.get("amount")%>" name="txthiddenamt<%=introw2%>"/> <input type="hidden" id="txthiddenid<%=introw2%>" value="<%=objjson2.get("id")%>" name="txthiddenid<%=introw2%>"/>
									</td>
								</tr>
								<%introw2=introw2+1; %>
				  			<%}%>
				  	<%}%>               
				  		             
				  			
								
                                    </tbody>
									
								</table>
								 
							</div>
									</div>
					
							<div class="form-actions">
                                        
                                        <button type="button" class="btn btn-primary" onclick="savedata();">Save</button>
                                        
										<button type="button" class="btn">Cancel</button>
									</div>
								</form>
								<%}else{%>
								
						<form action="" method="POST" class="form-horizontal form-bordered">
								
									<div class="control-group">
										<label for="textarea" class="control-label">Select Client</label>
										<div class="controls">
                                                                                          
                                            <select id="drpclient" onchange="onclickclient();" >
                                             
                                        <%returnproject =CommonUtil.getClient();%>
										
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
										<label for="textfield" class="control-label">Discount</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txtdiscount" value="<%//=returnobj.get("amount") %>" type="text" placeholder="Amount.."  class="input-xlarge" rows="5" /> %
                                            <button type="button" class="btn btn-primary" onclick="apply();">Apply</button>
										</div>
									</div>
 
									<div class="control-group">
																	<div id="Grid1" class="box-content nopadding">
								<table class="table table-hover table-nomargin table-bordered dataTable-columnfilter dataTable">
									<thead>
										<tr class="thefilter">
											<th>Name</th>
                                            <th>Amount</th>
                                            <th>Discount</th>
                                            <th>Final Amount</th>
											
										</tr>
										<tr>
											<th>Name</th>
                                            <th>Amount</th>
                                            <th>Discount</th>
                                            <th>Final Amount</th>
											
										</tr>
									</thead>
                                    <tbody>
                                    
					
					
					<%returnproject =CommonUtil.getParticularsAll() ;%>
					<%int introw2=0;%>
					<%if(returnproject!=null){%>
							<%for(int xp1=0;xp1<returnproject.length();xp1++){%>

								<%JSONObject objjson2= returnproject.getJSONObject(xp1);%>
									 
								<tr>
									<td><%=objjson2.get("name")%>
									</td>
									<td><%=objjson2.get("amount")%>
									</td>									
									<td><input type="text" onkeyup="updateamt(<%=introw2%>);" id="txtdiscount<%=introw2%>" name="txtdiscount<%=introw2%>"/>
									</td>
									<td><input type="text" onkeyup="updatediscount(<%=introw2%>);" id="txtfinalamt<%=introw2%>" name="txtfinalamt<%=introw2%>"/><input type="hidden" id="txthiddenamt<%=introw2%>" value="<%=objjson2.get("amount")%>" name="txthiddenamt<%=introw2%>"/> <input type="hidden" id="txthiddenid<%=introw2%>" value="<%=objjson2.get("id")%>" name="txthiddenid<%=introw2%>"/>
									</td>
								</tr>
								<%introw2=introw2+1; %>
				  			<%}%>
				  	<%}%>               
				  				                                                         
					
								
                                    </tbody>
									
								</table>
								 
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
							
                
              <!--    <div class="row-fluid">
					<div class="span12">
						<div class="box">
							<div class="box-title">
								<h3>
									<i class="icon-table">Particulars Master List</i>
									
								</h3>
							</div>

						</div>
					</div>
				</div>
				-->
			</div>
</div>


             
           
  
