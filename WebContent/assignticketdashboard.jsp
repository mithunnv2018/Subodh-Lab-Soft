<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.esaya.util.FormUtil"%>

<%HttpSession sessionx = request.getSession(true);
String masters="";

%>
        
 <%if(sessionx!=null){ %>
 <%String param = (String)sessionx.getAttribute("user");%>
 <%if(param==null||(param.equals(""))){ %>
 
<script>
	window.location.assign("login.do");
</script>
<%}else{
 	
		if(FormUtil.checkUserRole(request,"dashboard")){
			
		}else{
			
			JSONArray jsonmenu= FormUtil.getUserRoleMaster(request); 
			
			
			if(jsonmenu.length()>0){
				JSONObject objtemp= jsonmenu.getJSONObject(0);
				String module=objtemp.getString("module");
			 	String access=objtemp.getString("access");
	
			 	if(module.equals("role")&&access.equals("YES")){
			 		masters = masters + "userrole.do";
				}
				if(module.equals("department")&&access.equals("YES")){ 
					masters = masters + "departments.do";
				}
				if(module.equals("employeecategory")&&access.equals("YES")){ 
					masters = masters + "demoform.do";
				}
				if(module.equals("mailbox")&&access.equals("YES")){ 
					masters = masters + "mailbox.do";
				} 
				if(module.equals("party")&&access.equals("YES")){ 
					masters = masters + "party.do";              
				}	
				
			}
			
		}
	
	}
 
 } %>

<%if(!masters.equals("")){ %>
<style type="text/css">
.white-popup {
  position: relative;
  background: #FFF;
  padding: 20px;
  width: auto;
  max-width: 500px;
  margin: 20px auto;
}
</style>

<script>
window.location.assign("<%=masters %>");

</script>
<%} %>
<script>
var dialog;
function hidedialog(){
	dialog.hide();
    dojo.destroy(dialog);
}

function showDialog() {


	xmlhttp.onreadystatechange=function()
	{
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	  {
		    //alert("call in popgrid : introw=" + introw);
			var resp = xmlhttp.responseText;


			var arr = JSON.parse(resp);

		    //alert(arr[0].id);
		    //alert(arr[0].empcatname);
			var result='<select id="drpemployee">';
		   	for(var x=0;x<arr.length;x++){
			   	result = result + '<option value="'+ arr[x].id +'">'+ arr[x].fname + ' ' + arr[x].mname  + ' ' + arr[x].lname + '</option>';
		   	}
		   	result = result + '</select>';
	
	
		var drpemployee= result;
		//alert("showdialog: "+drpemployee);
		dialog = new dijit.Dialog({ title: 'Confirmation: Please assign Ticket to an employee' });
	  	dojo.create('div', {
	    innerHTML: 'Please select Employee: '  + drpemployee + '<br/> <input value="Assign" type="button" id="btnupdateticketid" onclick="updateTicketEmployeeId();"/>' 
	  }, dialog.containerNode /* the content portion of the dialog you're creating */);
	  /*var div = dojo.create('div', {}, dialog.containerNode);
	  dojo.create('a', {
	    href: '#',
	    innerHTML: 'Yes',
	    onClick: function() {
	     
	    }
	  }, div);
	  dojo.create('a', {
	    href: '#',
	    innerHTML: 'No',
	    onClick: function() {
	      
	      dialog.hide();
	      dojo.destroy(dialog);
	    }
	  }, div);
		*/
	  dialog.show();

		
		
	  }
	}
		
		xmlhttp.open("GET","addPartyMaster.do?methodtocall=getEmployeelist",true);
		xmlhttp.send();

  }

dojo.require('dijit.Dialog');

dojo.require("dojox.grid.EnhancedGrid");
dojo.require("dojox.grid.enhanced.plugins.Pagination");
dojo.require("dojo.data.ItemFileWriteStore");
dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");

dojo.require("dojox.grid.DataGrid");
dojo.require("dijit.form.Button");
dojo.require("dojo.data.ItemFileWriteStore");
dojo.require("dojox.grid.cells");
dojo.require("dojox.grid.cells.dijit");

var addBtn;

<%//JSONArray returnvalue2 =FormUtil.getTicketAssigning();%>
<%JSONArray returnvalue2 =FormUtil.getTicketAssigning();%>
<%if(returnvalue2!=null){%>
var introw=<%=returnvalue2.length()%>;
<%}else{%>

var introw = 0;

<%}%>

var attachid;
var attachname;
var isattachment=false;

var isEdit=false;
var globalticketid = "";
require(["dijit/Tooltip", "dojo/query!css2", "dojo/domReady!"], function(Tooltip){
    new Tooltip({
        connectId: "myTable",
        selector: "tr",
        getContent: function(matchedNode){
            return matchedNode.getAttribute("tooltipText");
        }
    });
});

