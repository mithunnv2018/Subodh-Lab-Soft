<!DOCTYPE html>
<%@taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html"%>
<%@taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
 
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
			<a href="http://www.caddybook.com/demo/index.html" target="_self"
				title="CaddyBook | Click here to return to the Home Screen"
				alt="CaddyBook | Click here to return to the Home Screen"> <img
				src="img/logo.png" alt="CaddyBook" name="logo" width="290"
				height="190" id="logoimg"></a>
		</div>

		<div id="header-left">
			<a href="#" title="Link to User's Profile"
				alt="Link to User's Profile">
				<div id="username" style="visibility: hidden">Roberto Smith</div>
			</a>
			<div id="blade-button">
				<a href="#" target="_self" title="Game Menu" alt="Game Menu"> <img
					src="img/bladebutton.png" alt="Menu" name="bladebuttonimg"
					width="80" height="62" id="bladebuttonimg">
				</a>
			</div>
		</div>
		<!--HEADER LEFT-->

		<div id="header-right" style="visibility: hidden">
			<a href="#" title="Link to CaddyBucks for User"
				alt="Link to CaddyBucks (User)">
				<div id="caddybucks-img">
					<img src="img/bucks-sm.png" width="40" height="27" alt="">
					<div id="cb-amt">1250</div>
				</div>
			</a> <a href="#" title="Link to Course's profile Page"
				alt="Link to Course's profile Page">
				<div id="coursename">Generic Golf Country Club</div>
			</a>
		</div>
		<!--HEADER RIGHT-->

		<div id="alert-l"></div>
		<div id="alert-r"></div>
		<div id="leader"></div>

		<div id="content">
			<div id="wrapper">
				<div id="formdiv" style="height: 570px; margin-top: 100px;">
					<h3>
						New User<br />Account Creation
					</h3>
					<br />
					<hr>
					<br />
					<!--  <form action="http://www.caddybook.com/demo/3-coursesearch.html" name="newuserform" class="" id="newuserform" method="post" onsubmit="return validate(this)">
                       -->
					<html:form action="register">
						<div style="text-align: left; margin-left: 100px;">
							<label>First Name:</label><input type="text" name="firstname"
								title="Enter Your First Name" placeholder="first name" size="25" />
						</div>
						<div style="clear: both"></div>
						<div style="text-align: left; margin-left: 100px;">
							<label>Last Name:&nbsp;</label><input type="text" name="lastname"
								title="Enter Your Last Name" placeholder="last name" size="25" />
						</div>
						<div style="clear: both"></div>
						<div style="text-align: left; margin-left: 100px;">
							<label>Username*:</label><input type="text" name="username"
								title="Enter Your Username" placeholder="username" size="25" />
						</div>
						<div style="clear: both"></div>
						<div style="text-align: left; margin-left: 100px;">
							<label>Email*:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input
								type="text" name="email" title="Enter Your Email Address"
								placeholder="email" size="25" />
						</div>
						<div style="clear: both"></div>
						<div style="text-align: left; margin-left: 100px;">
							<label>Password*:</label><input type="password" name="password"
								title="Enter Your Password" placeholder="password" size="25" />
						</div>
						<div style="clear: both"></div>
						<div style="text-align: left; margin-left: 100px;">
							<label>Gender*:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><select
								name="genderdrop"><option value="male">Male</option>
								<option value="female">Female</option></select>
						</div>
						<div style="clear: both"></div>
						<div style="text-align: left; margin-left: 100px;">
							<label>Handicap*:&nbsp;&nbsp;</label><select name="handidrop"
								placeholder="0">
								<option value="--">--</option>
								<option value="+4">+4</option>
								<option value="+3">+3</option>
								<option value="+2">+2</option>
								<option value="+1">+1</option>
								<option value="0">0</option>
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
								<option value="13">13</option>
								<option value="14">14</option>
								<option value="15">15</option>
								<option value="16">16</option>
								<option value="17">17</option>
								<option value="18">18</option>
								<option value="19">19</option>
								<option value="20">20</option>
								<option value="21">21</option>
								<option value="22">22</option>
								<option value="23">23</option>
								<option value="24">24</option>
								<option value="25">25</option>
								<option value="26">26</option>
								<option value="27">27</option>
								<option value="28">28</option>
								<option value="29">29</option>
								<option value="30">30</option>
								<option value="31">31</option>
								<option value="32">32</option>
								<option value="33">33</option>
								<option value="34">34</option>
								<option value="35">35</option>
								<option value="36">36</option>
							</select>
						</div>
						<div style="clear: both"></div>
						<div style="text-align: left; margin-left: 100px; width: 320px;">
							<input type="checkbox" name="Terms &amp; Conditions"
								title="Terms &amp; Conditions" /><label><span
								style="font-size: 12px;">&nbsp;Please read and agree to
									our <a href="http://www.caddybook.com/demo/2-tos.html"><b
										style="text-decoration: underline; color: red;">Terms
											&amp; Conditions*</b></a>
							</span></label>
						</div>
						<div style="clear: both"></div>
						<div style="float: left; margin-left: 160px;">
							<button type="submit" style="color: green" title="Submit">&nbsp;&nbsp;Next&nbsp;&nbsp;</button>
							
							<button type="reset" style="color: red" title="Reset Fields">Clear</button>
						</div>
					</html:form>
					<!--      </form>
                  -->
				</div>
				<!--FORMDIV-->
			</div>
			<!--WRAPPER-->
		</div>
		<!--CONTENT-->

		<div id="master-button">
			<a href="http://caddybook.com/demo/index.html" title="Master Button"
				alt="Master Button"> <img src="img/logoball.png"
				alt="CaddyBook Master Button" name="masterbutton" width="234"
				height="238" id="masterbutton">
			</a>
		</div>
		<!--MASTER BUTTON-->

		<div id="nav-block">

			<div id="nav-left-search">
				<a href="javascript:history.go(-1)" class="fill-div" target="_self"
					title="Back" alt="Back">
					<div id="left-inner" style="visibility: hidden;">4</div>
				</a>
			</div>
			<!--NAV LEFT-->

			<div id="nav-mid" style="visibility: hidden;">
				<a href="#" target="_self" title="Current Hole" alt="Current Hole">
					<img src="img/centerblock.png" width="120" height="140"
					alt="Current">
					<div id="mid-inner">5</div>
				</a>
			</div>
			<!--NAV MID-->

			<div id="nav-right-search" style="visibility: hidden;">
				<a href="#" class="fill-div" target="_self" title="Forward"
					alt="Forward">
					<div id="right-inner" style="visibility: hidden;">6</div>
				</a>
			</div>
			<!--NAV RIGHT-->
		</div>
		<!--NAV BLOCK-->

		<div id="ad-block" title="Ad Block Location" alt="Ad Block Location"></div>

	</div>
	<!--MAIN-->

</body>

</html>
