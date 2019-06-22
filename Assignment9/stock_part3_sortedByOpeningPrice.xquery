xquery version "1.0";
(:
3. List all the stock items sorted by opening price 
:)

for $stock in doc("stock.xml")/portfolio/stock
order by $stock/today/@open
return <stock name="{data($stock/sName)}" open="{data($stock/today/@open)}"/>

