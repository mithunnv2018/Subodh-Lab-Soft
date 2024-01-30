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

<%if(request.getParameter("BILLID")!=null&&!(request.getParameter("BILLID").trim().equals(""))){%>
var isEdit = true;
var parampartyid = <%=request.getParameter("BILLID")%>;
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
function popamount(){
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

			document.getElementById("txtamount").value = resp;
		 
	     }
	  }

	xmlhttp.open("GET","Bill.do?methodtocall=getAmount&drpclient=" + document.getElementById("drpclient").value + "&drpparticulars=" + document.getElementById("drpparticulars").value,true);
	xmlhttp.send();
}

function validation(){
	loaddoc();
	/*if(document.getElementById('txttaxheadname').value == ""){
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
	}   */
		return true;
}

var arrparti=new Array(); 
var arrbillrefer=new Array();

var lengthparti = 0;
var lengthbillrefer = 0;
var totalamt = 0;

function addtoarray(){

	var objparti=new Object();
	objparti.particularsid=document.getElementById('drpparticulars').value;
	objparti.particulars=drpparticulars.options[drpparticulars.selectedIndex].text;//document.getElementById('drpparticulars').value;
	objparti.amount=document.getElementById('txtamount').value;
	objparti.quantity=document.getElementById('txtquantity').value;
	objparti.totalamount=parseFloat(document.getElementById('txtamount').value) * parseFloat(document.getElementById('txtquantity').value); 

	arrparti[lengthparti] = objparti;
	lengthparti = lengthparti + 1;
}
function addtoarraybillrefer(){

	var objparti=new Object();
	objparti.billreferid = document.getElementById('drpbillreference').value;
	objparti.billrefername=drpbillreference.options[drpbillreference.selectedIndex].text;//document.getElementById('drpparticulars').value;
	objparti.billrefervalue=document.getElementById('txtbillrefervalue').value;
	
	arrbillrefer[lengthbillrefer] = objparti;
	lengthbillrefer = lengthbillrefer + 1;
}

function deletetoarraybillrefer(index1){
	var arrbillrefertemp=new Array();
	
	var introwx = 0;
	for(i=0;i<arrbillrefer.length;i++){
		var objparti=new Object();
		objparti=arrbillrefer[i];
		
		if(index1!=i){
		
		arrbillrefertemp[introwx] = objparti;
		introwx = introwx + 1;
		}
	}
	arrbillrefer = arrbillrefertemp;
	lengthbillrefer = introwx;
	
	updatebillrefgrid();
		
}
function updatebillrefgrid(){
	
	totalamt = 0;
	var bodystr="";
   	bodystr = bodystr+'<table class="table table-hover table-nomargin">';
	bodystr = bodystr+'<thead><tr ><th>Bill Reference Name</th><th>Value</th><th>Delete</th> </thead>';
	bodystr = bodystr+' <tbody>';
	
	for(i=0;i<arrbillrefer.length;i++){
		var objparti=new Object();
		objparti=arrbillrefer[i];
		
		bodystr = bodystr+'<tr>';
		bodystr = bodystr+'<td>' +objparti.billrefername;
		bodystr = bodystr+'</td>';
		bodystr = bodystr+'<td>'+objparti.billrefervalue;
		bodystr = bodystr+'</td>';
		bodystr = bodystr+'<td><a href="javascript:void(0);" onclick="deletetoarraybillrefer('+ i + ');">Delete</a>';
		bodystr = bodystr+'</td>';
		bodystr = bodystr+'</tr>';
		
	}
 
   	bodystr = bodystr+'</tbody></table>';
	$("#GridBillRefer").html(bodystr);
	
}
function addbillrefgrid(){

	addtoarraybillrefer();
	
	updatebillrefgrid();
		
}

function getbillref(){
	
	var griddata='';
	griddata = griddata + '[';
	for(i=0;i<arrbillrefer.length;i++){
		
		var objparti=new Object();
		objparti=arrbillrefer[i];
				
		griddata = griddata + '{';

		griddata = griddata + '"id":' + '"'+ objparti.billreferid + '",';
		griddata = griddata + '"name":' + '"'+ objparti.billrefername + '",';
		griddata = griddata + '"value":' + '"'+ objparti.billrefervalue + '"';

		griddata = griddata + '}';
		if(i!=arrbillrefer.length-1){
			griddata = griddata + ',';
		}
		
	}
	griddata = griddata + ']';
	return griddata;
	
}

