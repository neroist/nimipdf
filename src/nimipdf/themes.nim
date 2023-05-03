import std/tables

import nimib/themes
import nimib

const emojiFix* = """ 
  <style>
    img.emoji {
      height: 1em;
      width: 1em;
      margin: 0 .05em 0 .1em;
      vertical-align: -0.1em;
    }
  </style>
  <script src="https://twemoji.maxcdn.com/v/latest/twemoji.min.js"></script>
  <script>window.onload = function () { twemoji.parse(document.body); }</script>
"""
    
proc usePDF*(doc: var NbDoc) = 
  useDefault doc

  doc.partials["footer_right"] = ""
  doc.partials["header"] = ""
  doc.partials["source_section"] = ""

  # fix broken emojis
  # thank you @viceice!
  if not doc.partials.contains("head_other"):
    doc.partials["head_other"] = emojiFix
  else:
    doc.partials["head_other"] &= emojiFix
