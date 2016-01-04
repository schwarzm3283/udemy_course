T.test <- function(y1, y2) {
  n1 <- length(y1)
  n2 <- length(y2)
  t_top <- mean(y1) - mean(y2)
  s1 <- var(y1)
  s2 <- var(y2)
  s.sq.num <- ((n1 - 1)*s1) + ((n2 - 1) *s2)
  s.sq.den <- (n1 - 1) + (n2 -1)
  s.sq <- s.sq.num / s.sq.den
  s <- sqrt(s.sq)
  t_bottom <- s*sqrt((1/n1)+(1/n2))
  t <- (t_top / t_bottom)
  return(t)
}

male <- rnorm(1000,0,100)
hist(male)
summary(male)

female <- rnorm(1000,10,100)
hist(female)
summary(female)

tstat <- T.test(female,male); tstat
tst <- t.test(female,male);tst
