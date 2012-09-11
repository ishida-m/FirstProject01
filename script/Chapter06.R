# 第6章 仮説検定

###6.1.1 １標本の平均値の検定

x <- c (178.59,181.14,177.6,180.55,178.54,179.32,
        180.01,179.44,180.65,181.55,179.2,180.56,
        179.9,178.81,179.64,179.63,179.36,178.85,
        179.82,182.43,180.47,179.66,181.54,178.98,
        180.2,179.87,179.05,179.72,179.34,180.26)

t.test(x, mu = 180)
qt (0.975, 30 - 1) 
## [1] 2.045230
c (mean(x) - 2.045230 * sd(x) /sqrt(30),
     mean(x) + 2.045230 * sd(x)  /sqrt(30))

###6.1.2    2 標本の平均値の検定
A <- c (45,45,46,42,47,45,44,47,43,44,44,47,45,48,44,
        43,48,49,44,47,47,47,48,45,45,45,44,50,44,46)
B <- c (48,50,50,46,48,48,46,49,47,48,50,45,46,49,50,
        51,46,47,47,46,49,47,47,50,48,48,49,47,49,47)
t.test (A, B)


###6.1.3 2 標本の平均値の検定：片側検定
t.test (A, B, alternative = "less")
mean (weight$before)
mean (weight$after)


###6.1.4   2 標本の平均値の検定：対応がある場合


t.test (after ~ before, paired = TRUE,  data = weight)

##### コラム：ファイルの読み書き

   x <- c ("加藤", "佐藤", "鈴木", "田中", "野田")
   y <- c (100, 90, 80, 70, 60)
   xy <- data.frame (Name = x, Score = y)
   (tmp <- paste ("student", 1:5, sep = "-"))
   xy $ ID <- tmp
   xy2 <- xy [ , c ("ID", "Score")]
xy2

write.csv (xy2, file = "xy.csv")
file.show ( "xy.csv")

setwd ("C:/data/") 
getwd()

write.csv (xy2, file = "xy.csv",
         quote = FALSE, row.names = FALSE)
file.show ("xy.csv")

xy2 <- read.csv (file = "C:/data/xy2.csv")

write.csv (xy2, file = "xyForMac.csv", fileEncoding = "UTF-8")


##6.2 質的データ

HairEyeColor

sum (HairEyeColor [ , , "Female"])


###6.2.1

(X <- matrix (c (22, 18, 18, 22), ncol = 2))
##      [,1] [,2]
## [1,]   22   18
## [2,]   18   22
(X.chi <- chisq.test(X))
X.chi$expected
X.chi$observed
X.chi$statistic

##### コラム：カイ自乗分布
(X <- matrix (c (22, 18, 18, 22), ncol = 2))
addmargins (X)
X - 20
sum ((X-20)^2/20)
1 - pchisq (0.8, df = 1)
pchisq (0.8, df = 1, lower.tail = FALSE)

##### コラム：R における確率関数
dnorm (0, mean = 0, sd = 1)
pnorm (0, mean = 0, sd = 1)
qnorm (0.5, mean = 0, sd = 1)

###6.2.2  対応のある独立性の検定

(senkyo <- matrix (c (18, 8, 15, 21), byrow = TRUE,
                    ncol = 2))
mcnemar.test (senkyo)
####################################

##### コラム：

CairoPDF(file = "fig6.1.pdf");par(cex.axis =1.4, cex.lab = 1.4)
tfunc <- function(x) dt (x, df = 29)
plot (tfunc, -4, 4, xlab = "t", ylab="", main="自由度 30-1 の t 分布")
tpaint<-function(x1,x2,color)
{
  xvals<-seq(x1,x2,length=50)
  dvals<-tfunc (xvals)
  polygon(c(xvals,rev(xvals)),c(rep(0,50),rev(dvals)),col=color)
}
tpaint(-0.96,0.96, "gray")
text (-2, .38, "t = |0.9591|: N = 30 -1")
dev.off()


tfunc <- function(x) dt (x, df = 29)
tpaint<-function(x1,x2,color)
{
  xvals<-seq(x1,x2,length=50)
  dvals<-tfunc (xvals)
  polygon(c(xvals,rev(xvals)),c(rep(0,50),rev(dvals)),col=color)
}

