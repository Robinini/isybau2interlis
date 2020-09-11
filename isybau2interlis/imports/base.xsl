<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ib="http://www.ofd-hannover.la/Identifikation" version="1.0">
    <xsl:output method="xml" indent="yes"/>

    <!-- VSA and SIA Base Templates -->
<xsl:template name="status"><!-- not working ToDo -->
    <xsl:param name="status"/>
    <Status>
        <xsl:choose>
            <xsl:when test="$status=0">in_Betrieb</xsl:when>
            <xsl:when test="$status=1">weitere.geplant</xsl:when>
            <xsl:when test="$status=2">weitere.Berechnungsvariante</xsl:when>
            <xsl:when test="$status=3">ausser_Betrieb</xsl:when>
            <xsl:when test="$status=4">tot.verfuellt</xsl:when>
            <xsl:when test="$status=5">weitere</xsl:when>
            <xsl:when test="$status=6">weitere</xsl:when>
            <xsl:otherwise>weitere</xsl:otherwise>
        </xsl:choose>
    </Status>
</xsl:template>



</xsl:transform>