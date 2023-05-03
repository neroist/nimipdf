import std/os

import nimwkhtmltox/pdf
import nimib/renders
import nimib

import ./types

proc write*(doc: var NbDoc; pdf: var NbPdf) = 
  echo "[nimib] current directory: ", getCurrentDir()
  
  let dir = doc.filename.splitFile().dir
  
  if not dir.dirExists:
    echo "[nimib] creating directory: ", dir
    createDir(dir)
  
  echo "[nimib] saving file: ", doc.filename
  
  pdf.setGlobalSettings({
    "documentTitle": doc.context["title"].vString,
    "out": doc.filename
  })

  pdf.converter.addObject(pdf.objectSettings, render(doc))
  pdf.convert()
