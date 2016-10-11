### These scripts are provided to your convinience; and WITHOUT guarantee. Nils ARRIGO; 
### If you use this script; please cite the following article:
#  Arrigo, N., Felber, F., Parisod, C., Buerki, S., Alvarez, N., David, J., Guadagnuolo, R., 2010. 
# Origin and expansion of the allotetraploid Aegilops geniculata, a wild relative of wheat. New Phytol. 187, 1070-1080.

###### Open data (STRUCTURE like formatted table)
data=read.delim("STR2.2.P287ind167loc.txt",header=F,row.names=1)

### get only the columns with AFLP data
matm=data[,-1] # get rid of the populations column
matm=matm[,!is.na(colSums(matm))] # get rid of AFLP markers with missing values
matm=matm[,colSums(matm)>1] # make sure to get at least one presence per AFLP marker

### Source and Run the Kmeans Script
source('KMNruns.r') 
KMNruns(matm,nreps=50000,kmax=10,'A')

### Note that you can copy-paste that script on several computers to parallelize the jobs; e.g.
### just make sure to change the last argument of the KMNruns function. see KMNruns.r for further details
KMNruns(matm,nreps=50000,kmax=10,'B')
KMNruns(matm,nreps=50000,kmax=10,'C')
KMNruns(matm,nreps=50000,kmax=10,'D')
#  ... etc