dojo.ready(function(){


	//start
	//First we create the buttons to add/del rows
/*  addBtn = new dijit.form.Button({
        id: "addBtn",
        type: "submit",
        label: "Add Row"
    },
    "divAddBtn");//div where the button will load


var delBtn = new dijit.form.Button({
        id: "delBtn",
        type: "submit",
        label: "Delete Selected Rows"
    },
    "divDelBtn");
*/
//Connect to onClick event of this buttons the respective actions to add/remove rows.
//where grid is the name of the grid var to handle.
/*
dojo.connect(addBtn, "onClick", function(event) {
        // set the properties for the new item:

        	alert("inside add grid");
        	var myNewItem = {
            id: grid.rowCount+1,
            col2: "country",
            
        };
        // Insert the new item into the store:
        // (we use store3 from the example above in this example)
        store.newItem(myNewItem);
    });



dojo.connect(delBtn, "onClick", function(event) {
    // Get all selected items from the Grid:
    var items = grid.selection.getSelected();
        if (items.length) {
        // Iterate through the list of selected items.
        // The current item is available in the variable
        // "selectedItem" within the following function:
            dojo.forEach(items, function(selectedItem) {
                if (selectedItem !== null) {
                    // Delete the item from the data store:
                    store.deleteItem(selectedItem);
                } // end if
            }); // end forEach
        } // end if
});
*/	
	//end



	/*set up data store*/
    var data = {
      identifier: 'id',
      items: []
    };
    
    var data_list = [

		<%
		
		if(returnvalue2!=null){%>
		<%for(int x=0;x<returnvalue2.length();x++){
		%>
		<%//JSONObject objjson= new JSONObject();%> 
		<%JSONObject objjson= returnvalue2.getJSONObject(x);%>
		{ id: '<%=x%>', col2: '<%=objjson.get("ticketid")%>',col3:'<%=objjson.get("subject")%>',col4:'<%=objjson.get("from")%>',col5:'<%=objjson.get("date")%>',col6:'<%=objjson.get("status")%>',col7:'<%=objjson.get("priority")%>'}
 		<%if(!(returnvalue2.length()-1==x)){%>
		,<%}%>
		  <%}%>
		<%}%>
     ];
    var rows = 200;
    //alert("Length"+data_list.length);
    for(var i=0; i<data_list.length;  i++){
        //alert("data[" + i + "] : " + data_list[i]);
      data.items.push(dojo.mixin({ id: i+1 }, data_list[i]));
    }
    var store = new dojo.data.ItemFileWriteStore({data: data});
    /*set up layout*/
    var layout = [[
      {name: 'ID', field: 'id',width: "30px", editable : false, hidden:true},
      {name: 'Ticket ID', field: 'col2' ,width: "100px"},
      {name: 'Subject', field: 'col3' ,width: "250px"},
      {name: 'From', field: 'col4' ,width: "100px"},
      {name: 'Date', field: 'col5' ,width: "150px"},
      {name: 'Status', field: 'col6' ,width: "70px"},
      {name: 'Priority', field: 'col7' ,width: "70px"}
            
    ]];

    /*create a new grid:*/
    var grid = new dojox.grid.EnhancedGrid({
        id: 'grid',
        store: store,
        structure: layout,
        rowSelector: '40px',
        query: {col2 :"*"},
	 	selectionMode: "single",
	 	queryOptions: {ignoreCase:true} ,
	 	sortFields: [{attribute: 'col5', descending: true}],
	 	style: "width: 910px; height: 345px;font-size: 13px;font-family:AftasansRegular;",
	 	defaultPageSize: 10,
        plugins: {
		  indirectSelection: {
			 headerSelector:true, width:"40px", styles:"text-align: center;"
		  },
          pagination: {
              pageSizes: ["10","25", "50", "100", "All"],
              description: true,
              sizeSwitch: true,
              pageStepper: true,
              gotoButton: true,
                      /*page step to be displayed*/
              maxPageStep: 4,
                      /*position of the pagination bar*/
              position: "bottom"
          }
        }
    }, document.createElement('div'));

    /*append the new grid to the div*/
    dojo.byId("gridDiv").appendChild(grid.domNode);

    /*Call startup() to render the grid*/
    grid.startup();
    //alert('gird started');
	grid.currentPageSize(10);

	//dojo
	
	var gridx1 = new dojox.grid.EnhancedGrid({
        id: 'gridx1',
        store: store,
        structure: layout,
        rowSelector: '40px',
        query: {col2 :"*"},
	 	selectionMode: "single",
	 	queryOptions: {ignoreCase:true} ,
	 	style: "width: 910px; height: 345px;font-size: 13px;font-family:AftasansRegular;",
	 	defaultPageSize: 10,
        plugins: {
		  indirectSelection: {
			 headerSelector:true, width:"40px", styles:"text-align: center;"
		  },
          pagination: {
              pageSizes: ["10","25", "50", "100", "All"],
              description: true,
              sizeSwitch: true,
              pageStepper: true,
              gotoButton: true,
                      /*page step to be displayed*/
              maxPageStep: 4,
                      /*position of the pagination bar*/
              position: "bottom"
          }
        }
    }, document.createElement('div'));

    /*append the new grid to the div*/
    dojo.byId("gridDivx1").appendChild(gridx1.domNode);

    /*Call startup() to render the grid*/
    gridx1.startup();
	
    gridx1.currentPageSize(10);
    
	dojo.connect(grid.selection, 'onSelected', 
		function(rowIndex)
		{
			
			var col1val=grid.store.getValue(grid.getItem(rowIndex),"col2");
			globalticketid =grid.store.getValue(grid.getItem(rowIndex),"col2");
			var ticketsubject=grid.store.getValue(grid.getItem(rowIndex),"col2");
			ticketsubject = "[" + col1val + "] " + ticketsubject;
			//alert("U selected"+rowIndex+" "+col1);
			document.getElementById("txthiddenid").value = col1val;
			document.getElementById("displayemail").style.display="block";
			
			document.getElementById("gridDiv").style.display="none";
			document.getElementById("searchbox").style.display="none";
			document.getElementById("divrefresh").style.display="none";
			document.getElementById("divassign").style.display="block";
			document.getElementById("dropdownconfig").style.display="none";
			document.getElementById("dropdownconfig").style.display="none";
			document.getElementById("divinbox").style.display="block";
			document.getElementById("displayemailtxt").style.display="none";
			
			xmlhttp.onreadystatechange=function()
			  {
			  if (xmlhttp.readyState==4 && xmlhttp.status==200)
			    {
				  var resp = xmlhttp.responseText;
				  //alert(resp);
				  
				  if(xmlhttp.responseText=="false"){

				    	//alert("No such email");
				    	document.getElementById("displayemail").style.innerHTML="Email Deleted or Bad Request..";				    	
					    }else{ 
					    	var strvar="";
					    	var arrx = JSON.parse(resp);

							//alert("arrx: " + arrx);
							//alert(arr[0].to);
					    	//document.getElementById("divTo").style.innerHTML= arr[0].to;
					    	//alert("arrx subject : " + arrx.subject);
					    	var arr = arrx.emails;
 							
					    	strvar = strvar + '<h3>' + arrx.subject + '</h3></br>';
							
							///alert(arr[0].message);
					    	
					    	for(var x =0;x<arr.length;x++){
							var strfrom = (typeof(arr[x].from) == "undefined")?'':arr[x].from;
							var strto=(typeof(arr[x].to)=="undefined")?'':arr[x].to;
							var strcc=(typeof(arr[x].cc)=='undefined')?'':arr[x].cc;
							var strbcc = (typeof(arr[x].bcc)=='undefined')?'':arr[x].bcc;

							var comevtid =(typeof(arr[x].comevtid)=='undefined')?'':arr[x].comevtid;
							//alert(arr[0].attachment[0].filename);
							//alert(arr[0].attachment.length);
							//var arr2 =JSON.parse(arr[0].attachment);
							var strattach=''; 
							
							for(var i =0;i<arr[x].attachment.length;i++){
								if(arr[x].attachment[i].filename!='NO'){
									strattach=strattach + '<a href="mailEsaya.do?methodtocall=downloadAttachment&attachid=' +arr[x].attachment[i].attachid+'">'+arr[x].attachment[i].filename+'</a><br/>';
								}
							}
							strattach = strattach + '<br/><br/>';
					    	strvar = strvar + '<table border="0" width="100%" style="font-family:AftasansRegular;font-size:13px"><tr><td colspan="3" ></td></tr><tr><td width="20%"><b>To</b></td><td width="40%">' + strto + '</td><td align="right"><img src="images/mail-reply-all-3.png" width="30px" height="30px" onmouseover="Tip(\'Reply\')" onmouseout="UnTip()" onclick="mailforward(\'reply\',\''+ comevtid +'\')" /><img src="images/fast_forward.png" width="30px" height="30px" tooltipText="Forward"/><img src="images/email_delete.png" width="30px" height="30px"/></td></tr><tr><td width="20%"><b>From</b></td><td width="40%">' + strfrom +'</td><td></td></tr><tr><td width="20%"><b>Cc</b></td><td width="40%">' + strcc + '</td><td></td></tr><tr><td width="20%"><b>Bcc</b></td><td width="40%">'+ strbcc +'</td><td></td></tr><tr><td width="20%"></td><td></td><td align="right"><b>'+ arr[x].senddate +'</b></td></tr><tr><td colspan=3></div></td></tr><tr><td colspan=3> '+strattach+'</td></tr><tr><td colspan=3>'+arr[x].message+'</div></td></tr></table></br>';
					    	//alert(strvar); 
					    	}       
					        
					        $("#displayemail").html(strvar); 
					    	//document.getElementById("displayemail").style.innerHTML=strvar;	    	
					}
				    
			    }
			  }
			
			xmlhttp.open("GET","mailEsaya.do?methodtocall=getTicketEmailDetails&TicketId=" + col1val,true);
			xmlhttp.send();

			
			//document.getElementById("txtemployeecat").value = col1;
			//alert("hidden: "+document.getElementById("txthiddenid").value);
			
		})
		

									
});

