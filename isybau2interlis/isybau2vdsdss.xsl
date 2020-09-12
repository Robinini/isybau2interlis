<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:ib="http://www.ofd-hannover.la/Identifikation"
               exclude-result-prefixes="ib"
               version="1.0">
    <!-- Import XLST components -->
    <xsl:import href="imports/geometry.xsl"/>
    <xsl:import href="imports/base.xsl"/>
    <!-- Declare output XML Style -->
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/"><!-- match whole document -->
<TRANSFER xmlns="http://www.interlis.ch/INTERLIS2.3">
<HEADERSECTION SENDER="ili2fme-5.7.6-20121121" VERSION="2.3">
    <MODELS>
        <MODEL NAME="Units" VERSION="2012-02-20" URI="http://www.interlis.ch/models"/>
        <MODEL NAME="Base" VERSION="26.5.2012" URI="http://www.sia.ch/405"/>
        <MODEL NAME="SIA405_Base" VERSION="11.6.2012" URI="http://www.sia.ch/405"/>
        <MODEL NAME="VSADSSMINI_2015" VERSION="09.12.2016" URI="http://www.vsa.ch/models"/>
    </MODELS>
</HEADERSECTION>
<DATASECTION>
    <VSADSSMINI_2015.VSADSSMini BID="">
        <xsl:apply-templates select = "//ib:Identifikation/ib:Datenkollektive/ib:Stammdatenkollektiv" />
    </VSADSSMINI_2015.VSADSSMini>
</DATASECTION>
</TRANSFER>
</xsl:template>

<!-- Hide 'Kennung' tag -->
<xsl:template match="ib:Kennung"/>

<!-- Knoten -->
<xsl:template match="ib:AbwassertechnischeAnlage[ib:Objektart=2]">
    <VSADSSMINI_2015.VSADSSMini.Knoten>
        <xsl:attribute name="TID">
	        <xsl:value-of select="ib:Objektbezeichnung"/>
        </xsl:attribute>
        <OBJ_ID><xsl:value-of select="ib:Objektbezeichnung"/></OBJ_ID>
        <Baujahr><xsl:value-of select="ib:Baujahr"/></Baujahr>
        <Bemerkung><xsl:value-of select="ib:Kommentar"/></Bemerkung>
        <Betreiber/>
        <Bezeichnung><xsl:value-of select="ib:Objektbezeichnung"/></Bezeichnung>
        <Eigentuemer>
            <xsl:choose>
                <xsl:when test="ib:Eigentum=1">Öffentlich</xsl:when>
                <xsl:when test="ib:Eigentum=2">Privat</xsl:when>
                <xsl:when test="ib:Eigentum=3">Bund</xsl:when>
                <xsl:when test="ib:Eigentum=4">Land</xsl:when>
                <xsl:when test="ib:Eigentum=5">sonstige</xsl:when>
            </xsl:choose>
        </Eigentuemer>
        <Finanzierung/>
        <Sanierungsbedarf/>
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

        <!-- ToDo only <KnotenTyp>0 : Schacht and Anschlusspunkt 1 is covered. Bauwerk 2 neeed to be covered -->
        <Funktion>
            <xsl:choose>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=1">Leitungsknoten</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=1">Kontrollschacht</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=2">andere</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=3">Kontrollschacht</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=4">andere</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=5">andere</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=6">Messstelle</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=7">andere</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=8">Leitungsknoten</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=9">Regenueberlauf</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=10">Kontrollschacht</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=11">Spuelschacht</xsl:when>
                <xsl:when test="ib:Knoten/ib:KnotenTyp=0 and ib:Knoten/ib:Schacht/ib:SchachtFunktion=12">Messstelle</xsl:when>
                <xsl:otherwise>andere</xsl:otherwise>
            </xsl:choose>
        </Funktion>

        <!-- ToDO How can this be established? -->
        <FunktionHierarchisch/>

        <!-- ToDo Likely not all points identified. Risk of multiple points -->
        <Sohlenkote>
            <xsl:value-of select="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Punkthoehe"/>
        </Sohlenkote>
        <Lage>
            <COORD>
                <C1><xsl:value-of select="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Rechtswert"/></C1>
                <C2><xsl:value-of select="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Hochwert"/></C2>
            </COORD>
        </Lage>
        <Deckelkote>
            <xsl:value-of select="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='DMP']/ib:Punkthoehe"/>
        </Deckelkote>

        <!-- toDo Unsure if the accuracies are correctly converted -->
        <Lagegenauigkeit>
            <xsl:choose>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=0">plusminus_3cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=1">plusminus_50cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=2">groesser_50cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=3">plusminus_50cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=4">groesser_50cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=5">plusminus_10cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=6">plusminus_3cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=7">plusminus_10cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=8">plusminus_10cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Lagegenauigkeitsstufe=9">unbekannt</xsl:when>
                <xsl:otherwise>unbekannt</xsl:otherwise>
            </xsl:choose>
        </Lagegenauigkeit>

        <Zugaenglichkeit>
            <xsl:choose>
                <xsl:when test="ib:Lage=0">unbekannt</xsl:when>
                <xsl:when test="ib:Lage=1">unzugaenglich</xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </Zugaenglichkeit>
    </VSADSSMINI_2015.VSADSSMini.Knoten>

