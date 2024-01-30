<%@ taglib uri="/WEB-INF/struts-logic" prefix="logic" %>
<h2>You have an error.</h2>
<%= request.getAttribute("errorstring") %>
<a href="2-newuser.jsp">Click here to register</a> <br/>
<a href="1-start.jsp">Click here to Login Again</a>