function getbillparti(){
	
	var griddata='';
	griddata = griddata + '[';
	for(i=0;i<arrparti.length;i++){
		
		var objparti=new Object();
		objparti=arrparti[i];
				
		griddata = griddata + '{';

		griddata = griddata + '"id":' + '"'+ objparti.particularsid + '",';
		griddata = griddata + '"amount":' + '"'+ objparti.amount + '",';
		griddata = griddata + '"quantity":' + '"'+ objparti.quantity + '"';

		griddata = griddata + '}';
		if(i!=arrparti.length-1){
			griddata = griddata + ',';
		}
		
		
	}
	griddata = griddata + ']';
	return griddata;
}

function deletetoarraybillparti(index1){
	var arrbillrefertemp=new Array();
	
	var introwx = 0;
	for(i=0;i<arrparti.length;i++){
		var objparti=new Object();
		objparti=arrparti[i];
		
		if(index1!=i){
		
		arrbillrefertemp[introwx] = objparti;
		introwx = introwx + 1;
		}
	}
	arrparti = arrbillrefertemp;
	lengthparti = introwx;
	
	updatebillparti();
	updatetaxgrid();
		
}

function updatebillparti(){
	totalamt = 0;
	var bodystr="";
   	bodystr = bodystr+'<table class="table table-hover table-nomargin">';
	bodystr = bodystr+'<thead><tr ><th>Particulars Name</th><th>Amount</th>  <th>Quantity</th><th>Total Amount</th><th>Delete</th></tr></thead>';
	bodystr = bodystr+' <tbody>';
	
	for(i=0;i<arrparti.length;i++){
		var objparti=new Object();
		objparti=arrparti[i];
		bodystr = bodystr+'<tr>';
		bodystr = bodystr+'<td>' +objparti.particulars;
		bodystr = bodystr+'</td>';
		bodystr = bodystr+'<td>'+objparti.amount;
		bodystr = bodystr+'</td>';
		bodystr = bodystr+'<td>'+objparti.quantity;
		bodystr = bodystr+'</td>';
		bodystr = bodystr+'<td>' + objparti.totalamount ;
		bodystr = bodystr+'</td>';
		bodystr = bodystr+'<td><a href="javascript:void(0);" onclick="deletetoarraybillparti('+ i + ');">Delete</a>';
		bodystr = bodystr+'</td>';
		bodystr = bodystr+'</tr>';
		deletetoarraybillparti
		totalamt = totalamt+ objparti.totalamount;
	}
 
   	bodystr = bodystr+'</tbody></table>';
	$("#Grid2").html(bodystr);
	document.getElementById('txttotal').value = totalamt;

}
function addgrid(){

	addtoarray();
	
	updatebillparti();
	
	updatetaxgrid();
}

