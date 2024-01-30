<!DOCTYPE html>

    <%@page import="com.golfcaddy.util.QuickSession"%>
<head>
        <meta charset="utf-8">
        <title>CaddyBook</title>
        <meta name="description" content="Welcome to CaddyBook">
        <meta name="viewport" content="width=device-width">
        <link rel="stylesheet" href="css/main.css">
    </head>
    
    <body>

       	<div id="main">
              <div id="logo">
              	<a href="http://www.caddybook.com/demo/index.html" target="_self" title="CaddyBook | Click here to return to the Home Screen" alt="CaddyBook | Click here to return to the Home Screen">
                <img src="img/logo.png" alt="CaddyBook" name="logo" width="290" height="190" id="logoimg"></a>			
              </div>
              
          <div id="header-left">
            <a href="#" title="Link to User's Profile" alt="Link to User's Profile">
            <div id="username">Roberto Smith</div>
            	</a>
            <div id="blade-button">
            <a href="#" target="_self" title="Game Menu" alt="Game Menu">
            <img src="img/bladebutton.png" alt="Menu" name="bladebuttonimg" width="80" height="62" id="bladebuttonimg">
            	</a>
            </div>
          </div><!--HEADER LEFT-->
                  
          <div id="header-right">
          	<a href="#" title="Link to CaddyBucks for User" alt="Link to CaddyBucks (User)">
            <div id="caddybucks-img"><img src="img/bucks-sm.png" width="40" height="27" alt="">
            	<div id="cb-amt">1250</div>
                </div>
                </a>
            <a href="#" title="Link to Course's profile Page" alt="Link to Course's profile Page">
            <div id="coursename">Generic Golf Country Club</div>
            	</a>
          </div><!--HEADER RIGHT-->
          
          		<div id="alert-l"></div>
                <div id="alert-r"></div>
                <div id="leader"></div>
                
                	<div id="content">
                    <div id="wrapper">
                    <div id="formdiv" style="height: 740px; width: 700px">
          <div id="coursesearchheader">Golf Course Search</div><br />
          <div id="innerform" >
          <form action="coursesearch.do" name="coursesearchform" class="" id="coursesearchform" method="post" onsubmit="return validate(this)">
          <div>
<div style="clear: both"></div>
          <label>Golf Course: </label>
          <input type="text" name="coursename" title="Golf Course Name" placeholder="course name" size="25"/>
          </div>
<div style="clear: both"></div>
          <div style="text-align:left;">
          <label>City: </label>
          <input type="text" name="city" title="City Name" placeholder="city" size="38"/>
          </div>
<div style="clear: both"></div>
          <div style="text-align:left; margin-right: 100px;">
          <label>State: </label><select name="state">
                        
                        <% String[] states=(String[])session.getAttribute(QuickSession.SESSION_STATESLIST); %>
                        
                        <% 
                        if(states!=null && states.length!=0)
                        {
                        	for(int i=0;i<states.length;i++)
                        	{	
                        	
                        	
                        %>
                        <option value="<%= states[i] %>"><%=states[i] %></option>
                        <%
                        	}
                        }
                        else
                        {
                        %>
                        <option value="NA">Empty</option>	
                        <%
                        }
                        %>
          </select>
			</div>
<div style="clear: both"></div>
          <div id="coursesearch">
          <button type="submit" style="color: green" title="Search">Search</button>
          </div>
          </form>
          </div><hr>
          <%
          	String[][] search2=(String[][])request.getAttribute(QuickSession.REQUEST_COURSESEARCH_RESULT);	
          %>
          <div id="search-results">
          
          <ul>
         
            <li class="list-state"><%= search2[0][0] %></li>
            <li class="list-city"><%= search2[0][1] %></li>
        	 <%
        	 String tempcity=search2[0][1];
          	for(int i=0;i<search2.length;i++)
          	{
          		if(!(search2[i][1].equals(tempcity))){
          %>
        	   		 <li class="list-city"><%= search2[i][1] %></li>
        	   		 <%
        			 tempcity = search2[i][1];  		 
          			
          		} %>
		            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html"><%= search2[i][2] %></a></li>
 		            
           <%
          	}
           %> 
<!--             	<li class="list-city">Charleston</li>
		            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course6</a></li>
		            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course7</a></li>
		            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course8</a></li>
		            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course9</a></li>
		            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course10</a></li>
		            
            <li class="list-state">North Carolina</li>
            <li class="list-city">Wilmington</li>
            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course11</a></li>
            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course12</a></li>
            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course13</a></li>
            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course14</a></li>
            <li class="list-course"><a href="http://www.caddybook.com/demo/coursesearch2.html">Generic Golf Course15</a></li>
- -->  
          </ul>
          </div><!--SEARCHRESULTS-->
         
        			</div><!--FORMDIV-->
                    </div><!--WRAPPER-->
                    </div><!--CONTENT-->
                
              <div id="master-button">
              <a href="#" title="Master Button" alt="Master Button">
              <img src="img/logoball.png" alt="CaddyBook Master Button" name="masterbutton" width="234" height="238" id="masterbutton">
              	</a></div><!--MASTER BUTTON-->
                
              <div id="nav-block">
                
                <div id="nav-left-search">
                <a href="javascript:history.go(-1)" class="fill-div" target="_self" title="Back" alt="Back">
                  	<div id="left-inner" style="visibility:hidden;">4</div>
                  	</a>
                	</div><!--NAV LEFT-->
                
                <div id="nav-mid" style="visibility:hidden;">
                <a href="#" target="_self" title="Current Hole" alt="Current Hole">
                	<img src="img/centerblock.png" width="120" height="140" alt="Current">
                	<div id="mid-inner">5</div>  
              		</a>
                </div><!--NAV MID-->
              
              <div id="nav-right-search" style="visibility:hidden;">
                	<a href="#" class="fill-div" target="_self" title="Forward" alt="Forward">
                	<div id="right-inner">6</div>
                    </a>
                	</div><!--NAV RIGHT-->
              </div><!--NAV BLOCK-->
              
              <div id="ad-block" title="Ad Block Location" alt="Ad Block Location"></div>
              
        </div><!--MAIN-->
        
    </body>

</html>
