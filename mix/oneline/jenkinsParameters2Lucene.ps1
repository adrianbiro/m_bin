# Copy modules from Jenkins parameters, then in PowerShell run this, search with string in Kibana Lucene mode 

"http.response.status_code: [499 TO 600] AND container.name : (" + $((Get-Clipboard -Raw) -replace "\n", "* OR ") + "*)"