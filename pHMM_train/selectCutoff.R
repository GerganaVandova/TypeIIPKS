# Function to plot scores, given one pHMM,
# Assumes that pdf() has been called prior to function call

plotScores <- function(hmm_filename, name_text, mylabs, mylabs_readable,
						cutoff, yaxis) {

	# Test sets
	dir <- "HMM.hmmsearch.FastaTestSets.parse/"

	x.increment <- 1/length(mylabs)
	xloc <- seq(x.increment,1, by=x.increment)
	# name <- paste(name_text, hmm_filename, sep="") # Name of plot has the name of hmm as well
	name <- paste(name_text)

	for (i in 1:length(mylabs)) {
		fn <- paste(hmm_dir, dir, hmm_filename, ".", mylabs[i], ".fasta", sep="")
		t <- read.table(fn)
		x.i <- rep(xloc[i], length(t$V1))
		if ( i == 1) {
			plot(x.i, t$V1, ylim=c(0, yaxis), xlim=c(xloc[1], xloc[length(xloc)]), xaxt='n', xlab="", ylab="HMMER3 pHMM scores", main=name)
		} else {
			x.i <- rep(xloc[i], length(t$V1)); points(x.i, t$V1)
		}
	}

	# Axis labels
	mycex.axis=0.8 #before 0.8
	axis(side=1, at=xloc, labels=mylabs_readable, cex.axis=mycex.axis, lwd=0)#, padj=c(0,.5))
	abline(h=cutoff,col=2,lty=2)

}

hmm_dir <- "/Users/gvandova/Dropbox/Code/TypeIIPKS/pHMM_train/"

# Print the output figure to pdf
outfile <- paste(hmm_dir,"compare.sets.partner.0603.pdf", sep="")
pdf(file=outfile, width=8, height=12) #for plotting all panels
# par(mfrow=c(7, 2)) # to plot all domains
par(mfrow=c(6, 2)) # to plot all but KS and CLF domains

all_labs <- list(
#	c("KS.30", "FabF", "Aur", "CLF.30", "TypeI", "FabH"),
#	c("CLF.30", "FabF", "KS.30", "Aur", "TypeI", "FabH"),
	c("ACP.76", "Ecoli.ACP", "TypeI.ACP", "Aur.ACP"),
	c("AT.7", "TypeI.AT", "FabD"),
	c("KSIII.10", "FabH", "TypeIII.KS", "KS.30", "CLF.30", "TypeI"),

	c("KR.Lackner.C9", "FabG", "KR.Lackner.C15", "KR.Lackner.C17", "KR.Lackner.C19", "TypeI.KR"),
	c("KR.Lackner.C15", "FabG", "KR.Lackner.C9", "KR.Lackner.C17", "KR.Lackner.C19", "TypeI.KR"),
	c("KR.Lackner.C17", "FabG", "KR.Lackner.C9", "KR.Lackner.C15", "KR.Lackner.C19", "TypeI.KR"),
	c("KR.Lackner.C19", "FabG", "KR.Lackner.C9", "KR.Lackner.C15", "KR.Lackner.C17", "TypeI.KR"),

	c("CyclaseABD.3", "Cyclase.3", "Cyclase_polyket.6", "CyclaseSRPBCC.17"),
	c("CyclaseSRPBCC.17", "Cyclase.3", "Cyclase_polyket.6", "CyclaseABD.3"),
	c("Cyclase.3", "CyclaseSRPBCC.17", "Cyclase_polyket.6", "CyclaseABD.3"),
	c("Cyclase_polyket.6", "Cyclase.3", "CyclaseABD.3","CyclaseSRPBCC.17")

)


all_labs_readable <- list(

	# c("TypeII KS", "FabF", "Aurachin", "TypeII CLF", "Type I PKS", "FabH"),
	# c("TypeII CLF", "FabF", "TypeII KS", "Aurachin", "Type I PKS", "FabH"),
	c("TypeII ACP", "Ecoli FAS ACP", "TypeI ACP", "Aurachin"),
 	c("TypeII AT", "TypeI AT", "FabD"),
	c("TypeII KSIII", "FabH", "chalcone", "TypeII KS", "TypeII CLF", "TypeI KS"),

	c("C9 KR", "FabG", "C15 KR", "C17 KR", "C19 KR", "TypeI KR"),
	c("C15 KR", "FabG", "C9 KR", "C17 KR", "C19 KR", "TypeI KR"),
	c("C17 KR", "FabG", "C9 KR", "C15 KR", "C19 KR", "TypeI KR"),
	c("C19 KR", "FabG", "C9 KR", "C15 KR", "C17 KR", "TypeI KR"),

	c("TcmJ cyclase", "OxyN cyclase", "TcmI cyclase", "TcmN cyclase"),
	c("TcmN cyclase", "OxyN cyclase", "TcmI cyclase", "TcmJ cyclase"),
	c("OxyN cyclase", "TcmN cyclase", "TcmI cyclase", "TcmJ cyclase"),
	c("TcmI cyclase", "OxyN cyclase", "TcmJ cyclase","TcmN cyclase")

)

# cutoffs <- c(323, 161, 14, 155, 62, 300, 300, 300, 300, 50, 50, 50, 50) # for all domains
cutoffs <- c(14, 155, 62, 300, 300, 300, 300, 50, 50, 50, 50) # for all but KS and CLF domains

names <- c(
	# "KS pHMM (12 protein sequences)\n",
	# "CLF pHMM (12 protein sequences)\n",
	"ACP pHMM (12 protein sequences)\n",
	"AT pHMM (7 protein sequences)\n",
	"KSIII pHMM (10 protein sequences)\n",

	"C9 KR pHMM (11 protein sequences)\n",
	"C15 KR pHMM (5 protein sequences)\n",
	"C17 KR pHMM (4 protein sequences)\n",
	"C19 KR pHMM (6 protein sequences)\n",

	"TcmJ cyclase pHMM (3 protein sequences)\n",
	"TcmN cyclase pHMM (17 protein sequences)\n",
	"OxyN cyclase pHMM (3 protein sequences)\n",
	"TcmI cyclase pHMM (6 protein sequences)\n"

)
hmm_filenames <- c(
	# "t2ks.selectKnown12.hmm",
	# "t2clf.selectKnown12.hmm",
	"t2acp.selectKnown12.hmm",
	"t2at.selectKnown7.hmm",
	"t2ksiii.selectKnown10.hmm",

	"KR.Lackner.C9.hmm",
	"KR.Lackner.C15.hmm",
	"KR.Lackner.C17.hmm",
	"KR.Lackner.C19.hmm",

	"t2cyclaseABD.selectKnown3.hmm",
	"t2cyclaseSRPBCC.selectKnown17.hmm",
	"t2cyclase.selectKnown3.hmm",
	"t2cyclase_polyket.selectKnown6.hmm"
)

# yaxes <- c(800, 800, 200, 600, 600, 600, 600, 600, 600, 300, 300, 600, 300) # for all domains
yaxes <- c(200, 600, 600, 600, 600, 600, 600, 300, 300, 600, 300) # for all but KS and CLF domains

for (i in 1:length(names)) {
	plotScores(hmm_filenames[i], names[i], all_labs[[i]], all_labs_readable[[i]], cutoffs[i], yaxes[i])

}

dev.off()
