xquery version "3.1";

(:
for $motel in doc("motels.xml")//motel,
    $amenities in doc("amenities.xml")//motel,
    $customers in doc("customers.xml")//motel
group by $customers 
where $motel/@motelID = $amenities/@motelID
	 and $amenities/@motelID = $customers/@motelID
return avg($customers/@customerRating)

:)

(:

Questions: 
1. What should the secondary sort be for this?!?  Chose an arbitrary one to match the example
2. Is Round-half-to-even OK?  
:)
(:
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
:)
(:

Write a query to display all of the motels which have Wi-Fi, a business center, and a gym and for
which the median price is less than $120 and the motel rating is 3 or greater.

:)

(:
<results> {
	for $motel in doc("motels.xml")//motel
	let $medianPrice := doc("prices.xml")//motel[@motelID = $motel/@motelID]/median
	let $amenities := doc("amenities.xml")//motel[@motelID = $motel/@motelID]
	where $amenities/wifi = 'yes'
		and $amenities/business_center = 'yes'
		and $amenities/gym = 'yes'		
		and $medianPrice < 120
		and $amenities/rating >= 3
	order by $medianPrice
	return <motel id="{$motel/@motelID}" title="{$motel/title}" price="{$medianPrice}" rating="{$amenities/rating}">
		{element{"contact"} { $motel/node() except $motel/title}}
		{element{"amenities"} { $amenities/node() except $amenities/rating}}
	</motel>
} </results>

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


