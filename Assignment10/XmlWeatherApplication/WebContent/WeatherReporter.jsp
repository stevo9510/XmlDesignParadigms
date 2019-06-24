<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script>
function bindWeather(weatherSelect){
	var weatherOption = weatherSelect.options[weatherSelect.selectedIndex];
	
	var optionID = weatherOption.getAttribute("id");
	
	if(optionID == "DefaultOption"){
		updateElementsBasedOnWeather("", "", "", "");
	} 
	else {
		var highTemperature = weatherOption.getAttribute("data-high-temperature");
		var lowTemperature = weatherOption.getAttribute("data-low-temperature");
		var description = weatherOption.getAttribute("data-description");
		var iconName = weatherOption.getAttribute("data-icon-name");
		highTemperature = "Hi: " + highTemperature + " F";
		lowTemperature = "Low: " + lowTemperature + " F";
		
		updateElementsBasedOnWeather(highTemperature, lowTemperature, description, iconName);
	}
}

function updateElementsBasedOnWeather(highTemperature, lowTemperature, description, iconName){
	document.getElementById("highTemperature").innerHTML = highTemperature;
	document.getElementById("lowTemperature").innerHTML = lowTemperature;
	document.getElementById("description").innerHTML = description;
	document.getElementById("weatherIcon").setAttribute("src", iconName);
}

</script>
<meta charset="ISO-8859-1">
<title>Weather Reporter</title>
</head>
<body>
<H1>XML Weather JSP Page</H1>
<hr>
<h3>The Weather Reporter</h3>
<select onchange="bindWeather(this);" style="width:175px;">
	<option id="DefaultOption">-- Select a City --</option>
	<c:forEach items="${weatherCities}" var="viewModel">
		<option id="${viewModel.name}"
			data-high-temperature="${viewModel.high}"
			data-low-temperature="${viewModel.low}" 
			data-description="${viewModel.description}"
			data-icon-name="${viewModel.iconName}">${viewModel.name}</option>
	</c:forEach> 
</select>
<br>
<br>
<table>
<col width="100"/>
<col width="75"/>
<tr>
	<td></td>
	<td rowspan="3"><img id="weatherIcon" src=""/></td>
</tr>
<tr>
	<td id="highTemperature" style="color:purple;font-weight:bold;"></td>
</tr>
<tr>
	<td id="lowTemperature" style="color:blue;font-weight:bold;"></td>
</tr>
</table>

<p id="description" style="color:blue;font-size:8pt;"></p>

<hr>
</body>
</html>