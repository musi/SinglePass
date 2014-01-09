<?xml version="1.0"?>

<!-- ================================================================= -->
<!-- Content Stylesheet derived from the documentation system of       -->
<!-- http://jakarta.apache.org/site/jakarta-site2.html                 -->
<!-- Customized and extended by whoschek@lbl.gov                       -->
<!-- $Id: style.xsl,v 1.2 2004/02/25 23:48:17 hoschek3 Exp $          -->
<!-- ================================================================= -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!-- Output method -->
	<xsl:output method="html" encoding="iso-8859-1" indent="no"/>
	
	<!-- Defined parameters (overrideable) -->
	<xsl:param name="relative-path" select="'.'"/>
	
	<!-- Defined variables (non-overrideable) -->
	<xsl:variable name="header-bg" select="'#ffffff'"/>	<!-- #ffff99 -->
	<xsl:variable name="body-bg" select="'#ffffff'"/>
	<xsl:variable name="body-fg" select="'#000000'"/>
	<xsl:variable name="body-link" select="'#525D76'"/>
	<xsl:variable name="banner-bg" select="'#525D76'"/>
	<xsl:variable name="banner-fg" select="'#ffffff'"/>
	<xsl:variable name="sub-banner-bg" select="'#828DA6'"/>
	<xsl:variable name="sub-banner-fg" select="'#ffffff'"/>
	<xsl:variable name="table-th-bg" select="'#039acc'"/>
	<xsl:variable name="table-td-bg" select="'#a0ddf0'"/>
	<xsl:variable name="source-color" select="'#ffff99'"/> <!-- #023264 -->
	<xsl:variable name="toplinkitem-color" select="'#3366ff'"/> <!--"'#3366ff'" --> <!-- #3300ff -->
		
	<!-- Process an entire document into an HTML page -->
	<xsl:template match="document">
		<xsl:comment>Do not edit this autogenerated HTML file; edit src/xdocs files instead. </xsl:comment>
		<xsl:variable name="project" select="document('navigation.xml')/project"/>
		<html>
			<head>
				<xsl:if test="$project/@css">
					<style type="text/css"> @import url("<xsl:value-of select="$project/@css"/>"); </style>
				</xsl:if>
				<xsl:apply-templates select="meta"/>
				<title>
					<xsl:value-of select="$project/title"/> - <xsl:value-of select="properties/title"/>
				</title>
				<xsl:for-each select="properties/author">
					<xsl:variable name="name">
						<xsl:value-of select="."/>
					</xsl:variable>
					<xsl:variable name="email">
						<xsl:value-of select="@email"/>
					</xsl:variable>
					<meta name="author" content="{$name}"/>
					<meta name="email" content="{$email}"/>
				</xsl:for-each>
			</head>
			<body bgcolor="{$body-bg}" text="{$body-fg}" link="{$body-link}" alink="{$body-link}" vlink="{$body-link}">
				<xsl:comment>HEADER</xsl:comment>
				<table border="0" width="100%" cellspacing="0" bgcolor="{$header-bg}">
					<tr>
							<td width="33%" align="left">
								<xsl:apply-templates select="$project/header/left/*|$project/header/left/text()"/>
							</td>
							<td width="33%" align="center">
								<xsl:apply-templates select="$project/header/center/*|$project/header/center/text()"/>
							</td>
							<td width="33%" align="right">
								<xsl:apply-templates select="$project/header/right/*|$project/header/right/text()"/>
							</td>
					</tr>
				</table>
				
				<!--  
				<hr noshade="noshade" size="1"/>
				-->
					
				<xsl:comment>TOP LINK MENU NAVIGATION</xsl:comment>
				<xsl:apply-templates select="$project/body/links"/>
				
				<table border="0" width="100%" cellspacing="4">
					<tr>
						<xsl:comment>LEFT SIDE NAVIGATION</xsl:comment>
						<td valign="top" align="left" nowrap="nowrap" class="leftcol">
							<xsl:apply-templates select="$project/body/menu|$project/body/menuSeparator"/>
						</td>
						<xsl:comment>LEFT SIDE SUBNAVIGATION</xsl:comment>

						<xsl:if test="body/menu">
							<td align="left" valign="top" nowrap="nowrap" class="leftcol">
									<xsl:apply-templates select="body/menu|body/menuSeparator"/>
							</td>
						</xsl:if>
						
						<xsl:comment>RIGHT SIDE MAIN BODY</xsl:comment>
						<td align="left" valign="top">
							<xsl:apply-templates select="body/section"/>
						</td>
						<xsl:comment>RIGHT SIDE NAVIGATION</xsl:comment>
						<xsl:if test="$project/rightbody/menu">
							<td valign="top" nowrap="nowrap">
								<xsl:apply-templates select="$project/rightbody/menu|$project/rightbody/menuSeparator"/>
							</td>
						</xsl:if>
					</tr>
				</table>
				
				<xsl:comment>FOOTER SEPARATOR</xsl:comment>
				<hr noshade="noshade" size="1"/>

				<xsl:comment>FOOTER</xsl:comment>
				<table border="0" width="100%" cellspacing="0" bgcolor="{$header-bg}">
					<tr>
						<td width="33%" align="left">
							<xsl:apply-templates select="$project/footer/left/*|$project/footer/left/text()"/>
						</td>
						<td width="33%" align="center">
							<xsl:apply-templates select="$project/footer/center/*|$project/footer/center/text()"/>
						</td>
						<td width="33%" align="right">
							<xsl:apply-templates select="$project/footer/right/*|$project/footer/right/text()"/>
						</td>
					</tr>
				</table>
			</body>
		</html>
	</xsl:template>
	
	<!-- Process a menu for the navigation bar -->
	<xsl:template match="menu">
		<div class="frame item">
			<div class="name">
				<xsl:value-of select="@name"/>
			</div>
			<div class="content">
				<xsl:apply-templates select="item"/>
			</div>
		</div>
	</xsl:template>
	
	<!-- Process a menuSeparator for the navigation bar -->
	<xsl:template match="menuSeparator">
		<p></p>
	</xsl:template>
	
	<!-- Process a menu item for the navigation bar -->
	<xsl:template match="item">
		<xsl:choose>
			<xsl:when test="@name = 'GoogleSearch'">
				<form action="http://www.google.com/search" method="get">
					<!-- <input type="submit" value="Search"/> -->
					<input type="hidden" name="as_sitesearch">
						<xsl:attribute name="value">
							<xsl:value-of select="@href"/>
						</xsl:attribute>
					</input>
					<input type="text" value="" size="13" maxLength="256" name="as_q"/>
				</form>
			</xsl:when>
			<xsl:when test="@name = 'hr'">
				<hr noshade="noshade" size="1"/>
			</xsl:when>
			<xsl:when test="@href">
				<xsl:variable name="href">
					<xsl:choose>
						<xsl:when test="starts-with(@href, 'http://')">
							<xsl:value-of select="@href"/>
						</xsl:when>
						<xsl:when test="starts-with(@href, 'https://')">
							<xsl:value-of select="@href"/>
						</xsl:when>
						<xsl:when test="starts-with(@href, '/site')">
							<xsl:text>http://jakarta.apache.org</xsl:text>
							<xsl:value-of select="@href"/>
						</xsl:when>
						<xsl:when test="starts-with(@href, '#')">
							<xsl:value-of select="@href"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$relative-path"/>
							<xsl:value-of select="@href"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<a href="{$href}">
					<xsl:value-of select="@name"/>
				</a>
				<!-- 
				<br/>
				-->
			</xsl:when>
			<xsl:otherwise>
				<div>
					<xsl:value-of select="@name"/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="subitem"/>
	</xsl:template>
	
	<!-- Process a menu item for the navigation bar -->
	<xsl:template match="subitem">
		<xsl:choose>
			<xsl:when test="@name = 'hr'">
				<hr noshade="noshade" size="1"/>
			</xsl:when>
			<xsl:when test="@href">
				<xsl:variable name="href">
					<xsl:choose>
						<xsl:when test="starts-with(@href, 'http://')">
							<xsl:value-of select="@href"/>
						</xsl:when>
						<xsl:when test="starts-with(@href, 'https://')">
							<xsl:value-of select="@href"/>
						</xsl:when>
						<xsl:when test="starts-with(@href, '/site')">
							<xsl:text>http://jakarta.apache.org</xsl:text>
							<xsl:value-of select="@href"/>
						</xsl:when>
						<xsl:when test="starts-with(@href, '#')">
							<xsl:value-of select="@href"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$relative-path"/>
							<xsl:value-of select="@href"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:variable>
				<!-- 
				<br/>
				-->
				<a href="{$href}">
				&#160;&#160;&#160;&#160;-
					<xsl:value-of select="@name"/>
				</a>
			</xsl:when>
			<xsl:otherwise>
				<div>
				&#160;&#160;&#160;&#160;-
				<xsl:value-of select="@name"/>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Process top link menu navigation bar -->
	<xsl:template match="links">
		<div class="link">
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr valign="baseline" >
					<td align="left">
						<xsl:for-each select="item">
							<xsl:call-template name="linkitem"/>
						</xsl:for-each>
					</td>
					<td align="right">
						<xsl:if test="@currentVersion"> Version <xsl:value-of
							select="@currentVersion"/> - </xsl:if>
						<xsl:if test="@lastPublished"> Last published <xsl:value-of select="@lastPublished"/>
						</xsl:if>
					</td>
				</tr>
			</table>
		</div>
	</xsl:template>
	
	<!-- Process a topmenu item for the top navigation bar -->
	<xsl:template name="linkitem">
		<xsl:variable name="href">
			<xsl:choose>
				<xsl:when test="starts-with(@href, 'http://')">
					<xsl:value-of select="@href"/>
				</xsl:when>
				<xsl:when test="starts-with(@href, '/site')">
					<xsl:text>http://jakarta.apache.org</xsl:text>
					<xsl:value-of select="@href"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$relative-path"/>
					<xsl:value-of select="@href"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<a href="{$href}">
			<xsl:attribute name="title">Click to jump to <xsl:value-of select="@name"/>
			</xsl:attribute>
			<font color="{$toplinkitem-color}">
				<xsl:value-of select="@name"/>
			</font>
		</a> 
	</xsl:template>
		
	<!-- Process a documentation section -->
	<xsl:template match="section">
		<xsl:variable name="name">
			<xsl:value-of select="@name"/>
		</xsl:variable>
		<table border="0" cellspacing="0" cellpadding="2" width="100%">
			<!-- Section heading -->
			<tr>
				<td bgcolor="{$banner-bg}">
					<font color="{$banner-fg}" face="arial,helvetica.sanserif">
						<a name="{$name}">
							<strong>
								<xsl:value-of select="@name"/>
							</strong>
						</a>
					</font>
				</td>
			</tr>
			<!-- Section body -->
			<tr>
				<td>
					<blockquote>
						<xsl:apply-templates/>
					</blockquote>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<!-- Process a documentation subsection -->
	<xsl:template match="subsection">
		<xsl:variable name="name">
			<xsl:value-of select="@name"/>
		</xsl:variable>
		<table border="0" cellspacing="0" cellpadding="2" width="100%">
			<!-- Subsection heading -->
			<tr>
				<td bgcolor="{$sub-banner-bg}">
					<font color="{$sub-banner-fg}" face="arial,helvetica.sanserif">
						<a name="{$name}">
							<strong>
								<xsl:value-of select="@name"/>
							</strong>
						</a>
					</font>
				</td>
			</tr>
			<!-- Subsection body -->
			<tr>
				<td>
					<blockquote>
						<xsl:apply-templates/>
					</blockquote>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<!-- process a note element -->
	<xsl:template match="note">
		<xsl:variable name="name">
			<xsl:value-of select="@name"/>
		</xsl:variable>
		<div class="frame note">
			<div class="name">
				<a name="{$name}">
					<xsl:value-of select="@name"/>
				</a>
			</div>
			<div class="content">
				<xsl:apply-templates/>
			</div>
		</div>
	</xsl:template>
	
	<!-- process a warning element -->
	<xsl:template match="warning">
		<div class="frame warning">
			<div class="name">
				<xsl:value-of select="@name"/>
			</div>
			<div class="content">
				<xsl:apply-templates/>
			</div>
		</div>
	</xsl:template>
	
	<!-- process a fixme element -->
	<xsl:template match="fixme">
		<div class="frame fixme">
			<div class="name">
				<xsl:value-of select="@name"/>
			</div>
			<div class="content">
				<xsl:apply-templates/>
			</div>
		</div>
	</xsl:template>
	
	<!-- process a listing element -->
	<xsl:template match="listing">
		<xsl:variable name="name">
			<xsl:value-of select="@name"/>
		</xsl:variable>
		<div class="frame listing">
			<div class="name">
				<a name="{$name}">
					<xsl:value-of select="@name"/>
				</a>
			</div>
			<div class="listingcontent">
				<xsl:apply-templates/>
			</div>
		</div>
	</xsl:template>
	
	<!-- different color for even and odd table rows trx -->
	<xsl:template match="xtbody">
		<xsl:for-each select="tr">
			<tr valign="top">
				  <xsl:attribute name="class">
					 <xsl:choose>
					  <xsl:when test="position() mod 2 = 1">table rowodd</xsl:when>
					  <xsl:otherwise>table roweven</xsl:otherwise>
					</xsl:choose>
				  </xsl:attribute>
				  <xsl:apply-templates />
			</tr>
		</xsl:for-each>
	</xsl:template>

	<!-- handle th ala site.vsl -->
	<xsl:template match="xth">
		<td class="table header" valign="top">
			<xsl:if test="@colspan">
				<xsl:attribute name="colspan">
					<xsl:value-of select="@colspan"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@rowspan">
				<xsl:attribute name="rowspan">
					<xsl:value-of select="@rowspan"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</td>
	</xsl:template>
	
	<!-- handle td ala site.vsl -->
	<xsl:template match="td">
		<td class="table row" valign="top">
			<xsl:if test="@colspan">
				<xsl:attribute name="colspan">
					<xsl:value-of select="@colspan"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="@rowspan">
				<xsl:attribute name="rowspan">
					<xsl:value-of select="@rowspan"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</td>
	</xsl:template>
	

	<!-- Process everything else by just passing it through -->
	<xsl:template match="*|@*">
		<xsl:copy>
			<xsl:apply-templates select="@*|*|text()"/>
		</xsl:copy>
	</xsl:template>
	

	<!-- process a xsource element -->
	<!--
		<xsl:template match="xsource">
			<div class="frame xsource">
				<xsl:if test="@name">
					<div class="name">
						<xsl:value-of select="@name"/>
					</div>
				</xsl:if>
				<div class="content">
					<pre>
						<xsl:apply-templates/>
					</pre>
				</div>
			</div>
		</xsl:template>
	-->
	

	<!-- Process a source code example -->
	<!--
		<xsl:template match="source">
			<div align="left">
				<table cellspacing="4" cellpadding="0" border="0">
					<tr>
						<td bgcolor="{$source-color}" width="1" height="1">
							<img src="/images/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
						</td>
						<td bgcolor="{$source-color}" height="1">
							<img src="/images/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
						</td>
						<td bgcolor="{$source-color}" width="1" height="1">
							<img src="/images/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
						</td>
					</tr>
					<tr>
						<td bgcolor="{$source-color}" width="1">
							<img src="/images/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
						</td>
						<td bgcolor="#ffffff" height="1">
							<pre>
								<xsl:value-of select="."/>
							</pre>
						</td>
						<td bgcolor="{$source-color}" width="1">
							<img src="/images/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
						</td>
					</tr>
					<tr>
						<td bgcolor="{$source-color}" width="1" height="1">
							<img src="/images/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
						</td>
						<td bgcolor="{$source-color}" height="1">
							<img src="/images/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
						</td>
						<td bgcolor="{$source-color}" width="1" height="1">
							<img src="/images/void.gif" width="1" height="1" vspace="0" hspace="0" border="0"/>
						</td>
					</tr>
				</table>
			</div>
		</xsl:template>
	-->	
</xsl:stylesheet>
