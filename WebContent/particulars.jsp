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

<%if(request.getParameter("PARTICULARSID")!=null&&!(request.getParameter("PARTICULARSID").trim().equals(""))){%>
var isEdit = true;
var parampartyid = <%=request.getParameter("PARTICULARSID")%>;
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
	if(document.getElementById('name').value == ""){
		alert("Please enter particulars name");
		return false;
	} 
	if(document.getElementById('amount').value == ""){
		alert("Please enter amount");
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
			document.location = "particulars.do"; 
	    	//window.location("particulars.do");
		
		    }else{
			    	alert("Data Not Saved Successfully");
			}
			
	    }
	  }

	
	var url = 'ParticularsMaster.do?methodtocall=edit&particularsid=<%=request.getParameter("PARTICULARSID")%>&name=' + document.getElementById('name').value + '&amount=' + document.getElementById('amount').value ;
	
	//alert(" after call" + url);
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
			document.location = "particulars.do";
	    	
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
		
		
		
		var url = 'ParticularsMaster.do?methodtocall=add&name=' + document.getElementById('name').value + '&amount=' + document.getElementById('amount').value;	//var url='";
		
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
							<a href="#"> Particulars Master</a>
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
								<h3><i class="icon-th-list"> Particulars Master</i> </h3>
							</div>
							<div class="box-content nopadding">
							<%JSONArray returnproject=null;%>
							<%if(request.getParameter("PARTICULARSID")!=null&&!(request.getParameter("PARTICULARSID").trim().equals(""))){%>
							<%JSONArray returnarr=null;%>
							<%returnarr=CommonUtil.getParticularsEdit(request.getParameter("PARTICULARSID"));%>
							<%JSONObject returnobj=returnarr.getJSONObject(0);%>
						<form action="" method="POST" class="form-horizontal form-bordered">
									<div class="control-group">
										<label for="textfield" class="control-label">Particulars Name</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="name" value="<%=returnobj.get("name") %>" value= type="text" placeholder="Particulars.."  class='ckeditor span12' rows="5" />
                                            
										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Amount</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="amount" value="<%=returnobj.get("amount") %>" type="text" placeholder="Amount.."  class='ckeditor span12' rows="5" />
                                            
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
										<label for="textfield" class="control-label">Particulars Name</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="name" value="" value= type="text" placeholder="Particulars.."  class='ckeditor span12' rows="5" />
                                            
										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Amount</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="amount" value="" type="text" placeholder="Amount.."  class='ckeditor span12' rows="5" />
                                            
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
									<i class="icon-table">Particulars Master List</i>
									
								</h3>
							</div>
							<div id="Grid1" class="box-content nopadding">
								<table class="table table-hover table-nomargin table-bordered dataTable-columnfilter dataTable">
									<thead>
										<tr class="thefilter">
											<th>Name</th>
                                            <th>Amount</th>
                                            
											<th>Edit</th>
										</tr>
										<tr>
											<th>Name</th>
                                            <th>Amount</th>
											
                                            <th>Edit</th>
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
									<td><a href="particulars.do?PARTICULARSID=<%=objjson2.get("id")%>">Edit</a>
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


               
  