CairoPDF(file = "fig6.2.pdf");par(cex.axis =1.4, cex.lab = 1.4)
plot (tfunc, -4, -1.5, xlab = "t", ylab="", main="自由度 30-1 の t 分布")
tpaint(-4, -1.7, "gray")
# text (-2, .38, "t = |0.9591|: N = 30 -1")
lines (c(-2,-2), c(0, dt(-2, df = 29)), lwd = 2)
text (-2.5,  dt(-2, df = 29), "両側棄却点 = -2", cex = 1.2)
text (-2.2,  dt(-1.7, df = 29), "片側棄却点 = -1.7", cex = 1.2)
dev.off()



chi1func <- function(x) dchisq (x, df = 1)
chi5func <- function(x) dchisq (x, df = 5)
chi8func <- function(x) dchisq (x, df = 8)

## chipaint<-function(x1,x2,color)
## {
##   xvals<-seq(x1,x2,length=50)
##   dvals<- chifunc (xvals)
##   polygon(c(xvals,rev(xvals)),c(rep(0,50),rev(dvals)),col=color)
## }

CairoPDF(file = "p205.pdf");par(cex.axis =1.4, cex.lab = 1.4)
plot (chi1func, 0, 20, xlab = "カイ自乗値", ylab="", main="カイ自乗分布", lwd = 3, ylim = c(0, 0.25))
curve (chi5func, 0, 20, lwd = 3, lty = 2, add = T)
curve (chi8func, 0, 20, lwd = 2, lty = 3, add = T)
dev.off ()


CairoPDF (file = "p221.pdf");par(cex.axis =1.4, cex.lab = 1.4)
x <- seq(0,5, 0.1)
y <- dchisq (x, df = 1) # curve (dchisq (x, df = 5), 0, 20)
plot (x, y, type = "l", lwd = 2, main = "自由度1のカイ自乗分布", xlab = "X-squared", ylab = "")
xvals <- seq (qchisq(0.8, df = 1), 5, length = 10)  ## x 軸の頂点位置　10個
dvals <- dchisq (xvals, df = 1)        ## y　軸の頂点位置　10個
polygon (c((xvals), rev(xvals)),  c(rep(0, 10), rev(dvals)), col = "gray")　
text(3, .3, "右の面積が確率 = 0.5",cex = 1.4 )
# text(3, 0.0, round(qchisq(0.5, df = 5), 1), cex = 2)
dev.off()

qchisq(0.5, df = 5)

######################### 
x <- c (178.59,181.14,177.6,180.55,178.54,179.32,
        180.01,179.44,180.65,181.55,179.2,180.56,
        179.9,178.81,179.64,179.63,179.36,178.85,
        179.82,182.43,180.47,179.66,181.54,178.98,
        180.2,179.87,179.05,179.72,179.34,180.26)

t.test(x, mu = 180)

 qt (0.975, 30 - 1) 
# [1] 2.045230
c (mean(x) - 2.045230 * sd(x) /sqrt(30),
    mean(x) + 2.045230 * sd(x)  /sqrt(30))

A <- c (45,45,46,42,47,45,44,47,43,44,44,47,45,48,44,
        43,48,49,44,47,47,47,48,45,45,45,44,50,44,46)
B <- c (48,50,50,46,48,48,46,49,47,48,50,45,46,49,50,
        51,46,47,47,46,49,47,47,50,48,48,49,47,49,47)

t.test (A, B)

## t.test (A, B, var.equal = TRUE)

## var.test(A,B)

t.test (A, B, alternative = "less")

(weight <- read.csv ("script/weight.csv"))

mean (weight$before)
# [1] 50.617
mean (weight$after)

t.test (after ~ before, paired = TRUE,
           data = weight)


xy2
 write.csv (xy2, file = "xy.csv")
 file.show ( "xy.csv")

setwd ("C:/data/") 
getwd()

write.csv (xy2, file = "xy.csv",
         quote = FALSE, row.names = FALSE)
file.show ("xy.csv")

xy2 <- read.csv (file = "C:/data/xy2.csv")

