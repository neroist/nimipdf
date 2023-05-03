import nimwkhtmltox/pdf

type 
  NbPdf* = object
    globalSettings*: ptr GlobalSettings
    objectSettings*: ptr ObjectSettings
    `converter`*: ptr Converter
  
proc setGlobalSetting*(pdf: NbPdf, name, value: string) =
  pdf.globalSettings.setGlobalSetting(cstring name, cstring value)

proc setObjectSetting*(pdf: NbPdf, name, value: string) =
  pdf.objectSettings.setObjectSetting(cstring name, cstring value)

proc setGlobalSettings*(pdf: NbPdf; nvs: openArray[tuple[name: string, value: int | string | bool | float]]) = 
  for nv in nvs:
    pdf.globalSettings.setGlobalSetting(cstring nv[0], cstring $nv[1])

proc setObjectSettings*(pdf: NbPdf; nvs: openArray[tuple[name: string, value: int | string | bool | float]]) = 
  for nv in nvs:
    pdf.objectSettings.setObjectSetting(cstring nv[0], cstring $nv[1])

proc convert*(pdf: NbPdf) = 
  pdf.converter.convert()
