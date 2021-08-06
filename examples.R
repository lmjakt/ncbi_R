source("ncbi_functions.R")

url  <- urlInfo()

s1  <- search.ncbi(url, terms="firre")
s1.id  <- extract.ids(s1)
length(s1.id) ## 20...

s1  <- search.ncbi(url, terms="firre", max=1000)
s1.id  <- extract.ids(s1)
length(s1.id) ## 43

s2  <- search.ncbi(url, terms="firre", type='count')
s2.count  <- extract.count(s2)

s3  <- search.ncbi.py(url, years=2000:2021, terms="firre", type='count')
s3.counts  <- sapply(s3, extract.count)

s4  <- search.ncbi.py(url, years=2000:2021, terms="firre", type='id')
s4.ids  <- sapply(s4, extract.ids)
s4.ids.c  <- do.call(c, s4.ids)
length(s4.ids.c) ## 44
length(unique(s4.ids.c)) ## 39

image( sapply( s4.ids, function(x){ sapply(s4.ids, function(y){ sum(x %in% y) } )}) )

s5  <- search.ncbi.py(url, years=2000:2021, terms="lncrna", type='id', max=10000)
s5.ids  <- lapply(s5, extract.ids)
s5.ids.c  <- do.call(c, s5.ids)
length(s5.ids.c) ## 32904
length(unique(s5.ids.c)) ## 29275

## more than 10% duplicates!
length(unique(s5.ids.c)) / length(s5.ids.c) ## 0.889

s6  <- search.ncbi.py(url, years=2000:2021, terms="miRNA", type='id', max=10000)
s6.ids  <- lapply(s6, extract.ids)
s6.ids.c  <- do.call(c, s6.ids)
length(s6.ids.c) ## 32904
length(unique(s6.ids.c)) ## 29275

## more than 5% duplicates!
length(unique(s6.ids.c)) / length(s6.ids.c) ## 0.889
