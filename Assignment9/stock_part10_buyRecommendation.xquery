xquery version "1.0";
(:
10. Make a "BUY" recommendation on all the stocks where the current price is less than the opening
price 
:)

<buy> {
	for $stock in doc("stock.xml")//stock
	let $name := data($stock/sName)
	where $stock/today/@current < $stock/today/@open
	order by $name
	return <stock>{$name}</stock>
} </buy>
              