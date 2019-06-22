xquery version "1.0";

(:
2. Write a query to display all of the motels which have Wi-Fi, a business center, and a gym and for
which the median price is less than $120 and the motel rating is 3 or greater.
:)

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

