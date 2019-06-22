xquery version "1.0";
(:
9. List all the stock items that contains the word "technology" in the description 
:)

for $stock in doc("stock.xml")//stock
where $stock/description[contains(., "technology")]
return <stock>{$stock/sName}</stock>

