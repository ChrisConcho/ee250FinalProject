<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import = "com.google.gson.JsonObject"%>
<%@page import = "com.google.gson.JsonArray" %>
<%@page import = "com.google.gson.JsonParser" %>
<%@page import = "com.google.gson.JsonElement"%>
<%@page import = "java.net.HttpURLConnection" %>
<%@page import = "java.io.BufferedReader" %>
<%@page import = "java.net.URL"%>
<%@page import = "java.io.InputStreamReader"%>
<%@page import = "java.time.*" %>
<!DOCTYPE html>
<html lang = "en">
<head>
		<meta charset = "UTF-8">
		<link rel = "stylesheet" href = "fonts/Montserrat-Regular.ttf">
		<title>Chris & Eli | Final Project</title>
	

	<style>
	@font-face {
  font-family: MonFontt;
  src: url(fonts/Montserrat-Regular.ttf);
}
body{
	font-family: MonFontt;
}
		h1{
			font-size: 4.5em;
			width: 60%;
			margin-top: 50px;
			margin-right: auto;
			margin-left: auto;	
		}
		#main{
			width: 75%;
			margin-left: auto;
			margin-right: auto;
		}
		#SearchForm label{
			margin-left: auto;
			margin-right: auto;
			font-size: 2em;
		}
		#states{
			font-size: 1.8em;
			margin-left: 10px;
		}
		#SearchForm{
			align-content: center;
			width: 50%;
			margin-left: auto;
			margin-right: auto;
			margin-bottom: 50px;
		}
		a{
			text-decoration: none;
			color: black;
		}
		button{
			margin-left: 15px;
			font-size:1.5em;
			border-radius: 10px;
		}
		button:hover{
			background-color:green;
		}

		
		
	</style>
<%

String json = (String)request.getAttribute("json");
String current_state = (String)request.getAttribute("currstate");
if (current_state == null){
	current_state = "US";
}
if(json==null){
	String url="https://covidtracking.com/api/v1/us/daily.json";
	HttpURLConnection connection = (HttpURLConnection) new URL(url).openConnection();
	connection.setRequestMethod("GET");
	BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
	StringBuilder response1 = new StringBuilder();
	String responseLine = null;
	while ((responseLine = br.readLine()) != null) {
		response1.append(responseLine.trim());
	}
	System.out.println(response1.toString());
	JsonArray jarr = new JsonParser().parse(response1.toString()).getAsJsonArray();
	JsonArray retJarr = new JsonArray();
	json = "[";
	for(JsonElement x: jarr) {
		String date = x.getAsJsonObject().get("date").toString();
		date = date.substring(0,4) + "-"+ date.substring(4,6)+"-"+date.substring(6,8);
		System.out.println(date);
		LocalDate localDate = LocalDate.parse(date);
		Instant instant = localDate.atStartOfDay(ZoneId.systemDefault()).toInstant();
		long timeInMillis = instant.toEpochMilli();
		String element = "{ \"date\" :"+timeInMillis+ ", \"units\": "+ x.getAsJsonObject().get("positive") + "}";
		if ( jarr.get(jarr.size()-1) != x){
			element+= ",";
		}
		json += element;
	}
	json += "]";
	System.out.println(json);
}

%>
	<script>
window.onload = function() {

var dataPoints = [];

var options =  {
	animationEnabled: true,
	theme: "light2",
	title: {
		text: "Positive <%=current_state%> cases"
	},
	axisX: {
		valueFormatString: "DD MMM YYYY",
	},
	axisY: {
		title: "Positive Cases",
		titleFontSize: 24,
		includeZero: false
	},
	data: [{
		type: "spline", 
		yValueFormatString: "#,###.##",
		dataPoints: dataPoints
	}]
};

function addData(data) {
	for (var i = 0; i < data.length; i++) {
		dataPoints.push({
			x: new Date(data[i].date),
			y: data[i].units
		});
	}
	$("#chartContainer").CanvasJSChart(options);

}
addData(<%=json%>);

}


</script>
</head>
<body>
	<a href ="Home.jsp"> <h1 id = "home"> Covid 19 Positive Cases</h1></a>
	<div id="main">
		<form method = "POST" action = "SearchServlet" name = "SearchForm" id = "SearchForm" onSubmit = "return validSearch()">
		<label for="states">Select a State:</label>
<select name = "states" id="states">
<option disabled="" selected="" value = "0">Select One</option> 
  <option value="AL">AL</option>
  <option value="AK">AK</option>
  <option value="AZ">AZ</option>
  <option value="AK">AR</option>
  <option value="CA">CA</option>
  <option value="CO">CO</option>
  <option value="CT">CT</option>
  <option value="DE">DE</option>
  <option value="FL">FL</option>
  <option value="GA">GA</option>
  <option value="HI">HI</option>
  <option value="ID">ID</option>
  <option value="IL">IL</option>
  <option value="IN">IN</option>
  <option value="IA">IA</option>
  <option value="KS">KS</option>
  <option value="KY">KY</option>
  <option value="LA">LA</option>
  <option value="ME">ME</option>
  <option value="MD">MD</option>
  <option value="MA">MA</option>
  <option value="MI">MI</option>
  <option value="MN">MN</option>
  <option value="MS">MS</option>
  <option value="MO">MO</option>
  <option value="MT">MT</option>
  <option value="NE">NE</option>
  <option value="NV">NV</option>
  <option value="NH">NH</option>
  <option value="NJ">NJ</option>
  <option value="NM">NM</option>
  <option value="NY">NY</option>
  <option value="NC">NC</option>
  <option value="ND">ND</option>
  <option value="OH">OH</option>
  <option value="OK">OK</option>
  <option value="OR">OR</option>
  <option value="PA">PA</option>
  <option value="RI">RI</option>
  <option value="SC">SC</option>
  <option value="SD">SD</option>
  <option value="TN">TN</option>
  <option value="TX">TX</option>
  <option value="UT">UT</option>
  <option value="VT">VT</option>
  <option value="VA">VA</option>
  <option value="WA">WA</option>
  <option value="WV">WV</option>
  <option value="WI">WI</option>
  <option value="WY">WY</option>
  <option value="DC">DC</option>

</select>
<button type = "submit" >Submit</button>
	</form>
	
<div id="chartContainer" style="height: 300px; width: 100%;"></div>
<script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script>
<script src="https://canvasjs.com/assets/script/jquery.canvasjs.min.js"></script>
<script>
function validSearch(){
	console.log("we made a submission");
	var x = document.getElementById('states').value;
	if ( x == "0"){
		return false;
	}
	return true;
}
</script>
</body>
</html>