write.csv (xy2, file = "xyForMac.csv", fileEncoding = "UTF-8")

HairEyeColor

(X <- matrix (c (22, 18, 18, 22), ncol = 2))
##      [,1] [,2]
## [1,]   22   18
## [2,]   18   22
(X.chi <- chisq.test(X))

X.chi$expected
##      [,1] [,2]
## [1,]   20   20
## [2,]   20   20
X.chi$observed
##      [,1] [,2]
## [1,]   22   18
## [2,]   18   22
X.chi$statistic
X

addmargins (X)

X - 20
sum ((X-20)^2/20)

1 - pchisq (0.8, df = 1)
# [1] 0.3710934
pchisq (0.8, df = 1, lower.tail = FALSE)

dnorm (0, mean = 0, sd = 1)
# [1] 0.3989423
pnorm (0, mean = 0, sd = 1)
#[1] 0.5
qnorm (0.5, mean = 0, sd = 1)

(senkyo <- matrix (c (18, 8, 15, 21), byrow = TRUE,
                    ncol = 2))
##      [,1] [,2]
## [1,]   18    8
## [2,]   15   21
mcnemar.test (senkyo)




## ## my.dnorm <- function(x) dnorm(x, 50, 10)
## ## curve(my.dnorm, from = 10, to = 80, add =T, lwd = 3, lty = 2, col = "red")
## x <- seq(0, 20, 0.01)
## plot(x, dchisq(x, 1), ylim=c(0, 0.3), type="l",
##        xlab="chisq", ylab="density", main="chi-squared distributions")
## curve(dchisq(x, 5), lty = 2, add=T)
## curve(dchisq(x, 8), lty = 3, add=T)

## # dev.copy2eps(file = "img/chisq1.eps")


## x  <- seq(0, 10, 0.01)
## density <- dchisq(x , 1)
## plot(x , density, type="l", ylim=c(0,0.5), main="chi-squared(1) distribution")
## tvals <- seq(1.1, 10, length=100)
## dvals <- dchisq(tvals, 1)
## polygon(c(tvals, rev(tvals)), c(rep(0,100), rev(dvals)), col="grey")
## abline(h=0)


## (X <- matrix(c(25,20,20,25), nrow = 2))
## (X.chi <- chisq.test(X))

## X.chi$expected
## X.chi$observed
## X.chi$residuals
## X.chi$statistic


## (X.chi <- chisq.test(X, correct = FALSE))

## addmargins(X)

## X - 22.5
## sum (X - 22.5)

## (X - 22.5)^2
## ((X - 22.5)/ 22.5)^
## 1 - pchisq(1.1, df = 1)
## pchisq(1.1, df = 1, lower.tail = FALSE)
## prop.table (X) * sum(X)
## prop.table (X, margin = 1)
## prop.table (X, margin = 2)

## (X <- addmargins(X))


## x  <- seq(-5, 5, 0.01)
## density <- dt(x , 24)
## plot(x , density, type="l", main="t-24 distribution")
## tvals <- seq(1.1, 10, length=100)
## dvals <- dt (tvals, 1)
## polygon(c(tvals, rev(tvals)), c(rep(0,100), rev(dvals)), col="grey")
## abline(h=0)


rejection.region <- function(df, s0, s.max=4, length=100, col="#0000aa20", main="plot")
{
  x <- seq(-s0, s0, length=length)
  plot(c(x, s0, -s0), c(dt(x, df), 0, 0), xlim=c(-s.max, s.max), type="l", xlab="t", ylab="f(t)", main = main)
  x <- seq(s0, s.max, length=length)
  y <- c(dt(x, df), 0, 0)
  x <- c(x, s.max, s0)
  polygon(x, y, col=col)
  polygon(-x, y, col=col)
 
}

CairoPDF(file = "fig6.1.pdf");par(cex.axis =1.4, cex.lab = 1.4)
rejection.region(29, 0.9591, 4, main="自由度30-1のt分布")
 text (-4, .38, "|t| = 0.951; N = 30-1", pos = 4, cex = 1.2 )
dev.off()

## weight <- read.csv ("~/Dropbox/R/weight.csv")

## nchar

