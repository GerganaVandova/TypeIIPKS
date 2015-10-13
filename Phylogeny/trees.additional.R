# Plotting phylogenetic trees in R using the APE package
# Maureen Hillenmeyer
# Oct 10, 2014

# Load the tree file
library(ape)
dir <- "/Users/gvandova/Dropbox/Code/TypeIIPKS/Phylogeny/"
filename <- "t2clf.selectKnown12.hmm.hmmsearch.parsed.161.withTandemKS.cdhit.88.withrefseqs.withFabF.mod.mafft.FastTree"
# filename <- "t2ks.selectKnown12.hmm.hmmsearch.parsed.323.withTandemCLF.cdhit.93.withrefids.withFabF.mafft.FastTree"
# filename <- "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids.withEcoliACP.mafft.FastTree"

#Additional domains
# filename <- "t2kr.selectKnown16.hmm.hmmsearch.parsed.34.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids.witheryKR.mafft.FastTree"
# filename <- "t2at.selectKnown7.hmm.hmmsearch.parsed.155.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids.withFabD.mafft.FastTree"
# filename <- "t2ksiii.selectKnown10.hmm.hmmsearch.parsed.62.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids.withFabF.mafft.FastTree"
# filename <- "t2cyclaseABD.selectKnown3.hmm.hmmsearch.parsed.50.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids.withcupin.mafft.FastTree"
# filename <- "t2cyclaseSRPBCC.selectKnown10.hmm.hmmsearch.parsed.50.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids.withrata.mafft.FastTree"
# filename <- "t2cyclase.selectKnown3.hmm.hmmsearch.parsed.50.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids.withpseudomonas.mafft.FastTree"
# filename <- "t2cyclase_polyket.selectKnown6.hmm.hmmsearch.parsed.50.withTandemKSCLF.cdhit.99.withrefids.cdhit.93.withrefids.withsaccharothrix.mafft.FastTree"

# Choose root sequence set
rootset <- "FabF" #KS, CLF, KSIII
# rootset <- "EcoliACP" #ACP E coli
# rootset <- "eryKR" #KR tree
# rootset <- "FabD" #AT tree
# rootset <- "cupin" #CyclaseABD
# rootset <- "rata" #CyclaseSRPBCC
# rootset <- "Pseudomonas" #Cyclase
# rootset <- "saccharothrix" #Cyclase_polyket


file <- paste(dir, filename, sep="")
MyTree <- read.tree(file)

#############################################################
# Highlight specific sequences
#Run python get_erin_coord.py
dir1 <- "/Users/gvandova/Dropbox/Code/TypeIIPKS/Phylogeny/"
filename1 <- "erin_t2clf_gbids_descriptions_coord.78.txt" # to get Erin's ref set cluster names for CLFs
# filename1 <- "erin_t2ks_gbids_descriptions_coord.78.txt" # to get Erin's ref set cluster names for KSs
# filename1 <- "erin_t2acp_gbids_descriptions_coord.78.txt" # to get Erin's ref set cluster names for ACPs
# filename1 <- "erin_t2kr_gbids_descriptions_coord.78.txt" # to get Erin's ref set cluster names for KRs
# filename1 <- "erin_t2at_gbids_descriptions_coord.78.txt" # to get Erin's ref set cluster names for ATs
# filename1 <- "erin_t2ksiii_gbids_descriptions_coord.78.txt" # to get Erin's ref set cluster names for KSIIIs
# filename1 <- "erin_t2cyclaseABD_gbids_descriptions_coord.78.txt" # to get Erin's ref set cluster names for Cyclases
# filename1 <- "erin_t2cyclaseSRPBCC_gbids_descriptions_coord.78.txt"
# filename1 <- "erin_t2cyclase_gbids_descriptions_coord.78.txt"
# filename1 <- "erin_t2cyclase_polyket_gbids_descriptions_coord.78.txt"


description_file = paste(dir1, filename1, sep="")
descriptions <- read.table(description_file, sep="\t", as.is=T, row.names=1)
desc.df <- data.frame(descriptions)
tip.label.df <- data.frame(MyTree$tip.label, row.names=1)
# reorder descriptions
desc.reordered <- desc.df[rownames(tip.label.df),]# This is the key step that matches the tree tip names to the external description file


##############################################################
#Descriptions

# Read the 2f file of fastaID and description

dir1 <- "/Users/gvandova/Dropbox/Code/TypeIIPKS/Phylogeny/"
filename1 <- "t2clf.selectKnown12.hmm.hmmsearch.parsed.162.withTandemKS.fasta.phyla" # to get colors by phyla for CLFs
# filename1 <- "t2ks.selectKnown12.hmm.hmmsearch.parsed.323.withTandemCLF.fasta.phyla" # to get colors by phyla for KSs
# filename1 <- "t2ACP.selectKnown12.hmm.hmmsearch.parsed.14.withTandemKSCLF.fasta.phyla" # to get colors by phyla for ACPs
# filename1 <- "t2kr.selectKnown16.hmm.hmmsearch.parsed.34.withTandemKSCLF.fasta.phyla" # to get colors by phyla for KRs
# filename1 <- "t2at.selectKnown7.hmm.hmmsearch.parsed.155.withTandemKSCLF.fasta.phyla" # to get colors by phyla for ATs
# filename1 <- "t2ksiii.selectKnown10.hmm.hmmsearch.parsed.62.withTandemKSCLF.fasta.phyla" # to get colors by phyla for KSIIIs
# filename1 <- "t2cyclaseABD.selectKnown3.hmm.hmmsearch.parsed.50.withTandemKSCLF.fasta.phyla"
# filename1 <- "t2cyclaseSRPBCC.selectKnown10.hmm.hmmsearch.parsed.50.withTandemKSCLF.fasta.phyla"
# filename1 <- "t2cyclase.selectKnown3.hmm.hmmsearch.parsed.50.withTandemKSCLF.fasta.phyla"
# filename1 <- "t2cyclase_polyket.selectKnown6.hmm.hmmsearch.parsed.50.withTandemKSCLF.fasta.phyla"

