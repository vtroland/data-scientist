# Program for å preprosessere "Unge Lovende"-data
# Programmet lager nye .cvs-filer som kan kjøres gjennom R.
# Author: Victoria Troland

# Hendelser
# Tell antall ganger serien er sett totalt
	wc unge-lovende.csv > antallHendelser.csv
# Se unike brukere av UL og tell dem. 
	awk -F ',' '{print $1}' unge-lovende.csv | sort | uniq -c > unikeID.csv	
# Sorter antall besøk av unike brukere. Tell antall unike brukere
	awk -F '\t' '{print $1}' unikeID.csv | sort > sortUnikID
	wc sortUnikID > antallUnik.csv
	sed 's/^ *//' sortUnikID > sortUnikID.csv

# Episoder	
# Sil ut episoder, ta bort overflødig informasjon på linjen
	awk -F',' '{ print $2 }' unge-lovende.csv > episoder
	cut -c 10 episoder > episoder2
	paste -d, unge-lovende.csv episoder2 > episoder3.csv

# Antall unike episoder
	sort episoder2 > sortEpisodes
	uniq sortEpisodes > countedEpisodes.csv

# Tidspunkt
# Hent ut timestamps
	awk -F',' '{ print $3 }' unge-lovende.csv > timestamp.csv
# Konverter til lokaltid, datoene ligger deretter i filen "timestampPerl.csv"
	perl DateConverter.pl
# Sorter etter dato
	grep "Dec" timestampPerl.csv > sortDec
	grep "Nov" timestampPerl.csv > sortNov
	sort -k3,3 sortNov > sortNov2
	sort -k3,3 sortDec > sortDec2
	cat sortNov2 sortDec2 > sortDated.csv
# Tell antall visninger per dato
	awk -F' ' '{print $3}' sortDec2 > sorty
	uniq -c sorty > unikDec
	awk -F' ' '{print $3}' sortNov2 > sortie
	uniq -c sortie > unikNov
	sed 's/^ *//' unikNov > unikNov2
	sed 's/^ *//' unikDec > unikDec2
	cat unikNov2 unikDec2 > unikDatesCount.csv	
# Kommaseparere dato-sortert fil
	sed 's/[[:space:]|\t]/,/g' sortDated.csv > sortD
	sed 's/:/,/g' sortD > sortTD
	sed 's/,,/,/g' sortTD > sortedTD.csv	
# Endre datoene til komma-separertfil
	sed -e "s/[[:space:]|\:]/,/g"  timestampPerl.csv > timedelim.csv
	
# Lim alt sammen til en stor .csv fil
	paste -d, unge-lovende.csv episoder2 timedelim.csv timestampPerl.csv > all.csv

# Fjern unødvendige filer
 rm episoder episoder3.csv episoder2 antallHendelser.csv unikeID.csv 
 rm antallUnik.csv sortEpisodes countedEpisodes.csv
 rm sortDec sortNov2 sortNov sortDec2 unikDec.csv
 rm sorty sortie unikNov2 unikNov unikDec unikDec2 sortD sortTD  