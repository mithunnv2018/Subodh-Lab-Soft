<%@page import="org.json.JSONObject"%>
<%@page import="org.json.JSONArray"%>
<%@page import="java.util.Random"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.esaya.util.FormUtil"%>


<script>
dojo.require("dojox.grid.EnhancedGrid");
dojo.require("dojox.grid.enhanced.plugins.Pagination");
dojo.require("dojo.data.ItemFileWriteStore");
dojo.require("dojox.grid.enhanced.plugins.IndirectSelection");

dojo.require("dojox.grid.DataGrid");
dojo.require("dijit.form.Button");
dojo.require("dojo.data.ItemFileWriteStore");

var addBtn;

var rowselect=0;
var introw = 0;
var count=0;
<%JSONArray returnvalue2 =FormUtil.getRoleMaster();%>
<%if(returnvalue2!=null){%>
var introw2=<%=returnvalue2.length()%>;
var count2=<%=returnvalue2.length()%>;
<%}else{%>
var count2=0;
var introw2=0;
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
      {name: 'Module', field: 'col2' ,width: "200px"},
      {name: 'Access', field: 'col3' ,width: "100px"},
      {name: 'Add', field: 'col4' ,width: "100px"},
      {name: 'Edit', field: 'col5' ,width: "100px"},
      {name: 'Delete', field: 'col6' ,width: "100px"},
      {name: 'modulename', field: 'col6' ,width: "0px", hidden:true}
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
	 	style: "width: 910px; height: 200px;font-size: 13px;font-family:AftasansRegular;",
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
	
	//Grid two
	var data2 = {
      identifier: 'id',
      items: []
    };
    
	var data_list2 = [

	                <%if(returnvalue2!=null){%>
	  				<%for(int x=0;x<returnvalue2.length();x++){%>
	  				<%//JSONObject objjson= new JSONObject();%> 
	  				<%JSONObject objjson= returnvalue2.getJSONObject(x);%>
	        				{ id: '<%=x%>', col2: '<%=objjson.get("name")%>',col3:'<%=objjson.get("id")%>'}
	        				<%if(!(returnvalue2.length()-1==x)){%>
	  						,
	        				<%}%>
	        			<%}%>
	  			<%}%>

          	];
	                //var rows = 200;
	                //alert("Length"+data_list.length);
            for(var i=0; i<data_list2.length;  i++){
                    //alert("data[" + i + "] : " + data_list[i]);
                 data2.items.push(dojo.mixin({ id: i+1 }, data_list2[i]));
            }
            var store2 = new dojo.data.ItemFileWriteStore({data: data2});

	                /*set up layout*/
             var layout2 = [[
	                  {name: 'ID', field: 'id',width: "30px", editable : false, hidden:true},
	                  {name: 'Role Name', field: 'col2' ,width: "300px"},
	                  {name: 'roleid', field: 'col3' ,width: "0px", hidden:true}
	                ]];

	
	
	var gridx1 = new dojox.grid.EnhancedGrid({
        id: 'gridx1',
        store: store2,
        structure: layout2,
        rowSelector: '40px',
        query: {col2 :"*"},
	 	selectionMode: "single",
	 	queryOptions: {ignoreCase:true} ,
	 	style: "width: 910px; height: 300px;font-size: 13px;font-family:AftasansRegular;",
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
	
	
	//Grid two ends here
	
	
	dojo.connect(grid.selection, 'onSelected', 
		function(rowIndex)
		{
			rowselect= rowIndex;
			var col1val=grid.store.getValue(grid.getItem(rowIndex),"col3");
			//alert("U selected"+rowIndex+" "+col1);
			document.getElementById("txthiddenid").value = col1val;
			//document.getElementById("txtemployeecat").value = col1;
			//alert("hidden: "+document.getElementById("txthiddenid").value);
			
		})
		

									
});

//start add new row
function griddelete(){
 
	var items = dijit.byId("grid").selection.getSelected();
    if (items.length) {
    // Iterate through the list of selected items.
    // The current item is available in the variable
    // "selectedItem" within the following function:
        //alert("inside delete before (-) : " + introw + "rowselect: " + rowselect);
        if(rowselect!=0){
        dojo.forEach(items, function(selectedItem) {
            if (selectedItem !== null) {
                // Delete the item from the data store:
                dijit.byId("grid").store.deleteItem(selectedItem);
          //      alert("delete inside rowslect != 0");
                introw = introw - 1;
            //    alert("after introw -1");
            } // end if
        }); // end forEach
        }else{
//        	alert("delete inside rowslect == 0");

        	dijit.byId("grid").rowSelectCell.toggleRow(0, true)
    		//dijit.byId("grid").store.deleteItem(selectedItem);

    		//new
    		recipeIngredientItem = dijit.byId("grid").getItem(0);
    		//alert('before');
    		//dijit.byId("grid").deleteItem(recipeIngredientItem);
    		dijit.byId("grid").store.deleteItem(recipeIngredientItem);
            	
        	
        	introw = introw - 1;
//        	alert("after introw -1");			
            }
  //      alert("inside delete: " + introw);
        dijit.byId("grid").store.save();
        dijit.byId("grid").render();
        } // end if
}

function gridadd(){

	
	var myNewItem = {
            id: count,
            col2: document.getElementById("drpmodule").options[document.getElementById('drpmodule').selectedIndex].text,
            col3: document.getElementById("drpaccess").value,
            col4: document.getElementById("drpadd").value,
            col5: document.getElementById("drpedit").value,
            col6: document.getElementById("drpdelete").value,
            col7: document.getElementById("drpmodule").value    
            
            
        };
        // Insert the new item into the store:
        // (we use store3 from the example above in this example)
    dijit.byId("grid").store.newItem(myNewItem);
    dijit.byId("grid").store.save();
    dijit.byId("grid").render();
//    alert("inside add: " + introw);
    count = count + 1;
	introw = introw+1;
	//alert("inside add after add: " + introw);
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
	
	//alert("Grid query"+colname+"text="+text);
}
function refresh(){

	var x = <%=new Random().nextLong()%>;
	location.reload(true);
}
function popGridXMLHTTPJson1()
{
	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		  	//alert("getempcatllresp:" +resp);
		  	clearMyGrid1();
		    //clearMyGrid();
		    dijit.byId("gridx1").store.save();
		    dijit.byId("gridx1").render();
		    dijit.byId("gridx1").startup();
		    var arr = JSON.parse(resp);

		    //alert(arr[0].id);
		    //alert(arr[0].empcatname);
		    //introw=0;
		   	for(var x=0;x<arr.length;x++){
		   		//alert("in above 0: " + introw + " rowcount: " + dijit.byId("grid").rowCount + " arr:" + arr[x].empcatname);			   	
		   		var myNewItem = {
			            id: introw2,
			            col2: arr[x].name,
			            col3: arr[x].id		            
			            
			        };
			        // Insert the new item into the store:
			        // (we use store3 from the example above in this example)
			        
			        //alert("loop name:" + arr[x].name );
			    dijit.byId("gridx1").store.newItem(myNewItem);
			    dijit.byId("gridx1").store.save();
			    dijit.byId("gridx1").render();
			    introw2 = introw2+1;
			   	}


	    }
	  }
	
	xmlhttp.open("GET","addUserroleMaster.do?methodtocall=getRoleMaster",true);
	xmlhttp.send();
	//alert("after send pop");

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

