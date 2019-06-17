<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version='1.0' xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="4.0"/>
	<xsl:template match="/">
		<html>
			<head>
				<title>Election Night Results</title>
				<link href="polls.css" rel="stylesheet" type="text/css"/>
			</head>
			<body>
				<div id="intro">
					<p>
						<img src="logo.jpg" alt="Election Day Results"/>
					</p>
					<a href="#">Election Home Page</a>
					<a href="#">President</a>
					<a href="#">Senate Races</a>
					<a href="#">Congressional Races</a>
					<a href="#">State Senate</a>
					<a href="#">State House</a>
					<a href="#">Local Races</a>
					<a href="#">Judicial</a>
					<a href="#">Referendums</a>
				</div>
				<div id="results">
					<h1>Congressional Races</h1>
					<xsl:apply-templates select="polls/race">
						<xsl:sort select="title"/>
					</xsl:apply-templates>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="race">
		<h2>
			<xsl:value-of select="title"/>
		</h2>
		<table>
			<thead>
				<tr>
					<th>Candidate</th>
					<th class="num">Votes</th>
				</tr>
			</thead>
			<tbody>
				<xsl:variable name="totalVotesVariable" select="sum(candidate/votes)"/>
				<xsl:for-each select="candidate">
					<xsl:call-template name="candidate_results">
						<xsl:with-param name="totalVotes" select="$totalVotesVariable"/>
					</xsl:call-template>
				</xsl:for-each>
			</tbody>
		</table>
	</xsl:template>
	<xsl:template name="candidate_results">
		<xsl:param name="totalVotes"/>
		<xsl:variable name="percentage" select="round((votes div $totalVotes) * 100)"/>
		<tr>
			<td>
				<xsl:value-of select="name"/> (<xsl:value-of select="party"/>)</td>
			<td class="num">
				<!-- Note: Chose not to use format-number for percentage because it will get the floor value, which is not desirable.  In addition, the percentage variable is more reusable. -->				
				<xsl:value-of select="format-number(votes, '#,###')"/> (<xsl:value-of select="$percentage"/>%) 
			</td>
			<xsl:call-template name="showBar">
				<xsl:with-param name="color">
					<xsl:choose>
						<xsl:when test="party='D'">blue</xsl:when>			
						<xsl:when test="party='R'">red</xsl:when>
						<xsl:otherwise>green</xsl:otherwise>
					</xsl:choose>					
				</xsl:with-param>
				<xsl:with-param name="barCount" select="$percentage"/>
			</xsl:call-template>				
		</tr>
	</xsl:template>
	<xsl:template name="showBar">
		<xsl:param name="color"/>
		<xsl:param name="barCount"/>

		<xsl:if test="$barCount>1">			
			<xsl:call-template name="showBar">
				<xsl:with-param name="color" select="$color"/>
				<xsl:with-param name="barCount" select="$barCount - 1"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:element name="td">			
			<xsl:attribute name="class">
				<xsl:value-of select="$color"/>
			</xsl:attribute>
		</xsl:element>
	</xsl:template>
</xsl:stylesheet>
