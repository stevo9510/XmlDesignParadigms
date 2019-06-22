xquery version "1.0";

(:
6. List all the stock items (stock name only) as a HTML List items where the current price is lesser
than 30.
:)

<ul> {
for $stock in doc("stock.xml")//stock
where $stock/today/@current < 30.0
order by data($stock/sName)
return <li>{data($stock/sName)} </li>
} </ul>
