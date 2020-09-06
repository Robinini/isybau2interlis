<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/>

<xsl:template match="/persons">
<TRANSFER xmlns="http://www.interlis.ch/INTERLIS2.3">
    <HEADERSECTION VERSION="2.3" SENDER="Geozug Ingenieure AG">
        <MODELS>
            <MODEL NAME="DSS_2015" VERSION="4.6.2017" URI="http://www.vsa.ch/models"/>
        </MODELS>
    <ALIAS>
      <ENTRIES FOR="DSS_2015">
          <TAGENTRY FROM="DSS_2015.Siedlungsentwaesserung" TO="DSS_2015.Siedlungsentwaesserung"/>
      </ENTRIES>
    </ALIAS>
    </HEADERSECTION>
    <DATASECTION>
        <h1>Persons</h1>
        <ul>
          <xsl:apply-templates select="person">
            <xsl:sort select="family-name" />
          </xsl:apply-templates>
        </ul>
    </DATASECTION>
</TRANSFER>
</xsl:template>

<xsl:template match="person">
    <li>
      <xsl:value-of select="family-name"/><xsl:text>, </xsl:text><xsl:value-of select="name"/>
    </li>
</xsl:template>


</xsl:stylesheet>