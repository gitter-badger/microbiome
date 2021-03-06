% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_csv2phyloseq.R
\name{read_csv2phyloseq}
\alias{read_csv2phyloseq}
\title{Read Simple OTU Tables into a Phyloseq Object}
\usage{
read_csv2phyloseq(otu.file = NULL, taxonomy.file = NULL,
  metadata.file = NULL)
}
\arguments{
\item{otu.file}{A simple otu_table with '.csv' extension}

\item{taxonomy.file}{A simple taxonomy file with '.csv' extension}

\item{metadata.file}{A simple metadata/mapping file with .csv extension}
}
\value{
\code{\link{phyloseq-class}} object.
}
\description{
Read simple OTU tables, mapping and taxonomy files into a
\code{\link{phyloseq-class}} object.
}
\details{
Simple OTU tables, mapping and taxonomy files will be converted
to \code{\link{phyloseq-class}}.
}
\examples{

otu.file <-
   system.file("extdata/qiita1629_otu_table.csv",
       package='microbiome')

tax.file <- system.file("extdata/qiita1629_taxonomy_table.csv",
       package='microbiome')

meta.file <- system.file("extdata/qiita1629_mapping_subset.csv",
       package='microbiome')

p0 <- read_csv2phyloseq(
         otu.file=otu.file, 
         taxonomy.file=tax.file, 
         metadata.file=meta.file)

}
\author{
Sudarshan A. Shetty \email{sudarshanshetty9@gmail.com}
}
\keyword{utilities}
