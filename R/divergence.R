#' @title Diversity within a Sample Group
#' @description Quantify microbiota divergence (heterogeneity) within a
#' given sample set.
#'
#' @details
#' Microbiota divergence (heterogeneity / spread) within a given sample
#' set can be quantified by the average sample dissimilarity or beta
#' diversity. Taking average over
#' all pairwise dissimilarities is sensitive to sample size and heavily biased
#' as the similarity values are not independent. To reduce this bias, the
#' dissimilarity of each sample against the group mean is calculated. This
#' generates one value per sample. These can be compared between groups in
#' order to compare differences in group homogeneity. 
#'
#' Note that this measure is still affected by sample size.
#' Subsampling or bootstrapping can be applied to equalize sample sizes
#' between comparisons.
#' 
#' The spearman mode is a simple indicator that returns
#' average spearman correlation between samples of the input data and
#' the overall group-wise average. The inverse of this measure
#' (ie rho instead of 1-rho as in here) was used in Salonen et al. (2014)
#' to quantify group homogeneity.
#' 
#' @param x phyloseq object 
#' @param method dissimilarity method ('spearman' or any method
#' available via the vetan::vegdist function)
#' @return Vector with dissimilarities; one for each sample, quantifying the
#' dissimilarity of the sample from the group-level mean.
#' @export
#' @examples
#' # Assess beta diversity among the African samples
#' # in a diet swap study (see \code{help(dietswap)} for references)
#' data(dietswap)
#' b <- divergence(subset_samples(dietswap, nationality == 'AFR'))
#' @references
#'
#' The inter- and intra-individual homogeneity measures used in
#' Salonen et al. ISME J. 8:2218-30, 2014 were obtained as
#' 1 - beta where beta is the group diversity as quantified by the
#' spearman method.
#' 
#' To cite this R package, see citation('microbiome')
#' 
#' @seealso the vegdist function from the \pkg{vegan} package provides many
#' standard beta diversity measures
#' @author Contact: Leo Lahti \email{microbiome-admin@@googlegroups.com}
#' @keywords utilities
divergence <- function(x, method="spearman") {
    
    # Abundance matrix (taxa x samples)
    x <- abundances(x)
    
    if (method == "spearman") {
        b <- spearman(x, "spearman")
    } else if (method == "bray") {
        b <- beta.mean(x, method="bray")
    }
    
    b
    
}


spearman <- function(x, method="spearman") {
    
    # Correlations calculated against the mean of the sample set
    cors <- as.vector(cor(x, matrix(rowMeans(x)),
        method=method, use="pairwise.complete.obs"))
    
    1 - cors
    
}




beta.mean <- function(x, method="bray") {
    
    # Divergence calculated against the mean of the sample set
    b <- c()
    m <- rowMeans(x)
    for (i in 1:ncol(x)) {
        xx <- rbind(x[, i], m)
        xxx <- vegdist(xx, method=method)
        b[[i]] <- as.matrix(xxx)[1, 2]
    }
    
    b
    
}





beta.pairs <- function(x, method="bray", n = ncol(x)) {
    
    # Divergence calculated against the mean of the sample set
    b <- c()

    # All index pairs
    # pairs <- combn(1:ncol(x), 2)

    # Pick n pairs without replacement
    # inds <- sample(ncol(pairs), n)

    # Distance between each sample and a random pair
    for (i in 1:ncol(x)) {
        i2 <- sample(setdiff(1:ncol(x), i), 1)
        #i1 <- pairs[1, i]
        #i2 <- pairs[2, i]
        xx <- t(x[, c(i, i2)])
        b[[i]] <- as.vector(vegdist(xx, method=method)) 
    }
    
    b
    
}