function clearMyGrid1()
{
	//Clear grid code working
/*var emptyCells = { items: "" };
var emptyStore = new dojo.data.ItemFileWriteStore({data: emptyCells});
dijit.byId("grid").setStore(emptyStore);
*/
	
	var x = introw2;
	//alert("cleargrid" + introw2);
	for(var i=0;i<x;i++){
		//alert('inside loop' + i + ' rows:' + dijit.byId("grid").rowCount + ' introw:' + introw);
		//var selectedItem = dijit.byId("grid").selection.setSelected(i);
		//dijit.byId("grid").selection.setSelected(i);
		dijit.byId("gridx1").rowSelectCell.toggleRow(0, true)
		//dijit.byId("grid").store.deleteItem(selectedItem);

		//new
		recipeIngredientItem = dijit.byId("gridx1").getItem(0);
		//alert('before');
		//dijit.byId("grid").deleteItem(recipeIngredientItem);
		dijit.byId("gridx1").store.deleteItem(recipeIngredientItem);
		//alert('after deleting');
		dijit.byId("gridx1").store.save();
		dijit.byId("gridx1").render();				
	}
	introw2 = 0;
	//alert("after cleargrid" + introw2);	
}


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
		
	//window.setTimeout( poppartytype, 500 );
	
	//window.setTimeout( popempcat, 1000 );
	//window.setTimeout( popdepartment, 1500 );
	//window.setTimeout( popcommunicationtype, 2000 );
	
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
function sortingauto1(){
	
	var text="P";
   	text="*"+text+"*";
	//alert("Before query");
   	dijit.byId("gridx1").setQuery({col2:text});
	text="";
   	text="*"+text+"*";
   	dijit.byId("gridx1").setQuery({col2:text});
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
			
//		    clearMyGrid1();

		     
		    popGridXMLHTTPJson1();
			window.setTimeout( sortingauto1, 2000 );


			clearMyGrid();
		    window.setTimeout( sortingauto, 1000 );
		    
			isEdit=false;
			document.getElementById("txtrolename").value = "";
			//alert(returnparamgrid());
			//alert("After timeout");
		   	 	
			dijit.byId("grid").startup();
			dijit.byId("grid").store.save();
		    dijit.byId("grid").render();

		    dijit.byId("gridx1").startup();
			dijit.byId("gridx1").store.save();
		    dijit.byId("gridx1").render(); 
		    //dijit.byId("grid").rowSelectCell.toggleRow(0, true);
		    //dijit.byId("grid").pagination.plugin.nextPage;
		    
			//cleardata();
		    }else{
			    	alert("Data Not Saved Successfully");
			}
			
	    }
	  }
		
	var strval;
	strval = '[';
	var x = introw;
	alert(introw);
	for(var i=0;i<x;i++){
	strval = strval + '{';
	var module=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col7");
	var access=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col3");
	var add=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col4");
	var edit=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col5");
	var delete1=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col6");
	strval = strval + '"module":"' + module + '","access":"' + access + '","add":"' + add + '","edit":"' + edit + '","delete":"' + delete1;
	strval = strval + '"}';
		if(i!=(x-1)){
			strval = strval + ',';
				
		}
	}
	strval = strval + ']';



	//alert(strval);
		 
	var url = 'addUserroleMaster.do?methodtocall=add&txtrolename=' + document.getElementById('txtrolename').value +  '&roledetailsjson=' + escape(strval);
		//var url='";
		xmlhttp.open("POST",url ,true);
	
		xmlhttp.send();
	//	}
	//alert(xmlhttp.responseText); 	
}
function returnparamgrid(){

	var strval;
	strval = '[';
	var x = introw;
	alert(introw);
	for(var i=0;i<x;i++){
	strval = strval + '{';
	var module=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col7");
	var access=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col3");
	var add=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col4");
	var edit=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col5");
	var delete1=dijit.byId("grid").store.getValue(dijit.byId("grid").getItem(i),"col6");
	strval = strval + '"module":"' + module + '","access":"' + access + '","add":"' + add + '","edit":"' + edit + '","delete":"' + delete1;
	strval = strval + '"}';
		if(i!=(x-1)){
			strval = strval + ',';
				
		}
	}
	strval = strval + ']';
	alert(strval);
	return strval;
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

function jsonread(){


	xmlhttp.onreadystatechange=function()
	  {
	  if (xmlhttp.readyState==4 && xmlhttp.status==200)
	    {
			var resp = xmlhttp.responseText;

		    //var arr = JSON.parse(resp);
		    alert(resp);
	     }
	  }


	
	var json_tank = {   "player_id" : "abc",  
            "tank_id" : "xfgr"  
              
		};

	var str1 = '[{"id":"82EMPCAT","empcatname":"Atul1"},{"id":"83EMPCAT","empcatname":"Kulve1"},{"id":"84EMPCAT","empcatname":"esaya"},{"id":"85EMPCAT","empcatname":"aa"},{"id":"86EMPCAT","empcatname":"Atulx"},{"id":"87EMPCAT","empcatname":"emp1"},{"id":"88EMPCAT","empcatname":"emp3"},{"id":"89EMPCAT","empcatname":"emp2"},{"id":"90EMPCAT","empcatname":"AAA"},{"id":"91EMPCAT","empcatname":"EEE"}]';
	  
	//var obj = JSON.parse(json23);
	alert("json_tank: " + json_tank.toJSONString());
	alert("displayescape: " + escape(json_tank.toJSONString()));
	//xmlhttp.open("POST","addPartyMaster.do?methodtocall=demoreadjson&readjson=" + escape(json_tank.toJSONString()),true);
	xmlhttp.open("POST","addPartyMaster.do?methodtocall=demoreadjson&readjson=" + escape(str1),true);
	xmlhttp.send();
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



<input type="hidden" id="txthiddenid" name="txthiddenid"/>
<input type="hidden" id="txthiddenname" name="txthiddenid"/>


<div id="Accordion1" class="Accordion" tabindex="0">
		  <div class="AccordionPanel">
		    <div class="AccordionPanelTab"><img  src="images/man-user.png" width="20" height="20"/> Add/Modify  Roles</div>
		    <div class="AccordionPanelContent"> 
		    
		    <p>
		    
		   <table border=0 width="90%">
		   	<tr> 
		   	<td  style="font-family: AftasansRegular;font-size: 13px">
		   		Role Name :
		   	</td>
		   	<td>
			<input type="text" id="txtrolename" name="txtrolename" placeholder="Role Name" size="18">
			</td>
			<tr>
			<td style="font-family: AftasansRegular;font-size: 13px">
			
			</td>
			</table>
			
			<table width="90%">
		   
		   	<tr>
		   	<td colspan="2">
		   	
		   	<table border=0 width="100%">
			<tr>
			<td style="font-family: AftasansRegular;font-size: 15px" colspan="4">
			 <b>Add Module Roles</b>
			</td>
			
			</tr>
			<tr>
			<td style="font-family: AftasansRegular;font-size: 13px">
			Module
			</td>
			<td style="font-family: AftasansRegular;font-size: 13px">
			Access
			</td>
			<td style="font-family: AftasansRegular;font-size: 13px">
			Add
			</td>
			<td style="font-family: AftasansRegular;font-size: 13px">
			Edit
			</td>
			<td style="font-family: AftasansRegular;font-size: 13px">
			Deletes
			</td>
			</tr>
			<tr>
			<td>
			<select id="drpmodule">
			<option value="dashboard">Dashboard</option>
			<option value="party">Party</option>
			<option value="department">Department</option>
			<option value="role">Role Master</option>
			<option value="employeecategory">Employee Category</option>
			 
			</select>
			</td>
			<td>
			<select id="drpaccess">
			<option value="YES">Yes</option>
			<option value="NO">No</option>
			</select>
			</td>
			<td>
			<select id="drpadd">
			<option value="YES">Yes</option>
			<option value="NO">No</option>
			</select>
			</td>
			<td>
			<select id="drpedit">
			<option value="YES">Yes</option>
			<option value="NO">No</option>
			</select>
			</td>
			<td>
			<select id="drpdelete">
			<option value="YES">Yes</option>
			<option value="NO">No</option>
			</select>
			</td> 
			</tr>
			<tr>
			<td><input name="btnAdd" onclick="gridadd();" type="button" value="Add" style="background-color:#000; color:#FFF;border-color: #000;border-bottom-color: #000;border-left-color: #000;border-right-color: #000;border-top-color: #000; height: 23px;width: 45px" align="right"/></td>
		   	<td colspan="3"></td>
		   	<td align="right"><input name="btnAdddelete" onclick="griddelete();" type="button" value="Delete" style="background-color:#000; color:#FFF;border-color: #000;border-bottom-color: #000;border-left-color: #000;border-right-color: #000;border-top-color: #000; height: 23px;width: 50px" align="right"/></td>
			</tr>
			</table>
			
		   	</td>
		   	</tr>
		   	<tr>
		   	<td colspan="2">
		   	<div id="gridDiv" ></div>
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
		   	
		   	
		   </table>
		     
		    
		    
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
		    <input type="button" onClick='returnparamgrid();' value="json read"/>
		    <p>
		  <div id="gridDivx1"></div>  	
		  
		    </p>
           </div>
	    </div>
        <!---------------------*******************-------------------------------->

          <!---------------------*******************-------------------------------->
	  </div>
