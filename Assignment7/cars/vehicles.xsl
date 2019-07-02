<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<html>
			<head>
				<title>Used Vehicles</title>
				<style>
					<!--Give table some border styling to look like the assignment example (very similar look in Chromium engine)-->
					table { border: 2px outset; }
					td, th { border: 1px inset; }
				</style>
			</head>
			<body background="money.jpg">
				<h1 style="background-color:#446600;color:#FFFFFF; font-size:20pt; text-align:center;letter-spacing: 12pt">Used Vehicles</h1>

				<!--Create main table-->
				<table align="center">
					<thead>
						<!--Bold the header-->
						<tr style="font-weight: bold;">
							<th>Year</th>
							<th>Make</th>
							<th>Model</th>
							<th>Mileage</th>
							<th>Color</th>
							<th>Price</th>
							<th>CARFAX</th>
						</tr>
					</thead>
					<tbody>
						<!--List the cars in ascending order (sorting by price)-->
						<xsl:apply-templates select="vehicles/vehicle">
							<xsl:sort select="price"/>
						</xsl:apply-templates>
					</tbody>
					<tfoot>
						<tr style="font-weight: bold;">
							<td style="border: 0;" colspan="3"/>
							<td colspan="2">Average price:</td>
							<!-- Finally, display the average price of the cars -->
							<td>$<xsl:value-of select="round(sum(vehicles/vehicle/price) div count(vehicles/vehicle))"/>
							</td>
						</tr>
					</tfoot>
				</table>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="vehicle">
		<xsl:element name="tr">
			<!--Cars with less than 20000 miles and a buy-back guarantee should get displayed in BOLD GREEN
				Dynamically add a css style attribute to the <tr> if this is the case.
			-->
			<xsl:if test="mileage &lt; 20000 and carfax/@buyback = 'yes'">
				<xsl:attribute name="style">
					font-weight:bold; color:green;
				</xsl:attribute>
			</xsl:if>
			<!--Draw the cells in the table-->
			<xsl:apply-templates select="@year"/>
			<xsl:apply-templates select="@make"/>
			<xsl:apply-templates select="@model"/>
			<xsl:apply-templates select="mileage"/>
			<xsl:apply-templates select="color"/>
			<xsl:apply-templates select="price"/>
			<xsl:apply-templates select="carfax"/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="@year|@make|@model|mileage|price">
		<td>
			<xsl:value-of select="."/>
		</td>
	</xsl:template>
	<!--Display the actual color instead of the color in text.-->
	<xsl:template match="color">
		<td bgcolor="{.}"/>
	</xsl:template>
	<xsl:template match="price">
		<td>$<xsl:value-of select="."/>
		</td>
	</xsl:template>
	<!--For cars with CarFax buy back guarantee, display the image -->
	<xsl:template match="carfax">
		<xsl:if test="@buyback = 'yes'">
			<td align="center">
				<img src="checkmark.gif"/>
			</td>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
