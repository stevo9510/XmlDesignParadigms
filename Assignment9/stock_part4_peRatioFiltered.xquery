xquery version "1.0";

(:
4. List all the stock items that have a PE ratio (pe_ratio) of 20 or greater 
:)

for $stock in doc("stock.xml")/portfolio/stock
order by $stock/pe_ratio
return <stock name="{data($stock/sName)}" pe_ratio="{data($stock/pe_ratio)}"/>