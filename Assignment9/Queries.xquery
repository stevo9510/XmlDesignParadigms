xquery version "3.0";

declare namespace ext="http://www.altova.com/xslt-extensions";


(:
doc("stock.xml")/portfolio/stock/sName

:)

(:

for $x in doc("stock.xml")/portfolio/stock
where $x/today/@open >= 30.0
order by $x/sName
return <stock name="{data($x/sName)}" open="{data($x/today/@open)}"/>
:)


(:
for $x in doc("stock.xml")/portfolio/stock
order by $x/today/@open
return <stock name="{data($x/sName)}" open="{data($x/today/@open)}"/>

:)

(:
for $x in doc("stock.xml")/portfolio/stock
order by $x/pe_ratio
return <stock name="{data($x/sName)}" pe_ratio="{data($x/pe_ratio)}"/>
:)

(:
for $x in doc("stock.xml")/portfolio/stock
where data($x/category) = 'Industrials'
return $x
:)

(:
<ul> {
for $x in doc("stock.xml")//stock
where $x/today/@current < 30.0
order by data($x/sName)
return <li>{data($x/sName)} </li>
} </ul>

:)

(:
<html> 
	<h1>Stock List</h1>
	<ul>
		{
		for $x in doc("stock.xml")//stock
		return <li>Name: {data($x/sName)}, Symbol: {data($x/sName/@symbol)} </li>				
} </ul> 
</html>
:)

(:
Note: This only works with Xquery 3.0.  Is that okay?
for $x in doc("stock.xml")//stock
group by $d := data($x/category)
order by $d
return <department name="{$d}" totQuantity="{sum($x/earnings)}"/>
:)       
              

(:
for $x in doc("stock.xml")//stock
where $x/description[contains(., "technology")]
return <stock>{$x/sName}</stock>
:)

<buy> {
	for $x in doc("stock.xml")//stock
	let $s := data($x/sName)
	where $x/today/@current < $x/today/@open
	order by $s
	return <stock>{$s}</stock>
} </buy>
              