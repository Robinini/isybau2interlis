<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
               xmlns:ib="http://www.ofd-hannover.la/Identifikation"
               exclude-result-prefixes="ib"
               xmlns="http://www.interlis.ch/INTERLIS2.3"
               version="1.0">
    <!-- Import XLST components -->
    <xsl:import href="imports/base.xsl"/>
    <!-- Declare output XML Style -->
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/"><!-- match whole document -->
<TRANSFER>
<HEADERSECTION SENDER="ili2fme-5.7.6-20121121" VERSION="2.3">
    <MODELS>
        <MODEL NAME="Units" VERSION="2012-02-20" URI="http://www.interlis.ch/models"/>
        <MODEL NAME="Base" VERSION="26.5.2012" URI="http://www.sia.ch/405"/>
        <MODEL NAME="SIA405_Base" VERSION="11.6.2012" URI="http://www.sia.ch/405"/>
        <MODEL NAME="VSADSSMINI_2015" VERSION="09.12.2016" URI="http://www.vsa.ch/models"/>
    </MODELS>
</HEADERSECTION>
<DATASECTION>
    <VSADSSMINI_2015.VSADSSMini>
        <xsl:attribute name="BID">
	        <xsl:value-of select="//ib:Identifikation/ib:Datenkollektive/ib:Stammdatenkollektiv/ib:Kennung"/>
        </xsl:attribute>
        <!-- ToDo : Future: consider using loop and sorting according to ReihenfolgeID -->

        <xsl:apply-templates select = "//ib:Identifikation/ib:Datenkollektive/ib:Stammdatenkollektiv" />
    </VSADSSMINI_2015.VSADSSMini>
</DATASECTION>
</TRANSFER>
</xsl:template>

