<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:ib="http://www.ofd-hannover.la/Identifikation"
               exclude-result-prefixes="ib"
               version="1.0">
    <xsl:output method="xml" indent="yes"/>

    <!-- VSA and SIA Base Templates -->
    <xsl:template name="Eigentuemer">
            <Eigentuemer>
            <xsl:choose>
                <xsl:when test="ib:Eigentum=1">Öffentlich</xsl:when>
                <xsl:when test="ib:Eigentum=2">Privat</xsl:when>
                <xsl:when test="ib:Eigentum=3">Bund</xsl:when>
                <xsl:when test="ib:Eigentum=4">Land</xsl:when>
                <xsl:when test="ib:Eigentum=5">sonstige</xsl:when>
            </xsl:choose>
        </Eigentuemer>
    </xsl:template>

    <xsl:template name="Status">
        <Status>
            <xsl:choose>
                <xsl:when test="ib:Status=0">in_Betrieb</xsl:when>
                <xsl:when test="ib:Status=1">weitere.geplant</xsl:when>
                <xsl:when test="ib:Status=2">weitere.Berechnungsvariante</xsl:when>
                <xsl:when test="ib:Status=3">ausser_Betrieb</xsl:when>
                <xsl:when test="ib:Status=4">tot.verfuellt</xsl:when>
                <xsl:when test="ib:Status=5">weitere</xsl:when>
                <xsl:when test="ib:Status=6">weitere</xsl:when>
                <xsl:otherwise>weitere</xsl:otherwise>
            </xsl:choose>
        </Status>
    </xsl:template>



</xsl:transform>