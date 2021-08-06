## in R we can simply use
## readLines to read in a web page. We can presumably also use
## open(), readLine to process bigger web-pages. But here we simply get the simplest
## ones.

## Seems wrong to define variables here; instead we will make a function
## that returns a list of base urls and other useful things.

urlInfo  <- function(){
    list(base="https://eutils.ncbi.nlm.nih.gov/entrez/eutils/",
         search_suffix = "esearch.fcgi?",
         summary_suffix = "esummary.fcgi?",
         data_suffix = "efetch.fcgi?")
}

## other functions to take this list as a an argument

## terms is a character vector that will be combined
## into a single string
search.ncbi  <- function(url, db="pubmed", terms, type="id", max=0){
    query=paste(url$base, url$search_suffix, "db=", db, "&", sep="")
    query=paste( query, "term=", paste(terms, collapse="+"), "&rettype=", type, sep="" )
    if(max && max > 0)
        query = paste(query, "&retmax=", max, sep="")
    readLines(query)
}

search.ncbi.py  <- function(url, years, db="pubmed", terms, type="id", max=0){
    terms.list  <- paste( paste(terms, collapse="+"),
                         paste(years, "[pdat]", sep=""), sep="+AND+" )
    lapply(terms.list, function(x){
        search.ncbi(url, db=db, terms=x, type=type, max=max )
    })
}

extract.ids  <- function(lines){
    gsub("[^0-9]", "",  grep("<Id>([0-9]+)</Id>$", lines, value=TRUE))
}

extract.count  <- function(lines){
    as.numeric( sub(".+?<Count>([0-9]+)</Count>.+", "\\1", grep("<Count>[0-9]+</Count>", tmp[[1]], value=TRUE))[1] )
}
