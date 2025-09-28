#!/bin/bash
ollama serve

# in other screen session
curl -i http://127.0.0.1:11434/; echo


docker run -d --network=host -v open-webui:/app/backend/data -e WEBUI_AUTH=False -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main

echo 'http://localhost:8080/'