function updatetaxgrid(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  	var resp = xmlhttp.responseText;
			var taxtotal=0;
		    var arr = JSON.parse(resp);
		    console.log(resp);
		    var bodystr="";
		   	bodystr = bodystr+'<table class="table table-hover table-nomargin table-striped dataTable dataTable-grouping dataTable-noheader" data-grouping="expandable" id="DataTables_Table_7" aria-describedby="DataTables_Table_7_info" style="width: 1105px;">';
			bodystr = bodystr+'<thead><tr role="row"><th class="sorting" role="columnheader" tabindex="0" aria-controls="DataTables_Table_7" rowspan="1" colspan="1" style="width: 280px;" aria-label="Browser: activate to sort column ascending">Tax Head</th><th class="hidden-350 sorting" role="columnheader" tabindex="0" aria-controls="DataTables_Table_7" rowspan="1" colspan="1" style="width: 258px;" aria-label="Platform(s): activate to sort column ascending">Percent</th><th class="hidden-1024 sorting" role="columnheader" tabindex="0" aria-controls="DataTables_Table_7" rowspan="1" colspan="1" style="width: 278px;" aria-label="Engine version: activate to sort column ascending">Amount</th></tr></thead>';
			bodystr = bodystr+' <tbody role="alert" aria-live="polite" aria-relevant="all">';
		   	for(var x=0;x<arr.length;x++){
		   	
				//$('#drpState').append('<option value="' + arr[x].id + '">' + arr[x].state + '</option>');
				bodystr = bodystr+'<tr class="even group-item group-item-misc" data-group="misc" style="display: table-row;">';
				bodystr = bodystr+'<td><input type="hidden" id="txthiddentaxid" value="' + arr[x].id +'"/>' +arr[x].name;
				bodystr = bodystr+'</td>';
				bodystr = bodystr+'<td>'+arr[x].percent;
				bodystr = bodystr+'</td>';
				var disamt =  parseFloat (document.getElementById('txttotal').value) / 100;
				disamt = parseFloat(disamt) * parseFloat(arr[x].percent);
				bodystr = bodystr+'<td>' + disamt;
				bodystr = bodystr+'</td>';
				bodystr = bodystr+'</tr>';
				
							
				taxtotal = taxtotal + disamt;
				//alert(arr.subtaxhead);
				var arrsub= arr[x].subtaxhead;
				
				//var arr = arrx.emails;
				//alert(arrsub.length);
				if(arrsub.length>0){
					bodystr = bodystr+'<tr id="group-id-DataTables_Table_7_misc"><td class="group misc group-item-expander expanded-group" colspan="4" data-group="misc" data-group-level="0">'+ arr[x].name +'</td></tr>';
					/*bodystr = bodystr+'<table >';
					bodystr = bodystr+'<thead><tr ><th>Sub Tax Head</th><th>Percent</th>  <th>Amount</th></tr></thead>';
					bodystr = bodystr+' <tbody>';*/
					for(var x1=0;x1<arrsub.length;x1++){
						
						bodystr = bodystr+'<tr class="odd group-item group-item-misc" data-group="misc" style="display: table-row;">';
						bodystr = bodystr+'<td><input type="hidden" id="txthiddentaxid" value="' + arrsub[x1].id +'"/>' +arrsub[x1].name;
						bodystr = bodystr+'</td>';
						bodystr = bodystr+'<td>'+arrsub[x1].percent;
						bodystr = bodystr+'</td>';
						var disamt2 =  parseFloat (disamt) / 100;
						disamt2 = parseFloat(disamt2) * parseFloat(arrsub[x1].percent);
						bodystr = bodystr+'<td>' + disamt2;
						bodystr = bodystr+'</td>';
						bodystr = bodystr+'</tr>';
						
						taxtotal = taxtotal + disamt2;
					}
					/*bodystr = bodystr+'</tbody></table>';
					bodystr = bodystr+'</td></tr>';*/
				}
				
		   	}
		   	
			bodystr = bodystr+'</tbody></table>';
			console.log(bodystr);
			$("#DataTables_Table_7_wrapper").html(bodystr);
			
			document.getElementById('txttaxes').value = taxtotal + parseFloat (document.getElementById('txttotal').value);
			
			if(document.getElementById('txtdiscount').value.trim()==""){
				document.getElementById('txtfinal').value=taxtotal + parseFloat (document.getElementById('txttotal').value);
			}else{
				document.getElementById('txtfinal').value=(taxtotal + parseFloat (document.getElementById('txttotal').value))-parseFloat(document.getElementById('txtdiscount').value);
			}
		   	
	    }
	  }
	
	
	var url = 'Bill.do?methodtocall=getTaxhead';
	
	xmlhttp.open("POST",url ,true);
	
	xmlhttp.send();
		
}

function calculatefinal(){
	if(document.getElementById('txtdiscount').value.trim()==""){
		document.getElementById('txtfinal').value= parseFloat (document.getElementById('txttaxes').value);
	}else{
		//alert("amt: " + document.getElementById('txttaxes').value + " dis: " + document.getElementById('txtdiscount').value);
		document.getElementById('txtfinal').value=parseFloat (document.getElementById('txttaxes').value)-parseFloat(document.getElementById('txtdiscount').value);
	}
}

