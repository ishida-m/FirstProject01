# 第8章 高度な解析手法


##8.1 多変量データを扱う

###8.1.1 重回帰分析
Ozone.lm <- lm(Ozone ~  Solar.R + Wind + Temp + Month + Day,     data = airquality)
summary (Ozone.lm)

cars$speed2 <- cars$speed^2 
cars$dist <- cars$dist * 0.3
head (cars) # 冒頭の6行を表示

cor (cars)

cars.lm2 <- lm (dist ~ speed + speed2, data = cars)
summary (cars.lm2)

Ozone.step1 <- step(Ozone.lm)

TG.aov2 <- aov(len ~ supp, data = ToothGrowth)
summary (TG.aov2)

library(MASS)  # MASSパッケージをロード
TG.step <- stepAIC (TG.aov2,
              scope = list (upper = ~ supp*dose, lower = ~1))
summary (TG.step)



### 8.1.2 主成分分析

myData <- read.csv ("script/chap08a.csv")
head (myData)
data.prn <- prcomp (myData [,-1], scale = TRUE)
biplot (data.prn, xlabs = myData[, 1], cex = 1.2)

dev.off ()

# 固有値分解を実行
(data.eig <- eigen (cor (myData [,-1])))

data.prn
summary(data.prn)


t (t (data.prn$x) / (data.prn$sdev * sqrt (nrow (data.prn$x))))

t (t (data.prn$rotation[, 1:2]) * (data.prn$sdev *
        sqrt (nrow( data.prn$x) )))

getS3method("biplot", "prcomp")

###8.1.3 因子分析

myData <- read.csv ("script/chap08b.csv")
head (myData)


myFac <- factanal (myData [, -1], factors = 2,
                   scores = "regression", rotation = "none")

myFac

# 独自性は，因子負荷量の自乗を 1 から引いた値に相当
1 -  sum (myFac$loadings [1, ]^2)

apply (myFac$loadings, 1, function(x){1 - sum (x^2)})

myFac $ scores


biplot (myFac$scores, myFac$loadings, xlabs = myData[, 1],cex = 1.2)
dev.off ()

myFac2 <- factanal (myData [ , -1], factors = 2,
                     scores = "regression", rotation = "varimax")
# X11()


biplot (myFac2$scores, myFac2$loadings, xlabs = myData[, 1] ,cex = 1.2)
dev.off ()


myFac2 <- factanal (myData [ , -1], factors = 2,
                     scores = "regression", rotation = "varimax")
X11() # グラフィックス・ウィンドウを新規に開く
biplot (myFac2$scores, myFac2$loadings, xlabs = myData[, 1] )


###8.1.4 対応分析
HairEyeColor

(x <- HairEyeColor [ , , Sex = "Female"])

library (MASS)

xc <- corresp (x, nf = 4)
biplot (xc)

dev.off ()

xc$cor

xc.eig <- xc$cor^2  # 正準相関係数の自乗は固有値
xc.eig / sum (xc.eig) # 固有値それぞれの割合
# [1] 8.875533e-01 9.575616e-02 1.669059e-02 3.330887e-32
round (xc.eig / sum (xc.eig), 2) # 丸めて再表示

xc$cor
xc
(xc$X <-  xc$rscore[, 1L:2] %*% diag (xc$cor[1:2]))
(xc$Y <-  xc$cscore[, 1L:2] %*% diag (xc$cor[1:2]) )


###8.1.5 クラスター分析

library (RMeCab)
res <- docNgram ("d:/data/writers", type = 0)

(res.dist <- dist (t (res)))   # 作品ごとの距離を測る

(res.hc <- hclust ( res.dist, "ward"))  # クラスター化する

cophenetic (res.hc)


plot (res.hc)
#dev.off ()