function onclickinbox(){

	document.getElementById("displayemail").style.display="none";
	
	document.getElementById("gridDiv").style.display="block";
	document.getElementById("searchbox").style.display="block";
	document.getElementById("divrefresh").style.display="block"; 
	document.getElementById("divassign").style.display="none";
	document.getElementById("divinbox").style.display="none";
	document.getElementById("displayemailtxt").style.display="none";
	document.getElementById("dropdownconfig").style.display="none";
	attachid = new Array();
	attachname = new Array();
	isattachment=false;
}
//start add new row
function griddelete(){

	var items = dijit.byId("grid").selection.getSelected();
    if (items.length) {
    // Iterate through the list of selected items.
    // The current item is available in the variable
    // "selectedItem" within the following function:
        dojo.forEach(items, function(selectedItem) {
            if (selectedItem !== null) {
                // Delete the item from the data store:
                dijit.byId("grid").store.deleteItem(selectedItem);
                introw = introw - 1;
            } // end if
        }); // end forEach

        alert("inside delete: " + introw);
        dijit.byId("grid").store.save();
        dijit.byId("grid").render();
        } // end if
}

function gridadd(){
	
	var myNewItem = {
            id: introw,
            col2: document.getElementById("drpCommuncationtype").options[document.getElementById('drpCommuncationtype').selectedIndex].text,
            col3: document.getElementById("txtinfostr").value
            
        };
        // Insert the new item into the store:
        // (we use store3 from the example above in this example)
    dijit.byId("grid").store.newItem(myNewItem);
    dijit.byId("grid").store.save();
    dijit.byId("grid").render();
    alert("inside add: " + introw);
	introw = introw+1;
}
//end

function filtermit()
{
	var colname=document.getElementById('searchcolname').value;
	var text=document.getElementById('searchtext').value;
	text="*"+text+"*";
	if(colname==null || colname.length!=4)
	{
		alert("Please Select a Column Name");
		return false;
	}
	
	//dijit.byId("grid").setQuery({colname:text});
	
	if(document.getElementById('searchcolname').value == "col2"){
	
	dijit.byId("grid").setQuery({col2:text});
		
	}else if(document.getElementById('searchcolname').value == "col3"){
	
	dijit.byId("grid").setQuery({col3:text});
	
	}else if(document.getElementById('searchcolname').value == "col4"){
	
	dijit.byId("grid").setQuery({col4:text});
	
	}
	else if(document.getElementById('searchcolname').value == "col6"){
	
	dijit.byId("grid").setQuery({col6:text});
	
	}
	else if(document.getElementById('searchcolname').value == "col7"){
		
		dijit.byId("grid").setQuery({col7:text});
	
	}
	document.getElementById('searchtext').focus();
	//alert("Grid query"+colname+"text="+text);
}
function refresh(){

	var x = <%=new Random().nextLong()%>;
	location.reload(true);
}
//Upload file

 	   function fileSelected() {
            var file = document.getElementById('fileToUpload').files[0];
            if (file) {
                var fileSize = 0;
                if (file.size > 1024 * 1024)
                    fileSize = (Math.round(file.size * 100 / (1024 * 1024)) / 100).toString() + 'MB';
                else
                    fileSize = (Math.round(file.size * 100 / 1024) / 100).toString() + 'KB';

                //document.getElementById('fileName').innerHTML = 'Name: ' + file.name;
                //document.getElementById('fileSize').innerHTML = 'Size: ' + fileSize;
                //document.getElementById('fileType').innerHTML = 'Type: ' + file.type;
                uploadFile();
            }
        } 

        function uploadFile() {


        	xmlhttp.onreadystatechange=function()
        	{
        	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
        	  {
        		  responseText = xmlhttp.responseText;
				  alert("Response: " + responseText + " isattachment : " + isattachment ); 

					if(responseText!=""&&responseText!="false"){ 
					if(isattachment==true){
						
						attachname[attachname.length] = file.name;
						attachid[attachid.length] = responseText;
						//document.getElementById('fileToUpload').files[0] = "";		
						alert("isattachment==true" +" id length " + attachid.length + " filename length " + attachname.length);
					}else{

						attachid = new Array();
						attachname = new Array();
						isattachment=true;						 
						attachname[attachname.length] = file.name;
						attachid[attachid.length] = responseText;
						//document.getElementById('fileToUpload').files[0] = "";
						alert("isattachment==false" +" id length " + attachid.length + " filename length " + attachname.length);
					}
					var strattach='';
					for(var x =0;x<attachid.length;x++){
						if(attachid[x]!=""){
						strattach=strattach+ "<a href=mailEsaya.do?methodtocall=downloadAttachment&attachid=" + attachid[x]+">"+attachname[x]+"</a> <img src=images/DeleteRed.png onClick=deleteattachment('"+ attachid[x] +"') width=13 height=13> <br/>";
						
						alert("attachid: " + attachid[x] + "strattach: " + strattach);
						}
					}
					alert("after for loop");
					strattach = strattach + '<br/><br/>';
					document.getElementById("divattachment").innerHTML = strattach;
				 }			    
        	  }
        	}
        	var file = document.getElementById('fileToUpload').files[0];
            var fd = new FormData();
            fd.append("filetext", file.name);
            fd.append("fileToUpload", file);

            //xmlhttp.setRequestHeader("Content-Type", "application/octet-stream"); 

            
            //var xhr = new XMLHttpRequest();
           // xhr.upload.addEventListener("progress", uploadProgress, false);
            xmlhttp.addEventListener("load", uploadComplete, false);
            xmlhttp.addEventListener("error", uploadFailed, false);
            xmlhttp.addEventListener("abort", uploadCanceled, false);
            alert(file.type + ": " + file.name);
            xmlhttp.open("POST", "mailEsaya.do?methodtocall=uploadAttachmentAjax",false);
            //xmlhttp.setRequestHeader("Content-type", "multipart/form-data");  
			
	        //xmlhttp.setRequestHeader("X_FILE_NAME", file.name);  
                    
            xmlhttp.send(fd);
	         // xmlhttp.send(fi le); // Simple! 
        }
        function uploadComplete(evt) {
            /* This event is raised when the server send back a response */
            alert(evt.target.responseText);
        }

        function uploadFailed(evt) {
            alert("There was an error attempting to upload the file.");
        }

        function uploadCanceled(evt) {
            alert("The upload has been canceled by the user or the browser dropped the connection.");
        }
//End file upload