function updateGrid(){
	
		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
			  var resp = xmlhttp.responseText;
			 	var arr = JSON.parse(resp);
			   	var bodystr="";
			   	bodystr = bodystr+'<table class="table table-hover table-nomargin">';
				bodystr = bodystr+'<thead><tr ><th>Particulars Name</th><th>Amount</th>  <th>Quantity</th><th>Total Amount</th></tr></thead>';
				bodystr = bodystr+' <tbody>';
			   	for(var x=0;x<arr.length;x++){
			   	
					bodystr = bodystr+'<tr>';
					bodystr = bodystr+'<td>' +document.getElementById('drpparticulars').value;
					bodystr = bodystr+'</td>';
					bodystr = bodystr+'<td>'+document.getElementById('txtamount').value;
					bodystr = bodystr+'</td>';
					bodystr = bodystr+'<td>'+document.getElementById('txtquantity').value;
					bodystr = bodystr+'</td>';
					bodystr = bodystr+'<td>' + parseFloat(document.getElementById('txtamount').value) * parseFloat(document.getElementById('txtquantity').value) ;
					bodystr = bodystr+'</td>';
					bodystr = bodystr+'</tr>';
					
					
			   	}
			   	bodystr = bodystr+'</tbody></table>';
				$("#Grid2").html(bodystr);
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

	
	
	var url = 'TaxHeadMaster.do?methodtocall=edit&taxid=<%=request.getParameter("BILLID")%>&txttaxheadname=' + document.getElementById('txttaxheadname').value + '&txtpercent=' + document.getElementById('txtpercent').value + '&drpyear=' + document.getElementById('drpyear').value + '&drpstatus=' + document.getElementById('drpstatus').value;	//var url='";
	
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
		    if(xmlhttp.responseText!="false"){
		    	alert("Data Saved Successfully");
			
	    	//updateGrid();
			//document.location = "bill.do";
	    	
	    	$("#billnos").html(xmlhttp.responseText);
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
		 
		
		
		var url = 'Bill.do?methodtocall=add&drpclient=' + document.getElementById('drpclient').value + '&txttotal=' + document.getElementById('txttotal').value + '&txttaxes=' + document.getElementById('txttaxes').value + '&txtdiscount=' + document.getElementById('txtdiscount').value + '&txtfinal=' + document.getElementById('txtfinal').value  + '&getbillref=' + getbillref()  + '&getbillparti=' + getbillparti();	//var url='";
		
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
							<a href="#"> Bill</a>
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
								<h3><i class="icon-th-list"> Bill</i> </h3>
							</div>
							<div class="box-content nopadding">
							<%JSONArray returnproject=null;%>
							<%if(request.getParameter("BILLID")!=null&&!(request.getParameter("BILLID").trim().equals(""))){%>
							<%JSONArray returnarr=null;%>
							<%returnarr=CommonUtil.getTaxHeadEdit(request.getParameter("BILLID"));%>
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
										<label for="textarea" class="control-label">Bill No.</label>
										<div class="controls">
                                            <div id="billnos" style="float:left" >123/</div>                                
                                            <div id="billnos2" style="float:left" ><select id="drpbillnotype" >
                                            		<option value="0" >--Select--</option>
													<option value="MK" >MK</option>
													<option value="NK" selected>NK</option>
                                            </select>                                                      
											/13-14
											</div>
										</div>
									</div>
								
								<div class="control-group">
										<label for="textfield" class="control-label"><b>Add References: -</b></label>
										
									</div>
								<div class="control-group">
										<label for="textarea" class="control-label">Select Bill References</label>
										<div class="controls">
                                                                                          
                                            <select id="drpbillreference" >
                                            <option value="0" >--Select--</option>
                                        <%returnproject =CommonUtil.getBillReferencesAll();%>
										
										<%if(returnproject!=null){%>
											<%for(int xp1=0;xp1<returnproject.length();xp1++){%>

												<%JSONObject objjson2= returnproject.getJSONObject(xp1);%>
													
													<option value="<%=objjson2.get("id")%>" ><%=objjson2.get("name")%></option>
													
									  			<%}%>
										<%}%> 
                                            
                                            
                                            
                                            </select>
                                                                                                                              

										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Value</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txtbillrefervalue" value="" value= type="text" placeholder="Value.."  class='ckeditor span12' rows="5" />
                                            
										</div>
									</div>
								
								<div class="control-group">
										
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                             <button type="button" class="btn btn-primary" onclick="addbillrefgrid();">Add</button>
                                            
										</div>
									</div>
								<div class="control-group">
										
										
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <div id="GridBillRefer" class="box-content nopadding"></div>
                                            
										
									</div>
								<div class="control-group">
										<label for="textarea" class="control-label">Select Client</label>
										<div class="controls">
                                                                                          
                                            <select id="drpclient" >
                                            <option value="0" >--Select--</option>
                                        <%returnproject =CommonUtil.getClient();%>
										
										<%if(returnproject!=null){%>
											<%for(int xp1=0;xp1<returnproject.length();xp1++){%>

												<%JSONObject objjson2= returnproject.getJSONObject(xp1);%>
													
													<option value="<%=objjson2.get("id")%>" ><%=objjson2.get("name")%></option>
													
									  			<%}%>
										<%}%> 
                                            
                                            
                                            
                                            </select>
                                                                                                                              

										</div>
									</div>
									
									<div class="control-group">
										<label for="textfield" class="control-label"><b>Add Particulars : -</b></label>
										
									</div>
									<div class="control-group">
										<label for="textarea" class="control-label">Select Particulars</label>
										<div class="controls">
                                                                                          
                                            <select id="drpparticulars" onchange="popamount();">
                                            <option value="0" >--Select--</option>
                                        <%returnproject =CommonUtil.getParticularsAll();%>
										
										<%if(returnproject!=null){%>
											<%for(int xp1=0;xp1<returnproject.length();xp1++){%>

												<%JSONObject objjson2= returnproject.getJSONObject(xp1);%>
													
													<option value="<%=objjson2.get("id")%>" ><%=objjson2.get("name")%></option>
													
									  			<%}%>
										<%}%> 
                                            
                                            
                                            
                                            </select>
                                                                                                                              

										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Amount</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txtamount" value="" value= type="text" placeholder="Amount..."  class='ckeditor span12' rows="5" />
                                            
										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Quantity</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txtquantity" value="" value= type="text" placeholder="Quantity..."  class='ckeditor span12' rows="5" />
                                            
										</div>
									</div>
									<div class="control-group">
										
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                             <button type="button" class="btn btn-primary" onclick="addgrid();">Add</button>
                                            
										</div>
									</div>
									<div class="control-group">
										
										
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <div id="Grid2" class="box-content nopadding"></div>
                                            
										
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Total</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txttotal" value="" value= type="text" placeholder="Total.."  class='ckeditor span12' rows="5" disabled />
                                            
										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label"><b>Taxes : -</b></label>
										
									</div>
									<div class="control-group">
										
										
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">
                                            <div id="Grid3" class="box-content nopadding">-->
                                <div id="DataTables_Table_7_wrapper" class="dataTables_wrapper" role="grid">
                                        </div>
                                            
										
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Taxes + Total Amount</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txttaxes" value="" value= type="text" placeholder="Taxes Total Amount.."  class='ckeditor span12' rows="5" disabled />
                                            
										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Discount</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txtdiscount" value="0" value= type="text" onkeyup="calculatefinal();" placeholder="Total.."  class='ckeditor span12' rows="5"  />
                                            
										</div>
									</div>
									<div class="control-group">
										<label for="textfield" class="control-label">Final Total</label>
										<div class="controls">
											<!--<input type="text" name="textfield" id="textfield" placeholder="Text input" class="input-xlarge">-->
                                            <input ID="txtfinal" value="" value= type="text" placeholder="Total.."  class='ckeditor span12' rows="5"  />
                                            
										</div>
									</div>
									<div class="form-actions">
                                        
                                        <button type="button" class="btn btn-primary" onclick="savedata();">Save</button>

										<button type="button" class="btn" >Cancel</button>
									</div>
								</form>
								
								<%} %>
							</div>
						</div>
					</div>
				</div>
				
                <div id="diverror"></div>
							
                
          <!--     <div class="row-fluid">
					<div class="span12">
						<div class="box">
							<div class="box-title">
								<h3>
									<i class="icon-table">Bill  List</i>
									
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
									<td><a href="taxhead.do?BILLID=<%=objjson2.get("id")%>">Edit</a>
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
				-->
			</div>
		</div>


               
  
