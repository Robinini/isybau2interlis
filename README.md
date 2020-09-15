# isybau2interlis
XML Stylesheet Transformation configuration to convert German wastewater infrastructure data in the ISYBAU format 
to the swiss VSA-DSS Mini data structure in the Interlis 2 geodata format.

# Useage
Download the repository.

Use the [XSLT stylesheet](https://en.wikipedia.org/wiki/XSLT) directly in an application, eg the [Python example](python_example.py)

This is currently in development. Please feel free to contact me regarding contribution/issues/improvements.

# Limits
Currently only the sewerage infrastructure data (Stammdaten) data group is supported.
Data not covered in the target model structure is not converted.
Bauwerk point types are not implemented (yet). Abwasserbauwerk Detailgeometrie is not supported (yet).

# Issues
See the GitHub Issues and ToDo comments in the code. This is very much an initial attempt.

# Outlook
Future work could include conversions to other swiss VSA/SIA models. 
In the meantime, the swiss VSA offer a 
[conversion service](https://vsa.ch/fachbereiche-cc/siedlungsentwaesserung/generelle-entwaesserungsplanung/datenmanagement/) 
between different VSA and SIA models. 

Inclusion of other ISYBAU data groups (eg: hydraulic and record of condition data).

Conversion of swiss VSA-DSS data to ISYBAU data (other direction).
