xquery version "1.0";

(:
1. Write a query to display contact information, amenities, motel ratings and average customer
rating for every motel listed in the data file. Sort the query results by the motel ratings in a
descending order. 

Questions: 
1. What should the secondary sort be for this?!?  Chose an arbitrary one to match the example
2. Is Round-half-to-even OK?  

:)

<results> {
	for $motel in doc("motels.xml")//motel
	let $customers := doc("customers.xml")//motel[@motelID = $motel/@motelID]
	let $avgRating := avg($customers/@customerRating)
	let $amenities := doc("amenities.xml")//motel[@motelID = $motel/@motelID]
	order by $amenities/rating descending,
		$motel/title descending
	return <motel id="{$motel/@motelID}" title="{$motel/title}">
		{element{"contact"} { $motel/node() except $motel/title}}
		<class> 
			{$amenities/rating}
			<avgCustomerRating>{round-half-to-even($avgRating, 2)}</avgCustomerRating>
		</class>
		{element{"amenities"} { $amenities/node() except $amenities/rating}}
	</motel>
} </results>