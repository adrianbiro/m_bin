#!/bin/bash

in_html="$(mktemp --suffix=.html)"
rfc="${1:? Usage: ${0##*/} <rfc_num> [<out.epub>]}"
out_epub="${2:-${rfc}.epub}"

link_for_all_formats="https://datatracker.ietf.org/doc/html/rfc${rfc}"
link_to_pdf="https://www.rfc-editor.org/rfc/rfc${rfc}.pdf"
link_to_pdf_bkp="https://www.rfc-editor.org/rfc/pdfrfc/rfc${rfc}.txt.pdf"

link="https://www.rfc-editor.org/rfc/rfc${rfc}.html"

echo -e "Fetching RFC:\nfrom:\n\t${link}\nto:\n\t${in_html}\n\n"

curl --silent --fail --show-error "${link}" --output "${in_html}"

#pandoc --from="html" --to="epub3" --output="${out_epub}" "${in_html}"
## Calibre version
ebook-convert "${in_html}" "${out_epub}"

echo -e "\n\nTo see other formats open:\n\t${link_for_all_formats}\nPDF:\n\t${link_to_pdf} or ${link_to_pdf_bkp}"