function sendmail(){

	xmlhttp.onreadystatechange=function()
	{
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	  {
		    //alert("call in popgrid : introw=" + introw);
			var resp = xmlhttp.responseText;

			if(resp=="true"){

				onclickinbox();
				}else{
			alert("Problem sending mail..");
			}
			
			//alert("resp: " + resp);		
	  }
	}
		
		//document.getElementById("displayemail").value = strto;
		//document.getElementById("txtcc").value = strcc;
		//document.getElementById("txtbcc").value=strbcc;
		//body
		//=arr[0].subject;	
		//document.getElementById("txtbody").value=arr[0].message;
		//dojo.byId('txtbody').value = arr[0].message;
		//dijit.byId('txtbody').set('value',arr[0].message);
		//alert("Calling");
		dojo.byId('txtbody').value = dijit.byId('txtbody').get('value');

		var sendattachid="";
		for(var x =0;x<attachid.length;x++){

			if(attachid[x]!= "undefined"&&attachid[x]!= ""){
			sendattachid = sendattachid + "," + attachid[x]; 
			//alert("attachid: " + attachid[x]);
			}
		}

		//alert("Attachid: " + sendattachid);

		alert("mailEsaya.do?methodtocall=sendEmailAttachment&emailconfigid=" + document.getElementById("drpemailconfig").value + "&to=" + document.getElementById("txtto").value + "&subject=" + document.getElementById("txtsubject").value + "&message=" + escape(dojo.byId('txtbody').value) + "&attachid=" + sendattachid);
		if(isattachment==true){
			alert("sendEmailAttachment");
		//xmlhttp.open("GET","mailEsaya.do?methodtocall=sendEmailFinal&emailconfigid=" + document.getElementById("drpemailconfig").value + "&to=" + document.getElementById("txtto").value + "&subject=" + document.getElementById("txtsubject").value + "&message=" + dojo.byId('txtbody').value,true);
		xmlhttp.open("GET","mailEsaya.do?methodtocall=sendEmailAttachment&emailconfigid=" + document.getElementById("drpemailconfig").value + "&to=" + document.getElementById("txtto").value + "&subject=" + document.getElementById("txtsubject").value + "&message=" + escape(dojo.byId('txtbody').value) + "&attachid=" + sendattachid,true);
		}else{
		//Send conventional mail
		alert("sendEmailFinal");
		xmlhttp.open("GET","mailEsaya.do?methodtocall=sendEmailFinal&emailconfigid=2&to=" + document.getElementById("txtto").value + "&subject=" + document.getElementById("txtsubject").value + "&message=" + dojo.byId('txtbody').value,true);
		}
		xmlhttp.send();
	
}


function updateTicketEmployeeId(){

	xmlhttp.onreadystatechange=function()
	{
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	  {
		    //alert("call in popgrid : introw=" + introw);
			var resp = xmlhttp.responseText;
			alert("resp: " + resp);		
		   	dialog.hide();
		    dojo.destroy(dialog);
					
			popGridXMLHTTPJson();
			
	  }
	}
		
	
		
		var employeeid = document.getElementById("drpemployee").value;
		//alert("update ticketemployeeid: " + employeeid);
		xmlhttp.open("GET","mailEsaya.do?methodtocall=updatePartyIdinTicketDetails&partyid="+employeeid + "&ticketid=" + globalticketid,true);
		xmlhttp.send();
	
}

function assignToMe(){

	xmlhttp.onreadystatechange=function()
	{
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	  {
		    //alert("call in popgrid : introw=" + introw);
			var resp = xmlhttp.responseText;
			//alert("resp: " + resp);	
			document.getElementById("posloading").style.display="block";
			popGridXMLHTTPJson();
		
					
	  }
	}
		

	<%String userid = (String) sessionx.getAttribute("user");%>
		
		//var employeeid = document.getElementById("drpemployee").value;
		//alert("update ticketemployeeid: " + employeeid);
		xmlhttp.open("GET","mailEsaya.do?methodtocall=updatePartyIdinTicketDetails&partyid=<%=userid%>&ticketid=" + globalticketid,true);
		xmlhttp.send();
	
	
}

function getEmployeedropdown(){

	xmlhttp.onreadystatechange=function()
	{
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	  {
		    //alert("call in popgrid : introw=" + introw);
			var resp = xmlhttp.responseText;
			alert("resp: " + resp);

			var arr = JSON.parse(resp);

		    //alert(arr[0].id);
		    //alert(arr[0].empcatname);
			var result='<select id="drpemployee">';
		   	for(var x=0;x<arr.length;x++){

			   			result = result + '<option value="'+ arr[x].id +'">'+ arr[x].fname + ' ' + arr[x].mname  + ' ' + arr[x].lname + '</option>';
			
		   	}
		   	result = result + '</select>';
			return result;
	  }
	}
		
	
		alert("get employee list");
		
		xmlhttp.open("GET","addPartyMaster.do?methodtocall=getEmployeelist",true);
		xmlhttp.send();
	
}


function sendmail2(){

	xmlhttp.onreadystatechange=function()
	{
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	  {
		    //alert("call in popgrid : introw=" + introw);
			var resp = xmlhttp.responseText;
			alert("resp: " + resp);		
	  }
	}
		
		//document.getElementById("displayemail").value = strto;
		//document.getElementById("txtcc").value = strcc;
		//document.getElementById("txtbcc").value=strbcc;
		//body
		//=arr[0].suject;	
		//document.getElementById("txtbody").value=arr[0].message;
		//dojo.byId('txtbody').value = arr[0].message;
		//dijit.byId('txtbody').set('value',arr[0].message);
		alert("Calling");
		dojo.byId('txtbody').value = dijit.byId('txtbody').get('value');
		
		xmlhttp.open("GET","mailEsaya.do?methodtocall=sendEmailFinal&emailconfigid=4&to=atulkulve@gmail.com&subject=Testing..&message=bodytesting..",true);
		xmlhttp.send();
	
}


