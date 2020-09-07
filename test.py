import lxml.etree as ET

xml_filename = 'example_files/isybau/KD-Kappel Haltungen 2013-02.xml'
xsl_filename = 'isybau2interlis/isybau2vdsdss.xslt'

dom = ET.parse(xml_filename)
xslt = ET.parse(xsl_filename)
transform = ET.XSLT(xslt)
newdom = transform(dom)
print(ET.tostring(newdom, pretty_print=True, xml_declaration=True, encoding="utf-8").decode("utf-8"))

