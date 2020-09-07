<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ib="http://www.ofd-hannover.la/Identifikation" version="1.0">
    <xsl:output method="xml" indent="yes"/>

<xsl:template match="/">
<TRANSFER xmlns="http://www.interlis.ch/INTERLIS2.3">
    <HEADERSECTION VERSION="2.3" SENDER="">
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
        <DSS_2015.Siedlungsentwaesserung>
            <!-- Knoten -->
            <xsl:apply-templates select = "//ib:AbwassertechnischeAnlage[ib:Objektart='1']" />

            <!-- Leitungen -->
            <xsl:apply-templates select = "//ib:AbwassertechnischeAnlage[ib:Objektart='1']" />


        </DSS_2015.Siedlungsentwaesserung>
    </DATASECTION>
</TRANSFER>
</xsl:template>

    <!-- Knoten -->
<xsl:template match="//ib:AbwassertechnischeAnlage[ib:Objektart=1]">
      <DSS_2015.Siedlungsentwaesserung.Normschacht>
          <xsl:attribute name="TID">
	        <xsl:value-of select="ib:Objektbezeichnung"/>
          </xsl:attribute>

        <OBJ_ID><xsl:value-of select="ib:Objektbezeichnung"/></OBJ_ID>
        <Bezeichnung><xsl:value-of select="ib:Objektbezeichnung"/></Bezeichnung>
        <Standortname><xsl:value-of select="ib:Lage/ib:Strassenname"/></Standortname>
        <Status>
            <xsl:choose>
                <xsl:when test="ib:Status=0">in Betrieb</xsl:when>
                <xsl:when test="ib:Status=1">geplant</xsl:when>
                <xsl:when test="ib:Status=2">fiktiv</xsl:when>
                <xsl:when test="ib:Status=3">außer Betrieb, Stilllegung</xsl:when>
                <xsl:when test="ib:Status=4">verdämmt / verfüllt</xsl:when>
                <xsl:when test="ib:Status=5">Sonstige</xsl:when>
                <xsl:when test="ib:Status=6">rückgebaut</xsl:when>
                <xsl:otherwise>andere</xsl:otherwise>
            </xsl:choose>
        </Status>
        <Dimension1>600</Dimension1>
        <Funktion>Schlammsammler</Funktion>
        <Material>Beton</Material>
      </DSS_2015.Siedlungsentwaesserung.Normschacht>
</xsl:template>


</xsl:transform>