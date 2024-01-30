<!DOCTYPE html>

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
            <div id="username" style="visibility: hidden;">Roberto Smith</div>
            	</a>
            <div id="blade-button">
            <a href="#" target="_self" title="Game Menu" alt="Game Menu">
            <img src="img/bladebutton.png" alt="Menu" name="bladebuttonimg" width="80" height="62" id="bladebuttonimg">
            	</a>
            </div>
          </div><!--HEADER LEFT-->
                  
          <div id="header-right" style="visibility: hidden;">
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

        	<div id="wrapper"><br/><br/>
        
          <div id="formdiv" style="height: 230px;">
          
          <div style="text-align:center; margin-bottom: 30px; font-size:1.75em; font-weight:bold;">Existing Users</div>
          <form action="loginnow.do" name="loginform" class="" id="loginform" method="post" onsubmit="return validate(this)">
          <div style="margin-left: 120px;"><label>Username*: </label><input type="text" name="username" title="Enter Your Username" placeholder="enter username"/></div>
          <div style="clear: both"></div>
          <div style="margin-left: 120px;"><label>Password*: </label><input type="password" name="password" title="Enter Your Password" placeholder="enter password"/></div>
          <div style="clear: both"></div>
          <div style="height: 15px; width: 100%; text-align:center; font-size: .5em;">Forget your User Name or Password? <a href="#" title="This will link to the password recovery solution.">Click Here</a></div>
          <div style="clear: both"></div>
          <%if(request.getParameter("errorstring")!=null){ %>
          <font color="red"><%= request.getParameter("errorstring") %></font>
          <%} %>
          <div><button type="submit" style="color: green" title="Login">Login</button> <button type="reset" style="color: red" title="Reset Fields">Clear</button></div>
          </form>
          </div>
          <div style="clear: both"></div>
          <br />
         <a href="2-newuser.jsp" title="Click here to start a new CaddyBook user account." alt="Click here to start a new CaddyBook user account.">
         <div id="new-user">
         <div style="text-align:center; margin-bottom: 10px; font-size:1.5em; font-weight:bold;">New Users</div>
         <p>Click here to create a new<br />CaddyBook user account.</p>
         <div id="newaccount">New Account</div>
         </div></a>
        	</div><!--WELCOME-->

</div><!--CONTENT-->
                
              <div id="master-button">
              <a href="http://caddybook.com/demo/index.html" title="Master Button" alt="CaddyBook Master Button">
              <img src="img/logoball.png" alt="CaddyBook Master Button" name="masterbutton" width="234" height="238" id="masterbutton">
              	</a></div><!--MASTER BUTTON-->
                
              <div id="nav-block" style="visibility:hidden;">
                
                <div id="nav-left">
                <a href="#" class="fill-div" target="_self" title="Back" alt="Back">
                  	<div id="left-inner">4</div>
                  	</a>
                	</div><!--NAV LEFT-->
                
                <div id="nav-mid">
                <a href="#" target="_self" title="Current Hole" alt="Current Hole">
                	<img src="img/centerblock.png" width="120" height="140" alt="Current">
                	<div id="mid-inner">5</div>  
              		</a>
                </div><!--NAV MID-->
              
              <div id="nav-right">
                	<a href="#" class="fill-div" target="_self" title="Forward" alt="Forward">
                	<div id="right-inner">6</div>
                    </a>
                	</div><!--NAV RIGHT-->
              </div><!--NAV BLOCK-->
              
              <div id="ad-block" title="Ad Block Location" alt="Ad Block Location"></div>
              
        </div><!--MAIN-->
        
    </body>

</html>