function popGridXMLHTTPJson()
{
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		    //alert("call in popgrid : introw=" + introw);
			var resp = xmlhttp.responseText;
			/*
			if(resp="false"){
				alert("Some problem on server try to refresh the page.." + resp);
				document.getElementById("posloading").style.display="none";
				return false;
			}*/		
			onclickinbox();
		  	clearMyGrid();

		   			    
			//alert("after clear grid introw=" + introw);
		  	//alert("getemailresp:" +resp );
		    //clearMyGrid();
		    dijit.byId("grid").store.save();
		    dijit.byId("grid").render();
		    dijit.byId("grid").startup();
		    var arr = JSON.parse(resp);
			
		    //alert(arr[0].id);
		    //alert(arr[0].empcatname);
		    introw=0;
		   	for(var x=0;x<arr.length;x++){
		   		//alert("in above 0: " + introw + " rowcount: " + dijit.byId("grid").rowCount + " arr:" + arr[x].empcatname);			   	
		   		var myNewItem = {
			            id: introw,
			            col2: arr[x].ticketid,
			            col3: arr[x].subject,
			            col4: arr[x].from,
			            col5: arr[x].date,
			            col6: arr[x].status,
			            col7: arr[x].priority
			        };
			        // Insert the new item into the store:
			        // (we use store3 from the example above in this example)
			    dijit.byId("grid").store.newItem(myNewItem);
			    dijit.byId("grid").store.save();
			    dijit.byId("grid").render();
			    introw = introw+1;
			   	}
		   	//alert("call in popgrid before sorting");
		   	window.setTimeout( sortingauto, 2000 );

			
		   	
		   	document.getElementById("posloading").style.display="none";

		   	onclickinbox();			
		   	//getItems();
		   	//dijit.byId("grid").store.close();
		   	//dijit.byId("grid").store.fetch();
		   	//dijit.byId("grid").store._refresh();
		   	//dijit.byId("grid").setQuery({col3:"*"});
		   	//alert("introw" + introw);
		    //clearMyGrid();
		    /*if(introw==0){
		    	dijit.byId("grid").startup();
			    alert("in 0: " + introw);
		    var myNewItem = {
		            id: introw,
		            col2: arr[0].empcatname
		            
		        };
		        // Insert the new item into the store:
		        // (we use store3 from the example above in this example)
		    dijit.byId("grid").store.newItem(myNewItem);
		    dijit.byId("grid").store.save();
		    dijit.byId("grid").render();
		    //dijit.byId("grid").store.add({id:2,col2:arr1[1].empcatname});
		    //dijit.byId("grid").store.newItem({id : arr[0].id, col2 : arr[0].empcatname})
		    introw = introw + 1;
		    }else{
		    	alert("in above 0: " + introw + " rowcount: " + dijit.byId("grid").rowCount + " arr:" + arr[0].empcatname);
		    	var myNewItem2 = {
		    			id: introw,
			            col2: arr[1].empcatname
			            
			        };
			        // Insert the new item into the store:
			        // (we use store3 from the example above in this example)
			   
			    var store2=dijit.byId("grid").store;
			    store2.newItem(myNewItem2);
				store2.save();
			    dijit.byId("grid").render();
			    //dijit.byId("grid").store.newItem({id : arr[0].id, col2 : arr[0].empcatname})
			    
			    alert("after add");
			    introw = introw + 1;
			    }
		    */	   
	    }
	  }

	onclickinbox();


	//alert("call in popgrid before call");
	document.getElementById("posloading").style.display="block";
	xmlhttp.open("GET","mailEsaya.do?methodtocall=getTickets",true);
	xmlhttp.send();
	//alert("call in popgrid after call");
	//alert("after send pop");

}
//popGridXMLHTTPJson();
function clearMyGrid()
{
	//Clear grid code working
/*var emptyCells = { items: "" };
var emptyStore = new dojo.data.ItemFileWriteStore({data: emptyCells});
dijit.byId("grid").setStore(emptyStore);
*/
	
	var x = introw;
	for(var i=0;i<x;i++){
		//alert('inside loop' + i + ' rows:' + dijit.byId("grid").rowCount + ' introw:' + introw);
		//var selectedItem = dijit.byId("grid").selection.setSelected(i);
		//dijit.byId("grid").selection.setSelected(i);
		dijit.byId("grid").rowSelectCell.toggleRow(0, true)
		//dijit.byId("grid").store.deleteItem(selectedItem);

		//new
		recipeIngredientItem = dijit.byId("grid").getItem(0);
		//alert('before');
		//dijit.byId("grid").deleteItem(recipeIngredientItem);
		dijit.byId("grid").store.deleteItem(recipeIngredientItem);
		//alert('after deleting');
		dijit.byId("grid").store.save();
		dijit.byId("grid").render();				
		}
	introw = 0;	
}
function cleardata(){

	//alert("hi");
	//$('#divAddBtn').trigger('onClick');
//	$('#divAddBtn').trigger('click');
	var x = dijit.byId("grid").rowCount;
	for(var i=0;i<=x;i++){
		alert('inside loop' + i + ' rows:' + dijit.byId("grid").rowCount);
		//var selectedItem = dijit.byId("grid").selection.setSelected(i);
		//dijit.byId("grid").selection.setSelected(i);
		dijit.byId("grid").rowSelectCell.toggleRow(0, true)
		//dijit.byId("grid").store.deleteItem(selectedItem);

		//new
		recipeIngredientItem = dijit.byId("grid").getItem(0);
		alert('before');
		//dijit.byId("grid").deleteItem(recipeIngredientItem);
		dijit.byId("grid").store.deleteItem(recipeIngredientItem);
		alert('after deleting');
		dijit.byId("grid").render();				
		}

		
		//new end
	
	/*var items = dijit.byId("grid").selection.getSelected();

	
	
	alert("before items");
    if (items.length) {
    // Iterate through the list of selected items.
    // The current item is available in the variable
    // "selectedItem" within the following function:
    alert("inside items");
    //dijit.byId("grid").store.deleteItem(items);
    dojo.forEach(items, function(selectedItem) {
            if (selectedItem !== null) {
                // Delete the item from the data store:
                alert("before delete");
                dijit.byId("grid").store.deleteItem(selectedItem);
            } // end if
        }); // end forEach
    } // end if
*/
	//ADD new item working
	alert(dijit.byId("grid").rowCount);
	var myNewItem = {
            id: dijit.byId("grid").rowCount+1,
            col2: "country",
            
        };
        // Insert the new item into the store:
        // (we use store3 from the example above in this example)
    dijit.byId("grid").store.newItem(myNewItem);
	//Add new item end working code
	//document.getElementbyId("")
	alert("end");
    document.getElementById("txthiddenid").value = "";
	document.getElementById("txtdepartment").value = "";
	
}

</script>


<script language="javascript">
var xmlhttp=null; 
function loaddoc(){
	//alert("in load data");
	if (window.XMLHttpRequest)
	  {// code for IE7+, Firefox, Chrome, Opera, Safari
	  xmlhttp=new XMLHttpRequest();
	  }
	else
	  {// code for IE6, IE5
	  xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	  }
	
	//alert("loading..");
	//popGridXMLHTTPJson();
			
	window.setTimeout( poppartytype, 500 );
	
	window.setTimeout( popempcat, 1000 );
	window.setTimeout( popdepartment, 1500 );
	window.setTimeout( popcommunicationtype, 2000 );
	window.setTimeout( emailconfig, 2250 );
	window.setTimeout( mainquery, 2500 );
	
}
//alert("beforeload");
loaddoc();

//alert("after load");

//alert("after pop");
function sortingauto(){
	
	var text="P";
   	text="*"+text+"*";
	//alert("Before query");
   	dijit.byId("grid").setQuery({col2:text});
	text="";
   	text="*"+text+"*";
   	dijit.byId("grid").setQuery({col2:text});
	//alert("after pop grid");	
}