phylum_file = paste(dir1, filename1, sep="")
phyla <- read.table(phylum_file, sep="\t", as.is=T, row.names=1)

phyla.df <- data.frame(phyla)
tip.label.df <- data.frame(MyTree$tip.label, row.names=1)
# reorder phyla
phyla.reordered <- phyla.df[rownames(tip.label.df),]


# Identify various bacterial phyla in the phylum file, assign to variables
actino <- phyla.reordered=="Actinobacteria"
proteo <- phyla.reordered=="Proteobacteria"
firm <- phyla.reordered=="Firmicutes"
bactero <- phyla.reordered=="Bacteroidetes"
cyano <- phyla.reordered=="Cyanobacteria"
spiro <- phyla.reordered=="Spirochaetes"
verru <- phyla.reordered=="Verrucomicrobia"
plancto <- phyla.reordered=="Planctomycetes"
thermo <- phyla.reordered=="Thermotogae"
chloroflexi <- phyla.reordered=="Chloroflexi"
syner <- phyla.reordered=="Synergistetes"
aqui <- phyla.reordered=="Aquificae"
cloa <- phyla.reordered=="Cloacimonetes"

# colors
myCols <- c(rep("black",length(MyTree$tip.label)))

# Terrabacteria: blues (per Hedges MBE 2009)
myCols[actino]="blue"
myCols[firm]="lightblue"## old: "orange"
myCols[cyano]="cyan"
myCols[chloroflexi]="darkblue"
# Hydrobacteria (per Hedges MBE 2009)
myCols[proteo]="red"
myCols[bactero]="purple"
myCols[plancto]="magenta"
myCols[verru]="brown"
myCols[spiro]="lightpink"
# Other bacteria (per Hedges MBE 2009)
myCols[thermo]="orange"
myCols[aqui]="orange"
myCols[syner]="orange"
myCols[cloa]="orange"


myBG <- myCols


##########################################################
# colors
# for now just b&w
#myCols <- c(rep("gray",length(MyTree$tip.label)))
#myBG <- myCols
#myBG<- c(rep("white",length(MyTree$tip.label)))

##########################################################
# Plot rectangular phylogram
# With query sequences highlighted
# Must choose outgroup sequence to root on

treetype <- "phylogram";
outgroup <- grep(rootset, MyTree$tip.label, perl=TRUE)

MyTree.rooted <- root(MyTree,outgroup,node = NULL)
MyTree.ladderized <- ladderize(MyTree.rooted)

mywidth=3; myheight=6 #for small tree
# mywidth=10; myheight=30 #for big tree

# mywidth=15; myheight=30 #for big tree AT KSIII
#mywidth=40; myheight=100# really big for browsing names


edge.color <- "gray"
myPch <- 21# circles


outfile <- paste(dir, filename, ".",treetype,".pdf", sep="")
pdf(file=outfile, width=mywidth, height=myheight)
plot(MyTree.ladderized, font=1, type=treetype, edge.color=edge.color, edge.width=.5, show.tip.label=F, open.angle=5)

# colored dots
# selectPchCex=.5 # for big pdf (10.30)
selectPchCex=.15 #for small pdf (2.6)
tiplabels(pch=myPch, cex=selectPchCex, col=myCols, bg=myBG)# colored label dots

# Print select labels
#  identified using grep above (Erin set)
selectCex <- 1
# tiplabels(MyTree$tip.label[printlabels], printlabels, cex=selectCex, frame="none", adj=0) ### comment out if don't want to show labels

# Print all labels
allLabCex <- .5
# tiplabels(MyTree$tip.label, cex=.2, frame="none", adj=0) ### comment out if don't want to show labels for big tree KS CLF
# tiplabels(MyTree$tip.label, cex=.3, frame="none", adj=0) ### comment out if don't want to show labels for big tree AT, KSIII

# nodelabels(MyTree$node.label, frame="none", cex=.1)
#edgelabels(MyTree$edge.label, frame="none", cex=.2)

# tiplabels(desc.reordered, cex=.3, frame="none", adj=0) # to highlight ref sequences for big pdf (10.30) KS CLF
# tiplabels(desc.reordered, cex=1, frame="none", adj=0) # to highlight ref sequences for big pdf (10.30) AT, KSIII

# tiplabels(desc.reordered, cex=.05, frame="none", adj=0) # to highlight ref sequences when pdf(3,6) for KR
# tiplabels(desc.reordered, cex=.3, frame="none", adj=0) # to highlight ref sequences when pdf(3,6) for AT
tiplabels(desc.reordered, cex=.2, frame="none", adj=0) # to highlight ref sequences when pdf(3,6) for KSIII

# tiplabels(phyla.reordered, cex=.1, frame="none", adj=0) # if you want phyla displayed



add.scale.bar(cex=allLabCex, lwd=selectPchCex)
dev.off()
