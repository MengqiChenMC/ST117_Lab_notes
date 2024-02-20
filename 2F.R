p_values <- c(0.05, 0.1, 0.3,10000)
n <- 15
k <- 0:15
lambda <- n*p_values
pois_prob <- matrix(dpois(k, lambda), nrow = length(k), ncol
                      = length(p_values),
                      byrow = TRUE)
table_poisson <- data.frame(k = k, PoiProb_p1 = pois_prob[,1], 
                            PoiProb_p2 = pois_prob[,2],
                            PoiProb_p3 = pois_prob[,3])