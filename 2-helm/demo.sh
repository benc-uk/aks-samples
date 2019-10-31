#!/bin/bash

# Including DemoMagic
source ../common/demo-magic.sh
# Defining Type Speed
TYPE_SPEED=20
# Defining Custom prompt
DEMO_PROMPT="${green2}\u${WHITE}:${blue2}\w${yellow}$ "

# Deploy with Helm
pe "helm3 upgrade --install demo smilr -f myvalues.yaml"

pe "helm3 ls"
