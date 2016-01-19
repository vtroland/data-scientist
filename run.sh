#!/bin/bash
# Author: Victoria Troland
# Skript for å analysere data fra serien Unge Lovende


# Kjør preprosessering av data

echo "Preprosessering av data"
./preprosessering.sh
./binge.sh

# Analyser dataene i R og skriver ut grafer og informasjon

echo "Analyserer dataene i R! Skriver ut grafer!"
Rscript analysator.r

echo "Ferdig!"