function savedata(){
	//alert("in save data");

	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		    if(xmlhttp.responseText=="true"){
		    	alert("Data Saved Successfully");
			
		    clearMyGrid();
			window.setTimeout( sortingauto, 2000 );

			document.getElementById('txtfname').value = ""; 
			document.getElementById('txtmname').value = ""; 
			document.getElementById('txtlname').value = ""; 
			document.getElementById('txtusername').value = ""; 
			document.getElementById('txtpassword').value = "";
			document.getElementById('drpCity').value = "";
			document.getElementById('txtaddress').value = ""; 
			document.getElementById('txtpincode').value = ""; 
			document.getElementById('drppartytype').value = ""; 
			document.getElementById('drpdepartment').value = ""; 
			document.getElementById('drpempcat').value = ""; 
			document.getElementById('txtemailfooter').value = "";

			isEdit=false;
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
	 // alert("hidden: " + document.getElementById("txthiddenid").value + ", edit: " + isEdit);
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
	}else{*/
		//alert("inside new");
		//alert("inside " + document.getElementById("txthiddenid").value);
		var url = "addPartyMaster.do?methodtocall=add&txtfname=" + document.getElementById('txtfname').value + "&txtmname=" + document.getElementById('txtmname').value + "&txtlname="  + document.getElementById('txtlname').value + "&txtusername=" + document.getElementById('txtusername').value + "&txtpassword=" + document.getElementById('txtpassword').value + "&drpCity=" + document.getElementById('drpCity').value + "&txtaddress=" + document.getElementById('txtaddress').value + "&txtpincode=" + document.getElementById('txtpincode').value + "&drppartytype=" + document.getElementById('drppartytype').value + "&drpdepartment=" + document.getElementById('drpdepartment').value + "&drpempcat=" + document.getElementById('drpempcat').value + "&txtemailfooter=" + document.getElementById('txtemailfooter').value;
		//var url="";
		xmlhttp.open("GET",url,true);
	
		xmlhttp.send();
	//	}
	//alert(xmlhttp.responseText); 	
}
function editdata(){

	//alert("in edit");
	if(document.getElementById("txthiddenid").value!=""){
		//alert("hiddenid: " + document.getElementById("txthiddenid").value);
		//alert("empcat: " + document.getElementById("txtemployeecat").value);


		xmlhttp.onreadystatechange=function()
		  {
		  if (xmlhttp.readyState==4 && xmlhttp.status==200)
		    {
			    if(xmlhttp.responseText=="false"){

			    	alert("No Such Category Exists");
			    	
				    }else{
				    	isEdit=true;
				    	//alert(isEdit);
				    	document.getElementById("txtdepartment").value = xmlhttp.responseText; 				    	
					    }
			    
		    }
		  }
		
		xmlhttp.open("GET","addDepartmentsMaster.do?methodtocall=getDepartmentName&txtdepartmentid=" + document.getElementById("txthiddenid").value,true);
		xmlhttp.send();
		
	document.getElementById("txtdepartment").value=document.getElementById("txthiddenid").value;
	}else{
        alert("Please select category");
		}
}
function cancel(){
	document.getElementById("txtdepartment").value="";
	document.getElementById("txthiddenid").value="";
	isEdit=false;
	popGridXMLHTTPJson();
}
function popstate(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		    var arr = JSON.parse(resp);
		    $('#drpState').empty()
		   	$('#drpState').append('<option value="0">--Select--</option>');
		   	for(var x=0;x<arr.length;x++){
		   	
				$('#drpState').append('<option value="' + arr[x].id + '">' + arr[x].state + '</option>');
		   	}
	     }
	  }
	xmlhttp.open("GET","addPartyMaster.do?methodtocall=getstate",true);
	xmlhttp.send();

}
function popcity(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		    var arr = JSON.parse(resp);
		    $('#drpCity').empty()
		   	$('#drpCity').append('<option value="0">--Select--</option>');
		   //	alert("city length: " + arr.length);
		   	for(var x=0;x<arr.length;x++){
		   	
				$('#drpCity').append('<option value="' + arr[x].id + '">' + arr[x].city + '</option>');
		   	}
		  // 	poppartytype();
	     }
	  }
//	  alert(document.getElementById("drpState").value);
	xmlhttp.open("GET","addPartyMaster.do?methodtocall=getcity&stateid=" + document.getElementById("drpState").value,true);
	xmlhttp.send();

}
function poppartytype(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		    var arr = JSON.parse(resp);
		    $('#drppartytype').empty();
		   	$('#drppartytype').append('<option value="0">--Select--</option>');
		 //  	alert("city length: " + arr.length);
		   	for(var x=0;x<arr.length;x++){
		   	
				$('#drppartytype').append('<option value="' + arr[x].id + '">' + arr[x].partytype + '</option>');
		   	}
	     }
	  }
	//alert("atul");
	
	xmlhttp.open("GET","addPartyMaster.do?methodtocall=getPartyType",true);
	xmlhttp.send();

}

function popdepartment(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		    var arr = JSON.parse(resp);
		    $('#drpdepartment').empty();
		   	$('#drpdepartment').append('<option value="0">--Select--</option>');
		   //	alert("city length: " + arr.length);
		   	for(var x=0;x<arr.length;x++){
		   	
				$('#drpdepartment').append('<option value="' + arr[x].id + '">' + arr[x].department + '</option>');
		   	}
	     }
	  }
	//alert("atul");
	
	xmlhttp.open("GET","addPartyMaster.do?methodtocall=getDepartment",true);
	xmlhttp.send();

}
function popempcat(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		    var arr = JSON.parse(resp);
		    $('#drpempcat').empty();
		   	$('#drpempcat').append('<option value="0">--Select--</option>');
		   //	alert("city length: " + arr.length);
		   	for(var x=0;x<arr.length;x++){
		   	
				$('#drpempcat').append('<option value="' + arr[x].id + '">' + arr[x].empcatname + '</option>');
		   	}
	     }
	  }
	//alert("atul");
	
	xmlhttp.open("GET","addemployeecategory.do?methodtocall=getEmpCatAll",true);
	xmlhttp.send();

}

function popcommunicationtype(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		    var arr = JSON.parse(resp);
		    $('#drpCommuncationtype').empty();
		   	$('#drpCommuncationtype').append('<option value="0">--Select--</option>');
		   //	alert("city length: " + arr.length);
		   	for(var x=0;x<arr.length;x++){
		   	 
				$('#drpCommuncationtype').append('<option value="' + arr[x].id + '">' + arr[x].comptype + '</option>');
		   	}
	     }
	  }
	//alert("atul");
	
	xmlhttp.open("GET","addPartyMaster.do?methodtocall=getCommuncationType",true);
	xmlhttp.send();

}

function ping(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

					    
		    
	     }
	  }
	//alert("atul");
	
	xmlhttp.open("GET","mailEsaya.do?methodtocall=receivemail2",true);
	xmlhttp.send();
		
}

