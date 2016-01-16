<?xml version="1.0"?>

<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:str="http://exslt.org/strings"
xmlns:xi="http://www.w3.org/2001/XInclude"
extension-element-prefixes="str">

  <xi:include href="tpl_sanitize.xsl" />

  <xsl:output method="text"/>

  <xsl:template match="/">
  {
    "entries":[
    <xsl:for-each select="//li[@class='visual-item']">
    {
      "title":"<xsl:call-template name="tpl_sanitize"><xsl:with-param name="text" select=".//a[2]" /></xsl:call-template>",
      "image_url":"<xsl:value-of select=".//img/@src"/>"
    }<xsl:if test="position()!=last()">,</xsl:if>
    </xsl:for-each>
    ]
  }
  </xsl:template>
</xsl:stylesheet>