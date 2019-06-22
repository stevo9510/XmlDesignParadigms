xquery version "1.0";
(:
8. Aggregate the earnings for all the stock items based on the (distinct) category 
:)

for $cat in distinct-values(doc("stock.xml")//stock/category)
let $catStocks := doc("stock.xml")//stock[category = $cat]
return <department name="{$cat}" totQuantity="{sum($catStocks/earnings)}"/>