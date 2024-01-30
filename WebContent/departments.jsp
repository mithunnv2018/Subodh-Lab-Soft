<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.esaya.util.FormUtil"%>

<%HttpSession sessionx = request.getSession(true);%>
        
 <%if(sessionx!=null){ %>
 <%String param = (String)sessionx.getAttribute("user");%>
 <%if(param==null||(param.equals(""))){ %>
 
	<script>
	window.location.assign("login.do");
	</script>
<%}} %>
<script>
dojo.require("dojox.grid.EnhancedGrid");
dojo.require("dojox.grid.enhanced.plugins.Pagination");
dojo.require("dojo.data.ItemFileWriteStore");
dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");

dojo.require("dojox.grid.DataGrid");
dojo.require("dijit.form.Button");
dojo.require("dojo.data.ItemFileWriteStore");

var addBtn;

<%JSONArray returnvalue2 =FormUtil.makeDepartmentslist();%>
<%if(returnvalue2!=null){%>
var introw=<%=returnvalue2.length()%>;
<%}else{%>

var introw = 0;
<%}%>

var isEdit=false;
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

                     <%if(returnvalue2!=null){%>
				<%for(int x=0;x<returnvalue2.length();x++){%>
				<%//JSONObject objjson= new JSONObject();%> 
				<%JSONObject objjson= returnvalue2.getJSONObject(x);%>
      				{ id: '<%=x%>', col2: '<%=objjson.get("department")%>',col3:'<%=objjson.get("id")%>'}
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
      {name: 'Department', field: 'col2' ,width: "300px"},
      {name: 'dept id', field: 'col3' ,width: "200px", hidden:true}
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
	
	dojo.connect(grid.selection, 'onSelected', 
		function(rowIndex)
		{
			
			var col1val=grid.store.getValue(grid.getItem(rowIndex),"col3");
			//alert("U selected"+rowIndex+" "+col1);
			document.getElementById("txthiddenid").value = col1val;
			//document.getElementById("txtemployeecat").value = col1;
			//alert("hidden: "+document.getElementById("txthiddenid").value);
			
		})
});

//start add new row


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
	
	//alert("Grid query"+colname+"text="+text);
}
function refresh(){

	var x = <%=new Random().nextLong()%>;
	location.reload(true);
}

function popGridXMLHTTPJson()
{
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		  	//alert("getempcatllresp:" +resp);
		  	clearMyGrid();
		    //clearMyGrid();
		    dijit.byId("grid").store.save();
		    dijit.byId("grid").render();
		    dijit.byId("grid").startup();
		    var arr = JSON.parse(resp);

		    //alert(arr[0].id);
		    //alert(arr[0].empcatname);
		    //introw=0;
		   	for(var x=0;x<arr.length;x++){
		   		//alert("in above 0: " + introw + " rowcount: " + dijit.byId("grid").rowCount + " arr:" + arr[x].empcatname);			   	
		   		var myNewItem = {
			            id: introw,
			            col2: arr[x].department,
			            col3: arr[x].id
			            
			        };
			        // Insert the new item into the store:
			        // (we use store3 from the example above in this example)
			    dijit.byId("grid").store.newItem(myNewItem);
			    dijit.byId("grid").store.save();
			    dijit.byId("grid").render();
			    introw = introw+1;
			   	}


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
	
	xmlhttp.open("GET","addDepartmentsMaster.do?methodtocall=getDeptarmentsAll",true);
	xmlhttp.send();
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

	alert("hi");
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
			
			popGridXMLHTTPJson();
			window.setTimeout( sortingauto, 2000 );
			document.getElementById("txthiddenid").value="";
			document.getElementById("txtdepartment").value=""; 
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
	  if(document.getElementById("txtdepartment").value==""){
		alert("Please enter Department")
		  }
	  else if(isEdit==true){
		  if(document.getElementById("txthiddenid").value!=""){	
		//alert("inside add" + document.getElementById("txthiddenid").value);
	 	//alert("inside edit" + isEdit);
	 	xmlhttp.open("GET","addDepartmentsMaster.do?methodtocall=edit&txtdepartment=" + document.getElementById('txtdepartment').value + "&txtdepartmentid=" + document.getElementById('txthiddenid').value,true);
	 	xmlhttp.send();
	 	 
		  }else{
			alert("Please select an entry from grid");
			  }
	}else{
		//alert("inside new");
		//alert("inside " + document.getElementById("txthiddenid").value);
		xmlhttp.open("GET","addDepartmentsMaster.do?methodtocall=add&txtdepartment=" + document.getElementById('txtdepartment').value,true);
	
		xmlhttp.send();
		}
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
</script>

<input type="hidden" id="txthiddenid" name="txthiddenid"/>
<input type="hidden" id="txthiddenname" name="txthiddenid"/>


<div id="Accordion1" class="Accordion" tabindex="0">
		  <div class="AccordionPanel">
		    <div class="AccordionPanelTab"><img src="images/man-user.png" width="20" height="20"/> Add / Modify Department</div>
		    <div class="AccordionPanelContent"> 
		    
		    <p>
		    
		   <table border=0 width="90%">
		   	<tr>
		   	<td style="font-family: AftasansRegular;font-size: 13px">
		   		Department :
		   	</td>
			<td>
				<input type="text" id="txtdepartment" name="txtdepartment" placeholder="Department" size="18">
			</td>
		   	</tr>
		   	<tr>
		   	<td align="right">
		   	<input name="btnsave" onclick="savedata();" type="button" value="Save" style="background-color:#000; color:#FFF;border-color: #000;border-bottom-color: #000;border-left-color: #000;border-right-color: #000;border-top-color: #000; height: 23px;width: 45px"/>
		   	</td>
		   	
		   	
		   	<td align="left"><input name="Login" type="button" onclick="cancel();" value="Cancel" style="background-color:#000; color:#FFF;border-color: #000;border-bottom-color: #000;border-left-color: #000;border-right-color: #000;border-top-color: #000; height: 23px;width: 55px"/></td>
		   	</tr>
		   	<tr>
		   	<td>
		   	
		   	
		   	</td>
		   	<td>
		   	</td>
		   	</tr>
		   	<tr>
		   	<td><img src="images/refresh.png" width="20px" height="20px" align="left" onclick="popGridXMLHTTPJson();"></td>
		   	<td align="right"><input name="btnEdit" onclick="editdata();" type="button" value="Edit" style="background-color:#000; color:#FFF;border-color: #000;border-bottom-color: #000;border-left-color: #000;border-right-color: #000;border-top-color: #000; height: 23px;width: 45px" align="right"/></td>
		   	</tr>
		   	
		   </table>
		     
		    <div id="gridDiv" ></div>
		    
		    <table align="center">
		<tr>
			<td>Column Names</td>
			<td>
				<select id="searchcolname" name="searchcolname">
	            
	            	<option value=" " selected="selected">Select Column Name</option>
					  <option value="col2">Department Category</option>
					<!--<option value="col3">Subject</option>
					 <option value="col4">Status</option>
					 <option value="col6">EmailID</option>
					 -->
					  
				</select>
			</td>
		 	<td>Search text</td>
			<td>
				<input type="text" id="searchtext" name="searchtext" value="" />
			</td>	
		 	<td colspan=2>
				<input type="button" onClick='filtermit();' value="Filter"/>			
			</td>
		</tr>
	</table>	
		    </p>
		    <p>
		    
		    
		    </p>
           </div>
	    </div>
        <!---------------------*******************-------------------------------->

          <!---------------------*******************-------------------------------->
	  </div>
