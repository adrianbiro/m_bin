#!/bin/bash

#[Azure DevOps Login](https://aex.dev.azure.com/me?mkt=en-US) [Azure DevOps](https://dev.azure.com/CloudKingdom/) [Entra Id | AAD](https://entra.microsoft.com/#home) [Defender | Security](https://security.microsoft.com/) [365 Admin Center](https://admin.microsoft.com/Adminportal/Home#/homepage) [Intune Admin Center](https://intune.microsoft.com/#home) [Azure Portal](https://portal.azure.com/#home) [Exchange Admin Center](https://admin.exchange.microsoft.com/#/mailboxes) [Reams Admin Center](https://admin.teams.microsoft.com/dashboard) [Compliance | Purview](http://compliance.microsoft.com/)

# Extract links from markdown, that are all in the one line
sed -e 's:) \[:)\n[:g' links.md | grep -oP '(?<=\().*(?=\))'
