import std/os

import nimwkhtmltox/pdf
import nimib/renders
import nimib

import ./nimipdf/themes
import ./nimipdf/types
import ./nimipdf/docs

template nbInitPDF*(theme = usePDF, thisFileRel = "") =
  var tfr = if thisFileRel == "":
      instantiationInfo(-1).filename
    else:
      thisFileRel

  nbInit(theme, backend=renders.useHTMLBackend, tfr)

  if nb.options.filename == "":
    nb.filename = nb.filename.changeFileExt ".pdf"

  initPDF() 
  
  var nbPdf {.inject.}: NbPDF 

  nbPdf.globalSettings = createGlobalSettings({
    "useCompression": true
  })

  nbPdf.objectSettings = createObjectSettings({
    "useLocalLinks": true,

    "load.blockLocalFileAccess": false,

    "web.background": true,
    "web.loadImages": true,
    "web.enableJavascript": true
  })

  nbPdf.converter = createConverter(nbPdf.globalSettings)

  nbPdf.setGlobalSettings({
    "outlineDepth": 7
  })

  nbPdf.setObjectSettings({
    "web.defaultEncoding": "utf-8",
  })

template nbPageBreak* =
  nbRawHtml: """
<div style="page-break-before: always !important;"></div>
"""

template nbSavePDF* =
  nb.nbCollectAllNbJs()

  nb.context.searchDirs(nb.templateDirs)
  nb.context.searchTable(nb.partials)

  write nb, nbPdf

  deinitPDF()

  if nb.options.show:
    open nb

export 
  changeFileExt,
  getAppFilename,
  render, 
  usePDF, 
  write,
  types,
  pdf 