<!-- ToDo: Abwasserbauwerk Detailgeometrie using Flaechen Daten -->

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
        <xsl:call-template name="Eigentuemer"/>
        <Finanzierung/>
        <Sanierungsbedarf/>
        <xsl:call-template name="Status"/>

        <!-- ToDo only <KnotenTyp>0 : Schacht and Anschlusspunkt 1 is covered. Bauwerk 2 neeeds to be implemeted -->
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

        <!-- Is PAA Knoten if Found in Haltung(PAA)/Kante/KnotenAblauf or KnotenZulauf -->
        <!-- ToDo: Not convinced this works - all Knoten are SAA -->
        <FunktionHierarchisch>
            <xsl:choose>
                <xsl:when test="ib:Kante[ib:Haltung]/ib:KnotenZulauf=ib:Objektbezeichnung">PAA</xsl:when>
                <xsl:when test="ib:Kante[ib:Haltung]/ib:KnotenAblauf=ib:Objektbezeichnung">PAA</xsl:when>
                <xsl:otherwise>SAA</xsl:otherwise>
            </xsl:choose>
        </FunktionHierarchisch>

        <Sohlenkote>
            <xsl:value-of select="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Punkthoehe"/>
        </Sohlenkote>
        <Lage>
            <COORD>
                <C1><xsl:value-of select="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Rechtswert"/></C1>
                <C2><xsl:value-of select="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Hochwert"/></C2>
                <!--C3><xsl:value-of select="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='SMP' or ib:PunktattributAbwasser='AP']/ib:Punkthoehe"/></C3-->
            </COORD>
        </Lage>
        <Deckelkote>
            <xsl:value-of select="ib:Geometrie/ib:Geometriedaten/ib:Knoten/ib:Punkt[ib:PunktattributAbwasser='DMP']/ib:Punkthoehe"/>
        </Deckelkote>

        <Lagegenauigkeit>
            <xsl:choose>
                <xsl:when test="ib:Geometrie/ib:Lagegenauigkeitsklasse='OGL1'">plusminus_10cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Lagegenauigkeitsklasse='OGL2'">plusminus_10cm</xsl:when>
                <xsl:when test="ib:Geometrie/ib:Lagegenauigkeitsklasse='OGL3'">plusminus_3cm</xsl:when>
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
        <Baujahr><xsl:value-of select="ib:Baujahr"/></Baujahr>
        <Bemerkung><xsl:value-of select="ib:Kommentar"/></Bemerkung>
        <Betreiber/>
        <Bezeichnung><xsl:value-of select="ib:Objektbezeichnung"/></Bezeichnung>
        <Finanzierung/>
        <Sanierungsbedarf/>
        <xsl:call-template name="Status"/>

        <FunktionHierarchisch>
            <xsl:choose>
                <xsl:when test="ib:Kante/ib:Haltung">PAA.andere</xsl:when>
                <xsl:otherwise>SAA.andere</xsl:otherwise>
            </xsl:choose>
        </FunktionHierarchisch>

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
        <Hoehengenauigkeit_nach/><!-- toDo -->
        <Hoehengenauigkeit_von/><!-- toDo -->
        <Kote_nach><xsl:value-of select="ib:Kante/ib:SohlhoeheAblauf"/></Kote_nach>
        <Kote_von><xsl:value-of select="ib:Kante/ib:SohlhoeheZulauf"/></Kote_von>
        <LaengeEffektiv><xsl:value-of select="ib:Kante/ib:Laenge"/></LaengeEffektiv>
        <Lagebestimmung/><!-- toDo -->
        <Material>
            <xsl:choose>
                <xsl:when test="ib:Kante/ib:Material='AZ'">Asbestzement</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='B'">Beton_Normalbeton</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='OB'">Beton_Ortsbeton</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='BS'">Beton_Pressrohrbeton</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='PC'">Beton_Spezialbeton</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='P'">Beton_Spezialbeton</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='PCC'">Beton_Spezialbeton</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='SZB'">Beton_Spezialbeton</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='FZ'">Faserzement</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='GGG'">Guss_duktil</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='GG'">Guss_Grauguss</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='PH'">Kunststoff_Epoxydharz</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='PEHD'">Kunststoff_Hartpolyethylen</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='GFK'">Kunststoff_Polyester_GUP</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='PE'">Kunststoff_Polyethylen</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='PP'">Kunststoff_Polypropylen</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='PVC'">Kunststoff_Polyvinilchlorid</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='PVCU'">Kunststoff_Polyvinilchlorid</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='KST'">Kunststoff_unbekannt</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='EIS'">Stahl</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='SFB'">Stahl</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='ST'">Stahl</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='CNS'">Stahl_rostfrei</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='MA'">Steinzeug</xsl:when>
                <xsl:when test="ib:Kante/ib:Material='STZ'">Steinzeug</xsl:when>
                <xsl:otherwise>andere</xsl:otherwise>
            </xsl:choose>
        </Material>
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
        <Lichte_Breite><xsl:value-of select="ib:Kante/ib:Profil/ib:Profilbreite"/></Lichte_Breite>
        <Lichte_Hoehe><xsl:value-of select="ib:Kante/ib:Profil/ib:Profilhoehe"/></Lichte_Hoehe>
        <Profiltyp>
            <xsl:choose>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=0">Kreisprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=1">Eiprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=2">Maulprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=3">Rechteckprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=4">Kreisprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=5">offenes_Profil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=6">Eiprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=7">Maulprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=8">Spezialprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=9">Spezialprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=10">Spezialprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=11">Spezialprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=12">Spezialprofil</xsl:when>
                <xsl:when test="ib:Kante/ib:Profil/ib:Profilart=13">Spezialprofil</xsl:when>
                <xsl:otherwise>unbekannt</xsl:otherwise>
            </xsl:choose>
        </Profiltyp>
        <Verlauf>
            <POLYLINE>
                <xsl:for-each select="ib:Geometrie[ib:GeoObjekttyp='L']/ib:Geometriedaten/ib:Polygone/ib:Polygon[ib:Polygonart=3]/ib:Kante/*">
                <COORD>
                    <C1><xsl:value-of select="ib:Rechtswert"/></C1>
                    <C2><xsl:value-of select="ib:Hochwert"/></C2>
                    <!-- C3><xsl:value-of select="ib:Punkthoehe"/></C3 -->
                </COORD>
                </xsl:for-each>
            </POLYLINE>
        </Verlauf>
        <Knoten_nachRef>
            <xsl:attribute name="REF">
	            <xsl:value-of select="ib:Kante/ib:KnotenAblauf"/>
            </xsl:attribute>
        </Knoten_nachRef>
        <Knoten_vonRef>
            <xsl:attribute name="REF">
	            <xsl:value-of select="ib:Kante/ib:KnotenZulauf"/>
            </xsl:attribute>
        </Knoten_vonRef>
        <Leitung_nachRef>
            <xsl:attribute name="REF">
	            <xsl:value-of select="ib:Kante/*/ib:Anschlussdaten/ib:Objektbezeichnung"/>
            </xsl:attribute>
        </Leitung_nachRef>
    </VSADSSMINI_2015.VSADSSMini.Leitung>
</xsl:template>
</xsl:transform>