# Program for å preprosessere "Unge Lovende"-data
# Programmet lager nye .cvs-filer som kan kjøres gjennom R.
# Author: Victoria Troland

# Bingewatching-målinger
# Ta bort hendelser med kun 0 sekunder sett av serien, tell antall hendelser
	awk -F',' '$4 != 0' all.csv > allClean 
	wc all.csv allClean > countClean
	sed 's/,,/,/g' allClean > sortedClean
	awk -F',' '{print $1, $6, $7, $8, $9}' sortedClean > miniClean
	grep "Nov" miniClean > miniCleanNov
	awk -F' ' '{print $1, $4}' miniCleanNov > countable
	sort countable | uniq -c > c1
	sed 's/[[:space:][:space:]*|\t]/,/g' c1 > novspace
	sed	's/^,,*//g' novspace > nova
# Fjern antall ikke-repeterende hendelser av samme bruker per dag.
	awk -F "," '$1>1' nova > readybinge
	sort readybinge > readybinge.csv
# Tell antall linjer som er blitt fjernet
	wc readybinge.csv nova > totbinge.csv
	sed 's/[[:space:]|\t]/,/g' totbinge.csv > lesser
	sed 's/,,*/,/g' lesser > lesscom
	sed	's/^,//g' lesscom > totbinge.csv
	
# Fjern overflødige filer
rm allClean countClean sortedClean miniClean miniCleanNov
rm nov novspace nova readybinge lesser lesscom c1 countable