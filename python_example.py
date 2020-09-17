import lxml.etree as ET


xsl_filename = 'isybau2interlis/isybau2vsadss.xsl'

def convert(input):
    dom = ET.parse(input)
    xslt = ET.parse(xsl_filename)
    transform = ET.XSLT(xslt)
    return transform(dom)


muster_2013 = convert('example_files/isybau/ISYBAU_XML_2013_Schema_Beispieldaten/2_Stammdaten/ISYBAU_XML-2013-Stammdaten.xml')

# Save to file
muster_2013.write('example_files/output/ISYBAU_XML-2013-Stammdaten.xtf', pretty_print=True, encoding='utf-8', xml_declaration=True)

# Print to screen
print(ET.tostring(muster_2013, pretty_print=True, xml_declaration=True, encoding="utf-8").decode("utf-8"))

