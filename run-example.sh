#!/bin/bash
# This written on Debian 10 with Ghostscript 9.27. 
# Newer versions require -dNOSAFER as the attach script 
# uses pipe commands to get the mime types and last modified dates

gs -dPDFA=3 -sColorConversionStrategy=RGB -sDEVICE=pdfwrite -dPDFACompatibilityPolicy=1 \
  -sAttachmentSpec=example.json -dDefaultRel=/Source -sDefaultTitle="My Custom PDF/A-3" \
  -dNOPAUSE -dBATCH -dQUIET -o output.pdf attach_pdfa3.ps example.pdf