function mailforward(params,colid){

	//alert('mailforward');
	//document.getElementById("txthiddenid").value = col1val;
	document.getElementById("displayemail").style.display="none";
	document.getElementById("displayemailtxt").style.display="block";
	
	document.getElementById("gridDiv").style.display="none";
	document.getElementById("searchbox").style.display="none";
	document.getElementById("divrefresh").style.display="none";
	document.getElementById("divinbox").style.display="block";
	document.getElementById("dropdownconfig").style.display="none";

	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
		  var resp = xmlhttp.responseText;
		  //alert(resp);
		  
		  if(xmlhttp.responseText=="false"){

			    	//alert("No such email");
		    		document.getElementById("displayemail").style.innerHTML="Email Deleted or Bad Request..";				    	
		    }else{ 
			    	var arr = JSON.parse(resp);
					//alert(arr[0].to);
			    	//document.getElementById("divTo").style.innerHTML= arr[0].to;
					var strfrom = (typeof(arr[0].from) == "undefined")?'':arr[0].from;
					var strto=(typeof(arr[0].to)=="undefined")?'':arr[0].to;
					var strcc=(typeof(arr[0].cc)=='undefined')?'':arr[0].cc;
					var strbcc = (typeof(arr[0].bcc)=='undefined')?'':arr[0].bcc;

					isattachment = false;
					attachid = new Array();
					attachname = new Array();
			    	//var strvar =  '<table border="0" width="100%" style="font-family:AftasansRegular;font-size:13px"><tr><td colspan="3" ><font size="4px"><b>' + arr[0].subject +'</b></font></td></tr><tr><td width="20%"><b>To</b></td><td width="40%">' + strto + '</td><td align="right"><img src="images/mail-reply-all-3.png" width="30px" height="30px" onclick="mailforward(\'reply\',\''+ col1val +'\')" /><img src="images/fast_forward.png" width="30px" height="30px"/><img src="images/email_delete.png" width="30px" height="30px"/></td></tr><tr><td width="20%"><b>From</b></td><td width="40%">' + strfrom +'</td><td></td></tr><tr><td width="20%"><b>Cc</b></td><td width="40%">' + strcc + '</td><td></td></tr><tr><td width="20%"><b>Bcc</b></td><td width="40%">'+ strbcc +'</td><td></td></tr><tr><td width="20%"></td><td></td><td align="right"><b>'+ arr[0].senddate +'</b></td></tr><tr><td colspan=3></div></td></tr><tr><td colspan=3>'+arr[0].message+'</div></td></tr></table>';
			    	//alert(strvar);   	
			        //$("#displayemail").html(strvar);
 			    	//document.getElementById("displayemail").style.innerHTML=strvar;

					var strattach=''; 
					objattach = arr[0].attachment;
					for(var i =0;i<arr[0].attachment.length;i++){
						if(arr[0].attachment[i].filename!='NO'){
							strattach=strattach+ "<a href=mailEsaya.do?methodtocall=downloadAttachment&attachid=" +arr[0].attachment[i].attachid+">"+arr[0].attachment[i].filename+"</a> <img src=images/DeleteRed.png onClick=deleteattachment('"+ arr[0].attachment[i].attachid +"') width=13 height=13> <br/>";
							
							attachid[i] = arr[0].attachment[i].attachid;
							attachname[i] = arr[0].attachment[i].filename;
							isattachment =true;
						}
					}
					strattach = strattach + '<br/><br/>';

					document.getElementById("divattachment").innerHTML = strattach;

					for(var x =0;x<attachid.length;x++){
							
							alert("attachid: " + attachid[x]);
 							
					}					
			    	
			    	if(arr[0].emailtype=='IN_EMAIL'){
			    		document.getElementById("txtto").value = strfrom;
			    	}else{
			    		document.getElementById("txtto").value = strto;
				    	}
					//document.getElementById("displayemail").value = strto;
					document.getElementById("txtcc").value = strcc;
					document.getElementById("txtbcc").value=strbcc;
					//body
					document.getElementById("txtsubject").value=  arr[0].subject;	
					//document.getElementById("txtbody").value=arr[0].message;
					dojo.byId('txtbody').value = arr[0].message;
					dijit.byId('txtbody').set('value',arr[0].message);					    	
			}
		    
	    }
	  }
	
	xmlhttp.open("GET","mailEsaya.do?methodtocall=getEmailDetailsAndTicketId&ComEvtId=" + colid,true);
	xmlhttp.send();


		
}

function deleteattachment(paramattachid ){

	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

			alert("resp: " + resp + "paramattachid: " + paramattachid);
			
			if(resp=='true'){


				for(var x =0;x<attachid.length;x++){

					if(paramattachid==attachid[x]){
						alert("paramattach : " + x + "attachname[x] : " + attachname[x]);
						attachid[x] ="";
						attachname[x] = "";
						
					}
						
				} 
				isattachment =false;
				var strattach=''; 
				var strattach='';
				for(var x =0;x<attachid.length;x++){

					if(attachid[x]!=""){
						strattach=strattach+ "<a href=mailEsaya.do?methodtocall=downloadAttachment&attachid=" + attachid[x]+">"+attachname[x]+"</a> <img src=images/DeleteRed.png onClick=deleteattachment('"+ attachid[x] +"') width=13 height=13> <br/>";
					
						alert("attachid: " + attachid[x]);
						isattachment =true;
			 		}
				}
				strattach = strattach + '<br/><br/>';
				document.getElementById("divattachment").innerHTML = strattach;
			

			}
	    }
	  }
	//alert("delte attachment");
	xmlhttp.open("GET","mailEsaya.do?methodtocall=deleteAttachment&attachid=" +paramattachid,true);
	//xmlhttp.open("GET","addPartyMaster.do?methodtocall=getDepartment",true);
	xmlhttp.send(); 
	
}
function emailconfig(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;
			//alert("response: " + resp);
		    var arr = JSON.parse(resp);
		    $('#drpemailconfig').empty();
		   	$('#drpemailconfig').append('<option value="0">--Select--</option>');
		 //  	alert("city length: " + arr.length);
		   	for(var x=0;x<arr.length;x++){
		   	
				$('#drpemailconfig').append('<option value="' + arr[x].id + '">' + arr[x].name + '</option>');
		   	}
	     }
	  }
	//alert("atul");
	
	xmlhttp.open("GET","mailEsaya.do?methodtocall=getEmailconfigAll",true);
	//xmlhttp.open("GET","addPartyMaster.do?methodtocall=getDepartment",true);
	xmlhttp.send();
	//alert("after call");

}

/*function readjj(){

		xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		    //var arr = JSON.parse(resp);
		    alert(resp);
	     }
	  }
	alert("atul");

	var key = ["color", "size", "fabric"];
	var value = ["Black", "XL", "Cotton"];

	var json23 = "[{ ";
	for(var i = 0; i < key.length; i++) {
	    (i + 1) == key.length ? json23 += "\"" + key[i] + "\" : \"" + value[i] + "\"" : json23 += "\"" + key[i] + "\" : \"" + 

	value[i] + "\",";
	}
	json23 += " }]";
	var obj = JSON.parse(json23);
	console.log(obj);
		
	xmlhttp.open("GET","addPartyMaster.do?methodtocall=demoreadjson&readjson=" + json23,true);
	xmlhttp.send();


}*/

function mainquery(){
	
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;
			//alert("response: " + resp);
		    var arr = JSON.parse(resp);
		    $('#drpmainquery').empty();
		   	$('#drpmainquery').append('<option value="0">--Select--</option>');
		 //  	alert("city length: " + arr.length);
		   	for(var x=0;x<arr.length;x++){
		   	
				$('#drpmainquery').append('<option value="' + arr[x].id + '">' + arr[x].mainquery + '</option>');
		   	} 
	     }
	  }
	//alert("atul");
	
	xmlhttp.open("GET","addSubqueryMaster.do?methodtocall=getMainqueryAll",true);
	//xmlhttp.open("GET","addPartyMaster.do?methodtocall=getDepartment",true);
	xmlhttp.send();
	//alert("after call");

}
function popsubquery(){
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;
			//alert("response: " + resp);
		    var arr = JSON.parse(resp);
		    $('#drpsubquery').empty();
		   	$('#drpsubquery').append('<option value="0">--Select--</option>');
		 //  	alert("city length: " + arr.length);
		   	for(var x=0;x<arr.length;x++){
		   	
				$('#drpsubquery').append('<option value="' + arr[x].id + '">' + arr[x].subquery + '</option>');
		   	} 
	     }
	  }
	//alert("atul");
	 
	xmlhttp.open("GET","addSubqueryMaster.do?methodtocall=getSubqueryfromMainqueryId&mainqueryid=" + document.getElementById("drpmainquery").value,true);
	//xmlhttp.open("GET","addPartyMaster.do?methodtocall=getDepartment",true);
	xmlhttp.send();
	
}
function popsubquerydetails(){
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;
			//alert("response: " + resp);
		    var arr = JSON.parse(resp);

			var bodyval = dojo.byId('txtbody').value;
		    dojo.byId('txtbody').value = arr[0].description +  "<br/>----------<br/>" +bodyval;
			dijit.byId('txtbody').set('value',arr[0].description +  "<br/>----------<br/>" +bodyval);	
			
		    //$('#drpsubquery').empty();
		   	//$('#drpsubquery').append('<option value="0">--Select--</option>');
		 //  	alert("city length: " + arr.length);
		   	 
	     }
	  }
	
	xmlhttp.open("GET","addSubqueryMaster.do?methodtocall=getSubqueryDetails&subqueryid=" + document.getElementById("drpsubquery").value,true);
	//xmlhttp.open("GET","addPartyMaster.do?methodtocall=getDepartment",true);
	xmlhttp.send();
	
}