</xsl:template>

<!-- Leitungen -->
<xsl:template match="ib:AbwassertechnischeAnlage[ib:Objektart=1]">
    <VSADSSMINI_2015.VSADSSMini.Leitung TID="PAA_HL25">
        <xsl:attribute name="TID">
	        <xsl:value-of select="ib:Objektbezeichnung"/>
        </xsl:attribute>
        <OBJ_ID><xsl:value-of select="ib:Objektbezeichnung"/></OBJ_ID>
        <!-- xsl:call-template name="metaattribute"></xsl:call-template -->
        <Baujahr><xsl:value-of select="ib:Baujahr"/></Baujahr>
        <Bemerkung><xsl:value-of select="ib:Kommentar"/></Bemerkung>
        <Betreiber/>
        <Bezeichnung><xsl:value-of select="ib:Objektbezeichnung"/></Bezeichnung>
        <Eigentuemer>
            <xsl:choose>
                <xsl:when test="ib:Eigentum=1">Öffentlich</xsl:when>
                <xsl:when test="ib:Eigentum=2">Privat</xsl:when>
                <xsl:when test="ib:Eigentum=3">Bund</xsl:when>
                <xsl:when test="ib:Eigentum=4">Land</xsl:when>
                <xsl:when test="ib:Eigentum=5">sonstige</xsl:when>
            </xsl:choose>
        </Eigentuemer>
        <Finanzierung/>
        <Sanierungsbedarf/>
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

        <!-- ToDO How can this be established? -->
        <FunktionHierarchisch/>

        <FunktionHydraulisch>
            <xsl:choose>
                <xsl:when test="ib:Entwaesserungsart='KR'">Freispiegelleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='KS'">Freispiegelleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='KM'">Freispiegelleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='KW'">Freispiegelleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='DR'">Pumpendruckleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='DS'">Pumpendruckleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='DM'">Pumpendruckleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GR'">Freispiegelleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GS'">Freispiegelleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GM'">Freispiegelleitung</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GW'">Freispiegelleitung</xsl:when>
                <xsl:otherwise>andere</xsl:otherwise>
            </xsl:choose>
        </FunktionHydraulisch>
        <Hoehengenauigkeit_nach>unbekannt</Hoehengenauigkeit_nach>
        <Hoehengenauigkeit_von>unbekannt</Hoehengenauigkeit_von>
        <Kote_nach>593.602</Kote_nach>
        <Kote_von>593.71</Kote_von>
        <LaengeEffektiv>26.55</LaengeEffektiv>
        <Lagebestimmung>genau</Lagebestimmung>
        <Lichte_Breite>1200</Lichte_Breite>
        <Lichte_Hoehe>1200</Lichte_Hoehe>
        <Material>Asbestzement</Material>
        <Nutzungsart_geplant>
            <xsl:choose>
                <xsl:when test="ib:Entwaesserungsart='KR'">Regenabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='KS'">Schmutzabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='KM'">Mischabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='KW'">Bachwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='DR'">Regenabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='DS'">Schmutzabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='DM'">Mischabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GR'">Regenabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GS'">Schmutzabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GM'">Mischabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GW'">Bachwasser</xsl:when>
                <xsl:otherwise>andere</xsl:otherwise>
            </xsl:choose>
        </Nutzungsart_geplant>
        <Nutzungsart_Ist>
            <xsl:choose>
                <xsl:when test="ib:Entwaesserungsart='KR'">Regenabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='KS'">Schmutzabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='KM'">Mischabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='KW'">Bachwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='DR'">Regenabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='DS'">Schmutzabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='DM'">Mischabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GR'">Regenabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GS'">Schmutzabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GM'">Mischabwasser</xsl:when>
                <xsl:when test="ib:Entwaesserungsart='GW'">Bachwasser</xsl:when>
                <xsl:otherwise>andere</xsl:otherwise>
            </xsl:choose>
        </Nutzungsart_Ist>

        <Profiltyp>Kreisprofil</Profiltyp>
        <Verlauf>
            <POLYLINE>
                <COORD>
                    <C1>700104.792</C1>
                    <C2>100042.846</C2>
                </COORD>
                <COORD>
                    <C1>700105.148</C1>
                    <C2>100039.883</C2>
                </COORD>
                <COORD>
                    <C1>700104.02</C1>
                    <C2>100038.67</C2>
                </COORD>
                <COORD>
                    <C1>700102.64</C1>
                    <C2>100038.39</C2>
                </COORD>
                <COORD>
                    <C1>700082.3</C1>
                    <C2>100035.83</C2>
                </COORD>
            </POLYLINE>
        </Verlauf>

        <Knoten_nachRef REF="PAA_KN27"/>
        <Knoten_vonRef REF="PAA_KN26"/>
    </VSADSSMINI_2015.VSADSSMini.Leitung>
</xsl:template>
</xsl:transform>