<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="4.0" />
	<xsl:template match="/">
	   <html>
	   <head>
			<title>SkyWeb Movie Store</title>
			<link href="movie.css" rel="stylesheet" type="text/css" />
	   </head>
	   <body>
			<h1 id="logo"><img src="skyweb.jpg" alt="SkyWeb" /></h1>
			<br /><br />
			<h1>Hot Movies Collection</h1>
			<xsl:apply-templates select="movies/movie">
				<xsl:sort select="@id"/>
			</xsl:apply-templates>
	   </body>
	   </html>
	</xsl:template>
	<xsl:template match="movie">
		<div>
			<h2><xsl:value-of select="name"/> (<xsl:value-of select="@id"/>)</h2>
			<xsl:apply-templates select="@id"/>	
			<xsl:apply-templates select="description"/>
			<br/>
			<xsl:apply-templates select="data"/>
		</div>
	</xsl:template>
	<xsl:template match="@id">
		<p><img src="{.}.jpg"/></p>
	</xsl:template>
	<xsl:template match="data">
		<table style="border-style: solid;  border-width: 5px; background-color: white; border-top-color: white; border-left-color: white; border-right-color: gray; border-bottom-color: gray;">
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
	<xsl:template match="description">
		<xsl:copy-of select="."/>
	</xsl:template>
	<xsl:template match="length|rating|release|language|genre">
		<td style="border-top: solid; border-left: solid; border-color: gray; border-width: 1px;">
			<xsl:value-of select="."/>
		</td>
	</xsl:template>
</xsl:stylesheet>