</script>

<body class="soria" onload="openOffersDialog();">

<input type="hidden" id="txthiddenid" name="txthiddenid"/>
<input type="hidden" id="txthiddenname" name="txthiddenid"/>


<div id="Accordion1" class="Accordion" tabindex="0">
		  <div class="AccordionPanel">
		    <div class="AccordionPanelTab"><img src="images/email.png" width="20" height="20"/> Dashboard </div>
		    <div class="AccordionPanelContent"> 
		    
		    <p>
		    <div id="divrefresh" style="display:block;margin-top: 5px;float: left;">
		    <img src="images/refresh.png" width="40px" height="40px"  onmouseover="Tip('Refresh')" onmouseout="UnTip()" /></div>
		    
		     
		    <div id="divassign" style="display:none;margin-top: 5px;margin-left: 350px;float: center;">
		    	
		    	<input name="btnassign" onmouseover="Tip('Assign to an Employee')" onmouseout="UnTip()" onclick="showDialog();" type="button" value="Assign" style="background-color:#000; color:#FFF;border-color: #000;border-bottom-color: #000;border-left-color: #000;border-right-color: #000;border-top-color: #000; height: 23px;width: 55px"/>
		    	<input name="btnassignyourself" onmouseover="Tip('Assign to yourself')" onmouseout="UnTip()" onclick="assignToMe();" type="button" value="Get Mail" style="background-color:#000; color:#FFF;border-color: #000;border-bottom-color: #000;border-left-color: #000;border-right-color: #000;border-top-color: #000; height: 23px;width: 70px"/>
		    	
		    </div>
		    <div id="dropdownconfig"  style="display:none;margin-top: 20px;float: center;margin-left: 370px;font-family:AftasansRegular;">
		   	Mail box : 
		    	<select id="drpemailconfig"  onchange="popGridXMLHTTPJson();" onmouseover="Tip('Select Mailbox here')" onmouseout="UnTip()"></select>
		    </div>
		    
		    
		    <div id="divinbox" style="display:none;" >
		    <img src="images/inbox.png" width="50px" height="50px" onclick="onclickinbox();" onmouseover="Tip('Inbox')" onmouseout="UnTip()"/></div>
		    <div style="clear:both"></div>
		    	<div id="gridDiv" style="z-index:-1;"></div>
		    <div id="displayemail" style="display:none;"></div> 
			
			<div id="posloading" style="position:absolute;z-index:0;display:none;margin-top: -348px;margin-left: 370px;font-family:AftasansRegular;">
		    <img src="images/loading3.gif" onmouseover="Tip('Please wait its Loading....')" onmouseout="UnTip()"/>
		    </div>
		    
			
		    <div id="gridDivx1" style="display:none;z-index:-1;"></div>
	
	<div id="searchbox" style="width: 100%">
		    <table align="center">
		<tr>
			<td>Column Names</td>
			<td>
				<select id="searchcolname" name="searchcolname" onChange="document.getElementById('searchtext').focus();">
	            
	            	<option value=" " selected="selected" >Select Column Name</option>
					  <option value="col2">Ticket ID</option>
					  <option value="col3">Subject</option>
					  <option value="col4">From</option>
					  <option value="col5">Date</option>
					  <option value="col6">Status</option>
					  <option value="col7">Priority</option>
					<!--<option value="col3">Subject</option>
					 <option value="col4">Status</option>
					 <option value="col6">EmailID</option>
					 -->
					  
				</select>
			</td>
		</tr>
		<tr>
		 	<td>Search text</td>
			<td>
				<input type="text" id="searchtext" name="searchtext" value="" onkeyup="filtermit();"/>
			</td>	
		 	
		</tr>
	</table>	
	</div>
	
		    </p>
		    <p>
		    
	<div id="fileName">
    </div>
    <div id="fileSize">
    </div>
    <div id="fileType">
    </div>
		<input name="btntry" onclick="sendmail2();" type="button" value="ping" style="background-color:#000; color:#FFF;border-color: #000;border-bottom-color: #000;border-left-color: #000;border-right-color: #000;border-top-color: #000; height: 23px;width: 45px;;display: none;" align="right"/>		    	
		 
		 <div id="displayemailtxt" style="display:none;">
			<table width="100%"><tr>
			<td width="30%"><font size="3px" face="AftasansRegular"><b>To:</b></font></td><td width="70%"> <input type="text" id="txtto" name="txtto" width="100%" size="50"/></td></tr> 
			<tr><td width="30%"><font size="3px" face="AftasansRegular"><b>Cc:</b></font></td> <td width="70%"><input type="text" id="txtcc" name="txtcc"  width="100%" size="50"/></td></tr>
			<tr><td width="30%"><font size="3px" face="AftasansRegular"><b>Bcc:</b></font></td> <td width="70%"><input type="text" id="txtbcc" name="txtbcc" width="100%" size="50"/></td></tr>
			<tr><td width="30%"><font size="3px" face="AftasansRegular"><b>Subject:</b></font></td><td width="70%"> <input type="text" id="txtsubject" name="txtsubject" size="50" /></td></tr>
			</table>
			<div style="clear:both"></div>
			<div id="divattachment"></div>
			<div style="clear:both"></div>
			<input type="file" id="fileToUpload" name="fileToUpload[]" onchange="fileSelected();" />
			 
			 <div style="clear:both"></div>
			 Main Query <select id="drpmainquery" onchange="popsubquery();"></select>
			 Sub Query <select id="drpsubquery" onchange="popsubquerydetails();"></select>
			<script src="js/wz_tooltip.js"></script>
		    <textarea id="txtbody"  name="txtbody" dojoType="dijit.Editor"> 
			 
			</textarea><br/>
			<img src="images/send.png" width="70px" height="40px" align="left" alt="Send" onclick="sendmail();"/>
			<img src="images/TRASH.png" width="70px" height="40px" align="right" alt="Discard"/>
		    
		</div> 
		    </p>
           </div>
	    </div>
        <!---------------------*******************-------------------------------->

          <!---------------------*******************-------------------------------->
	  </div>



</body>