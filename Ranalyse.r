# R-skript for ?? analysere Unge Lovende
# Author: Victoria Troland
# Dato: 17. januar 2015

# Last inn filer
setwd("/Users/victoria/Desktop/NRKUngeLovende/")
sortUnikID <- read.csv(file="sortUnikID.csv", header=FALSE, sep=" ")
sortDates<- read.csv(file="sortDated.csv", header=FALSE, sep=" ")
sortTD<- read.csv(file="sortedTD.csv", header=FALSE, sep=",")
countDates<- read.csv(file="unikDatesCount.csv", header=FALSE, sep=" ")
binge <- read.csv(file="readybinge.csv", header=FALSE, sep=",")
bingetot <- read.csv(file="totbinge.csv", header=FALSE, sep=",")

# Analyse av datoene
pdf('plot.pdf')
barplot(countDates$V1, main="Distribusjon over visninger", xlab="Dag", ylim=c(0,45000), ylab="Antall visninger")
dev.off()
sort(countDates$V1)
mean(countDates$V1)
sum(countDates$V1[35:40])

month <- as.data.frame(table(sort(sortDates$V2)))
#month

monthperc <- month$Freq/sum(month$Freq)*100
#monthperc

# Analyserer dager UL ble sett
day <- as.data.frame(table(sortDates$V1))
#day
new <- day[c(day$Var1[2],day$Var1[6], day$Var1[7], day$Var1[5], day$Var1[1], day$Var1[3], day$Var1[4]),]
#new
days <- c("Mandag", "Tirsdag", "Onsdag", "Torsdag", "Fredag", "L??rdag", "S??ndag")
pdf('dagUke.pdf')
barplot(new$Freq, main="Dag i uken og antall visninger",names.arg=days,las=2, col="black")
dev.off()

# Analysere avspillingstidspunkt
#sortTD
time <- as.data.frame(table(sortTD$V4))
#time
pdf('time.pdf')
barplot(time$Freq, main="Klokken 00-23 og antall visninger av UL", col="pink", las=2,names.arg=time$Var1,cex.names=0.8)
dev.off()

# Analyserer brukerne
mean(sortUnikID$V1)
table <- as.data.frame(table(sortUnikID$V1))
smashed <- c(sum(table$Freq[1:5]),sum(table$Freq[5:10]),sum(table$Freq[10:15]),sum(table$Freq[15:20]),sum(table$Freq[20:25]),sum(table$Freq[25:30]),sum(table$Freq[30:35]),sum(table$Freq[35:40]))
table$perc <- table$Freq/sum(table$Freq)*100
#table$Freq
table$perc[1:10]
sum(table$perc[1:2])
sum(table$perc[1:3])
sum(table$perc[1:4])
sum(table$perc[1:5])
sum(table$perc[1:6])
sum(table$perc[1:7])
sum(table$perc[1:8])
sum(table$perc[1:9])
sum(table$perc[1:10])
sum(table$Freq[11:40])
sum(table$perc[11:40])
sum(table$perc[1:40])

# Analyserer bingewatching
#binge
mean(binge$V1)
allbinge <- sort(binge$V1)
#bingetot
bingetot$V1[1]/sum(bingetot$V1[2]+bingetot$V1[1])*100
bingetot$V1[2]/sum(bingetot$V1[2]+bingetot$V1[1])*100
tabl <- table(allbinge)
tablperc <- tabl/sum(tabl)*100
labs<- paste ("(",names(tabl),")", "\n", round(tablperc),sep="")
pdf('binge.pdf')
pie(tabl, labels=labs,col=cols, main="Størrelse på bingeforekomster",cex=0.9)
legend("topright", labs,cex=0.7,fill=cols)
dev.off()

# Korrelasjoner
new <- data.frame(binge$V1,as.numeric(binge$V3))
cor(new$binge.V1,new$as.numeric.binge.V3.)

