import lxml.etree as ET

xml_filename_paa = 'example_files/isybau/KD-Kappel Haltungen 2013-02.xml'
xml_filename_saa = 'example_files/isybau/KD-Kappel Leitungen 2013-02.xml'
xsl_filename = 'isybau2interlis/isybau2vdsdss.xsl'

def convert(input):
    dom = ET.parse(input)
    xslt = ET.parse(xsl_filename)
    transform = ET.XSLT(xslt)
    return transform(dom)

paa = convert(xml_filename_paa)
paa.write('example_files/output/KD-Kappel Haltungen 2013-02.xtf', pretty_print=True, encoding='utf-8', xml_declaration=True)
print(ET.tostring(paa, pretty_print=True, xml_declaration=True, encoding="utf-8").decode("utf-8"))

saa = convert(xml_filename_saa)
saa.write('example_files/output/KD-Kappel Leitungen 2013-02.xtf', pretty_print=True, encoding='utf-8', xml_declaration=True)
print(ET.tostring(paa, pretty_print=True, xml_declaration=True, encoding="utf-8").decode("utf-8"))


