<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script>
function bindWeather(weatherSelect){
	var weatherOption = weatherSelect.options[weatherSelect.selectedIndex];
	
	var optionID = weatherSelect.getAttribute('id');
	
	if(optionID != '*Default*'){
		var highTemperature = weatherOption.getAttribute('data-high-temperature');
		var lowTemperature = weatherOption.getAttribute('data-low-temperature');
		var description = weatherOption.getAttribute('data-description');
		var iconName = weatherOption.getAttribute('data-icon-name');
		
		updateElementsBasedOnWeather(highTemperature, lowTemperature, description, iconName);
	} 
	else {
		updateElementsBasedOnWeather("", "", "", "");
	}
}

function updateElementsBasedOnWeather(highTemperature, lowTemperature, description, iconName){
	document.getElementById("highTemperature").innerHTML = highTemperature;
	document.getElementById("lowTemperature").innerHTML = lowTemperature;
	document.getElementById("description").innerHTML = description;
	document.getElementById("weatherIcon").getAttribute('source') = iconName;
}

</script>
<meta charset="ISO-8859-1">
<title>Weather Reporter</title>
</head>
<body>

<h3>The Weather Reporter</h3>
<p id="highTemperature"></p>
<p id="lowTemperature"></p>
<img id="weatherIcon" source=""/>
<select onchange="bindWeather(this);">
	<option id="*Default*">-- Select a City --</option>
	<c:forEach items="${weatherCities}" var="viewModel">
		<option id="${viewModel.name}"
			data-high-temperature="${viewModel.high}"
			data-low-temperature="${viewModel.low}" 
			data-description="${viewModel.description}"
			data-icon-name="${viewModel.iconName}">${viewModel.name}</option>
	</c:forEach> 
</select>
<p id="description"></p>
</body>
</html>