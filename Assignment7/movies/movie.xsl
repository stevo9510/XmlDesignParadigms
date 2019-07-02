<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="4.0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>SkyWeb Movie Store</title>
				<!--Add some additional styling and borders to the tables to make them look similar to the assignment screenshot-->
				<style>
					table { border-style: solid; border-width: 5px; background-color: white; border-top-color: white; border-left-color: white; border-right-color: gray; border-bottom-color: gray; }
					td { border-top: solid; border-left: solid; border-color: gray; border-width: 1px; }
					p { padding-right: 15px; font-size: 11pt; }
				</style>
				<link href="movie.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>
				<h1 id="logo">
					<img src="skyweb.jpg" alt="SkyWeb"/>
				</h1>
				<br/>
				<br/>
				<h1>Hot Movies Collection</h1>
				<!--Sort the movies in order by id-->
				<xsl:apply-templates select="movies/movie">
					<xsl:sort select="@id"/>
				</xsl:apply-templates>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="movie">
		<div>
			<!--Create the header for each movie (show the name and id in paranthesis)-->
			<h2>
				<xsl:value-of select="name"/> (<xsl:value-of select="@id"/>)</h2>
			<xsl:apply-templates select="@id"/>
			<xsl:apply-templates select="description/p"/>
			<br/>
			<br/>
			<xsl:apply-templates select="data"/>
		</div>
	</xsl:template>
	<xsl:template match="@id">
		<!--Use the id to match the source of the image-->
		<p>
			<img src="{.}.jpg"/>
		</p>
	</xsl:template>
	<xsl:template match="data">
		<!--Create the main table for the movies.  One header row and one data row.-->
		<table>
			<thead>
				<tr>
					<th>Length</th>
					<th>Rating</th>
					<th>Release</th>
					<th>Language</th>
					<th>Genre</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<xsl:apply-templates select="length"/>
					<xsl:apply-templates select="rating"/>
					<xsl:apply-templates select="release"/>
					<xsl:apply-templates select="language"/>
					<xsl:apply-templates select="genre"/>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template match="p">
		<!--Copy the paragraph text to keep the p tag-->
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="length|rating|release|language|genre">
		<td>
			<xsl:value-of select="."/>
		</td>
	</xsl:template>
</xsl:stylesheet>
