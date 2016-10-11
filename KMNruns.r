###### KMNruns
### Script to run nreps replicates of the KMEANS algorithm, fo k values ranging between 1 and kmax groupes
### nreps = number of replicates per k value
### kmax = maximal K value
### ru = run suffix, if you want running several scripts in parallel, 
### 	 avoids to write results of different runs in the same files

### These scripts are provided to your convinience; and WITHOUT guarantee. Nils ARRIGO; 
### If you use this script; please cite the following article:
#  Arrigo, N., Felber, F., Parisod, C., Buerki, S., Alvarez, N., David, J., Guadagnuolo, R., 2010. 
# Origin and expansion of the allotetraploid Aegilops geniculata, a wild relative of wheat. New Phytol. 187, 1070-1080.


KMNruns=function(matm,nreps=1000,kmax=30,ru='A'){ 
  dat.d=as.matrix(dist(matm,'euclidean'))
  
  nrtia.intra=function(dat.d,grps,k){
    matrix.temp=dat.d[grps==k,grps==k]
    trgl=matrix.temp[row(matrix.temp) > col(matrix.temp)]
    sum(trgl*trgl)/nrow(matrix.temp)
    }
  
  glob.tot=nrtia.intra(dat.d,grps=rep(1,nrow(as.matrix(dat.d))),1)
  
  inertia.distri=c(NULL,NULL)
  mat=NULL
  jmin=2
  j=jmin
  while(j < kmax+1){
    inrtia.inter=0
    for(reps in 1:nreps){
      grps=kmeans(matm,j,iter.max=20)[[1]]
      intra.tot=0
      for(k in 1:j){
        if(sum(grps==k)>1) intra.tot=intra.tot+nrtia.intra(dat.d,grps,k)
        }
      inrtia.run=glob.tot-intra.tot
      inertia.distri=rbind(inertia.distri,c(j,inrtia.run))
      if(inrtia.run>inrtia.inter){
        inrtia.inter=inrtia.run
        kmat=c(j,inrtia.inter,grps)
        }
      }
      mat=cbind(mat,kmat)
      j=j+1
    }
  write.table(mat,paste('KMNruns',nreps,ru,'reps.txt',sep=''),sep='\t')
  write.table(inertia.distri,paste('KMNruns_distri',nreps,ru,'reps.txt',sep=''),sep='\t')
  
  inrtia=c(0,mat[2,])
  names(inrtia)=c(1,mat[1,])
  D1=diff(inrtia)
  D2=diff(D1)
  names(D2)=jmin:(length(D2)+1)
  
  sds=aggregate(inertia.distri[,2],by=list(inertia.distri[,1]),sd)
  write.table(sds,paste('KMNruns_Inertia_SD',nreps,ru,'reps.txt',sep=''),sep='\t')
  errbar=data.frame(c(1,sds[,1]),inrtia+c(0,sds[,2]),inrtia-c(0,sds[,2]))

  pdf(file=paste('InrtiaWithSD',ru,'.pdf',sep=''))
  plot(inrtia~names(inrtia),xlab='number of clusters (K)',ylab='inter cluster inertia',cex.axis=.8,cex.lab=.8,type='n',bty='n')
  lines(inrtia~names(inrtia))
  points(inrtia~names(inrtia),pch=16)
  for(i in 1:nrow(errbar)){
    lines(x=c(errbar[i,1],errbar[i,1]),y=c(errbar[i,2],errbar[i,3]))
    }
  dev.off()
  
  pdf(file=paste('D2Inrtia_',ru,'.pdf',sep=''))
  plot(D2~names(D2),xlab='number of clusters (K)',ylab='d2(inter cluster inertia)',cex.axis=.8,cex.lab=.8,type='n',bty='n')
  abline(h=0,col='grey')
  lines(D2~names(D2))
  points(D2~names(D2),pch=16)
  dev.off()
  }
