xquery version "1.0";

(:
2. List all the stock items that opened at $30 or higher 
:)

for $stock in doc("stock.xml")/portfolio/stock
where $stock/today/@open >= 30.0
order by $stock/sName
return <stock name="{data($stock/sName)}" open="{data($stock/today/@open)}"/>

