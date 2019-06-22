xquery version "1.0";

(:
3. Write a query that display motels which have a pool, free breakfast, allow for pets and for which
the low-end price is $90 or less and the average customer rating is 3 or greater.
:)

<results> {
	for $motel in doc("motels.xml")//motel
	let $customers := doc("customers.xml")//motel[@motelID = $motel/@motelID]
	let $avgRating := avg($customers/@customerRating)
	let $lowPrice := doc("prices.xml")//motel[@motelID = $motel/@motelID]/low
	let $amenities := doc("amenities.xml")//motel[@motelID = $motel/@motelID]
	where $amenities/pool = 'yes'
		and $amenities/free_breakfast = 'yes'
		and $amenities/pets_allowed = 'yes'		
		and $lowPrice <= 90
		and $avgRating >= 3
	order by $lowPrice
	return <motel id="{$motel/@motelID}" title="{$motel/title}" price="{$lowPrice}" customerRating="{round-half-to-even($avgRating, 2)}">
		{element{"contact"} { $motel/node() except $motel/title}}
		{element{"amenities"} { $amenities/node() except $amenities/rating}}
	</motel>
} </results>


