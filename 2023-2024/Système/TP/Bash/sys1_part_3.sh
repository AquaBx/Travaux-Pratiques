#!/bin/bash

function maFonction
{
    local images="$@"

    for image in $images; do
        echo Traitement de "$image"
        ./sys1_part_2.sh "$image"
        echo ""
    done
}

maFonction "$@"