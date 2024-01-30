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
<script>
window.location.assign("<%=masters %>");
</script>
<%} %>
<script>
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


<%JSONArray returnvalue2 =FormUtil.getInEmail();%>
<%if(returnvalue2!=null){%>
var introw=<%=returnvalue2.length()%>;
<%}else{%>

var introw = 0;

<%}%>

var isEdit=false;

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
		{ id: '<%=x%>', col2: '<%=objjson.get("subject")%>',col3:'<%=objjson.get("from")%>',col4:'<%=objjson.get("date")%>',col5:'<%=objjson.get("id")%>',col6:'false'}
 		<%if(!(returnvalue2.length()-1==x)){%>
		,
				<%}%>
 
				
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
      {name: 'Subject', field: 'col2' ,width: "300px"},
      {name: 'From', field: 'col3' ,width: "200px"},
      {name: 'Date', field: 'col4' ,width: "200px"},
      {name: 'ComevtId', field: 'col5' ,width: "200px",hidden:true}      
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
	 	sortFields: [{attribute: 'col4', descending: true}],
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
			
			var col1val=grid.store.getValue(grid.getItem(rowIndex),"col5");
			//alert("U selected"+rowIndex+" "+col1);
			document.getElementById("txthiddenid").value = col1val;
			document.getElementById("displayemail").style.display="block";
			
			document.getElementById("gridDiv").style.display="none";
			document.getElementById("searchbox").style.display="none";
			document.getElementById("divrefresh").style.display="none";
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
					    	var arr = JSON.parse(resp);
							//alert(arr[0].to);
					    	//document.getElementById("divTo").style.innerHTML= arr[0].to;
							var strfrom = (typeof(arr[0].from) == "undefined")?'':arr[0].from;
							var strto=(typeof(arr[0].to)=="undefined")?'':arr[0].to;
							var strcc=(typeof(arr[0].cc)=='undefined')?'':arr[0].cc;
							var strbcc = (typeof(arr[0].bcc)=='undefined')?'':arr[0].bcc;
							//alert(arr[0].attachment[0].filename);
							//alert(arr[0].attachment.length);
							//var arr2 =JSON.parse(arr[0].attachment);
							var strattach=''; 
							for(var i =0;i<arr[0].attachment.length;i++){
								if(arr[0].attachment[i].filename!='NO'){
									strattach=strattach+ '<a href="mailEsaya.do?methodtocall=downloadAttachment&attachid=' +arr[0].attachment[i].attachid+'">'+arr[0].attachment[i].filename+'</a><br/>';
								}
							}
							strattach = strattach + '<br/><br/>';
					    	var strvar =  '<table border="0" width="100%" style="font-family:AftasansRegular;font-size:13px"><tr><td colspan="3" ><font size="4px"><b>' + arr[0].subject +'</b></font></td></tr><tr><td width="20%"><b>To</b></td><td width="40%">' + strto + '</td><td align="right"><img src="images/mail-reply-all-3.png" width="30px" height="30px" onmouseover="Tip(\'Reply\')" onmouseout="UnTip()" onclick="mailforward(\'reply\',\''+ col1val +'\')" /><img src="images/fast_forward.png" width="30px" height="30px" tooltipText="Forward"/><img src="images/email_delete.png" width="30px" height="30px"/></td></tr><tr><td width="20%"><b>From</b></td><td width="40%">' + strfrom +'</td><td></td></tr><tr><td width="20%"><b>Cc</b></td><td width="40%">' + strcc + '</td><td></td></tr><tr><td width="20%"><b>Bcc</b></td><td width="40%">'+ strbcc +'</td><td></td></tr><tr><td width="20%"></td><td></td><td align="right"><b>'+ arr[0].senddate +'</b></td></tr><tr><td colspan=3></div></td></tr><tr><td colspan=3> '+strattach+'</td></tr><tr><td colspan=3>'+arr[0].message+'</div></td></tr></table>';
					    	//alert(strvar); 
					        $("#displayemail").html(strvar); 
					    	//document.getElementById("displayemail").style.innerHTML=strvar;	    	
					}
				    
			    }
			  }
			
			xmlhttp.open("GET","mailEsaya.do?methodtocall=getEmailDetails&ComEvtId=" + col1val,true);
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
	document.getElementById("divinbox").style.display="none";
	document.getElementById("displayemailtxt").style.display="none";
	document.getElementById("dropdownconfig").style.display="block";
	
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

                document.getElementById('fileName').innerHTML = 'Name: ' + file.name;
                document.getElementById('fileSize').innerHTML = 'Size: ' + fileSize;
                document.getElementById('fileType').innerHTML = 'Type: ' + file.type;
                uploadFile();
            }
        } 

        function uploadFile() {


        	xmlhttp.onreadystatechange=function()
        	{
        	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
        	  {
					alert("Response: " + xmlhttp.responseText);
        	  }
        	}
        	var file = document.getElementById('fileToUpload').files[0];
            var fd = new FormData();
            fd.append("filetext", file.name);
            fd.append("fileToUpload", file);

            //xmlhttp.setRequestHeader("Content-Type", "application/octet-stream"); 

            
            //var xhr = new XMLHttpRequest();
           // xhr.upload.addEventListener("progress", uploadProgress, false);
            //xmlhttp.addEventListener("load", uploadComplete, false);
            //xmlhttp.addEventListener("error", uploadFailed, false);
            //xmlhttp.addEventListener("abort", uploadCanceled, false);
            alert(file.type + ": " + file.name);
            xmlhttp.open("POST", "mailEsaya.do?methodtocall=uploadAttachment2",false);
            //xmlhttp.setRequestHeader("Content-type", "multipart/form-data");  
			
	        //xmlhttp.setRequestHeader("X_FILE_NAME", file.name);  
                    
            xmlhttp.send(fd);
	         // xmlhttp.send(file); // Simple! 
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
		
		//xmlhttp.open("GET","mailEsaya.do?methodtocall=sendEmailFinal&emailconfigid=" + document.getElementById("drpemailconfig").value + "&to=" + document.getElementById("txtto").value + "&subject=" + document.getElementById("txtsubject").value + "&message=" + dojo.byId('txtbody').value,true);
		xmlhttp.open("GET","mailEsaya.do?methodtocall=sendEmailAttachment&emailconfigid=" + document.getElementById("drpemailconfig").value + "&to=" + document.getElementById("txtto").value + "&subject=" + document.getElementById("txtsubject").value + "&message=" + escape(dojo.byId('txtbody').value),true);
		
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
			            col2: arr[x].subject,
			            col3: arr[x].from,
			            col4: arr[x].date,
			            col5: arr[x].id
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

		   	onclickinbox();

		   	document.getElementById("posloading").style.display="none";
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
	//alert("call in popgrid before call");
	document.getElementById("posloading").style.display="block";
	xmlhttp.open("GET","mailEsaya.do?methodtocall=getInEmail&emailconfigid=" + document.getElementById("drpemailconfig").value,true);
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
			    	//var strvar =  '<table border="0" width="100%" style="font-family:AftasansRegular;font-size:13px"><tr><td colspan="3" ><font size="4px"><b>' + arr[0].subject +'</b></font></td></tr><tr><td width="20%"><b>To</b></td><td width="40%">' + strto + '</td><td align="right"><img src="images/mail-reply-all-3.png" width="30px" height="30px" onclick="mailforward(\'reply\',\''+ col1val +'\')" /><img src="images/fast_forward.png" width="30px" height="30px"/><img src="images/email_delete.png" width="30px" height="30px"/></td></tr><tr><td width="20%"><b>From</b></td><td width="40%">' + strfrom +'</td><td></td></tr><tr><td width="20%"><b>Cc</b></td><td width="40%">' + strcc + '</td><td></td></tr><tr><td width="20%"><b>Bcc</b></td><td width="40%">'+ strbcc +'</td><td></td></tr><tr><td width="20%"></td><td></td><td align="right"><b>'+ arr[0].senddate +'</b></td></tr><tr><td colspan=3></div></td></tr><tr><td colspan=3>'+arr[0].message+'</div></td></tr></table>';
			    	//alert(strvar);   	
			        //$("#displayemail").html(strvar);
			    	//document.getElementById("displayemail").style.innerHTML=strvar;

					var strattach=''; 
					for(var i =0;i<arr[0].attachment.length;i++){
						if(arr[0].attachment[i].filename!='NO'){
							strattach=strattach+ '<a href="mailEsaya.do?methodtocall=downloadAttachment&attachid=' +arr[0].attachment[i].attachid+'">'+arr[0].attachment[i].filename+'</a><br/>';
						}
					}
					strattach = strattach + '<br/><br/>';

					document.getElementById("divattachment").innerHTML = strattach;
			    	
			    	
					document.getElementById("txtto").value = strfrom;
					//document.getElementById("displayemail").value = strto;
					document.getElementById("txtcc").value = strcc;
					document.getElementById("txtbcc").value=strbcc;
					//body
					document.getElementById("txtsubject").value=arr[0].subject;	
					//document.getElementById("txtbody").value=arr[0].message;
					dojo.byId('txtbody').value = arr[0].message;
					dijit.byId('txtbody').set('value',arr[0].message);					    	
			}
		    
	    }
	  }
	
	xmlhttp.open("GET","mailEsaya.do?methodtocall=getEmailDetails&ComEvtId=" + colid,true);
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

</script>

<body class="soria">

<input type="hidden" id="txthiddenid" name="txthiddenid"/>
<input type="hidden" id="txthiddenname" name="txthiddenid"/>


<div id="Accordion1" class="Accordion" tabindex="0">
		  <div class="AccordionPanel">
		    <div class="AccordionPanelTab"><img src="images/email.png" width="20" height="20"/> Dashboard </div>
		    <div class="AccordionPanelContent"> 
		    
		    <p>
		    <div id="divrefresh" style="display:block;margin-top: 5px;float: left;">
		    <img src="images/refresh.png" width="40px" height="40px" onclick="popGridXMLHTTPJson();" onmouseover="Tip('Refresh')" onmouseout="UnTip()" /></div>
		    
		    
		    
		    <div id="dropdownconfig"  style="display:block;margin-top: 20px;float: center;margin-left: 370px;font-family:AftasansRegular;">
		   	Mail box : 
		    	<select id="drpemailconfig" onchange="popGridXMLHTTPJson();" onmouseover="Tip('Select Mailbox here')" onmouseout="UnTip()"></select>
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
					  <option value="col2">Subject</option>
					  <option value="col3">From</option>
					  <option value="col4">Date</option>
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