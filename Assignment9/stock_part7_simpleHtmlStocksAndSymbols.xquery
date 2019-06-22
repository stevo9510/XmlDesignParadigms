xquery version "1.0";

(:
7. Create a simple HTML output that lists stock names and symbols 
:)

<html> 
	<h1>Stock List</h1>
	<ul>
		{
		for $stock in doc("stock.xml")//stock
		return <li>Name: {data($stock/sName)}, Symbol: {data($stock/sName/@symbol)} </li>				
} </ul> 
</html>