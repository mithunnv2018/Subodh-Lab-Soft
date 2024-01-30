<%@page import="com.golfcaddy.util.QuickSession"%>
<html>
<head>
	<title>KickStart: Greeting</title>
</head>
<body>
    <table border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td>
                <h1><%=request.getAttribute("greeting")%></h1>
                <i>ID is <%= session.getAttribute(QuickSession.SESSION_ID) %></i>
            </td>
        </tr>
    </table>
</body>
</html>