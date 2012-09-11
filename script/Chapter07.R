# 第7章 応用的解析


##7.1 三つ以上の平均値の比較：分散分析

PlantGrowth [c (1:3, 11:13, 21:23), ]

PGaov <- aov (weight ~ group, data = PlantGrowth)
summary(PGaov)

(PG2 <- unstack (PlantGrowth))

(PG.M <- mean (PlantGrowth$weight)) # 全体平均値

PG.S <- PG2 - PG.M
sum (PG.S^2)
PG.M2 <-  matrix (rep (mean (PG2), 10), byrow = T,
                  ncol = 3)
PG.M2  # 水準ごとの平均値を各列 10 個並べた行列
 ##       [,1]  [,2]  [,3]
 ## [1,] 5.032 4.661 5.526
 ## [2,] 5.032 4.661 5.526
 ## [3,] 5.032 4.661 5.526
 ##   ．．．中略
PG.SM <- PG.M2 - PG.M # 行列の全成分について全体平均値を引く
sum (PG.SM^2)          # 水準間平方和

PG.SM2 <- PG2 - PG.M2 		
PG.SM2 
##       ctrl   trt1   trt2
## 1  -0.862  0.149  0.784
## 2   0.548 -0.491 -0.406
## 3   0.148 -0.251  0.014
##    ．．．中略		
sum (PG.SM2^2)                        #

summary (PGaov)

1 - pf( 4.8461, 2, 27)


###7.1.1  多重比較

PG.aov <- aov (weight ~ group, data = PlantGrowth)  
PG.Tukey <- TukeyHSD (PG.aov)  # 結果に TukeyHSD を適用

plot (PG.Tukey)
dev.off ()

PG.Tukey

###7.1.2   交互作用
with (ToothGrowth,  interaction.plot (dose, supp, len))
dev.off ()

TG.aov <- aov (len ~ supp * dose, data = ToothGrowth)
summary (TG.aov)


##7.2  回帰分析
head (cars)
cars$speed <- cars$speed * 1.6
cars$dist <- cars$dist * 0.3
head (cars) # 冒頭の6行を表示

plot (cars) # プロットを作成
dev.off ()

cor (cars)

cars.lm <- lm(dist ~ speed, data = cars)
summary(cars.lm)


plot (cars) # プロットを作成
abline  (cars.lm)

dev.off ()

example (least.squares)

###7.2.1 予測

cars.new <- data.frame (speed = c (33,34))
cars.new
##   speed
## 1    33
## 2    34
cars.pred <- predict (cars.lm, newdata = cars.new)
cars.pred 
##        1        2 
## 19.05805 19.79538
cars.pred2 <- predict (cars.lm, newdata = cars.new,
                        interval = "confidence" )
cars.pred2

##########################
head (women)

women$height <- 2.54 * women$height
women$weight <- 0.454 * women$weight
head (women)

plot (women)

women.lm <- lm(weight ~ height, data = women)

summary (women.lm)

cor (women)


cars.lm <- lm (dist ~ speed, data = cars)
summary (cars.lm)


# 
cars$speed2 <- cars$speed^2 
cars$dist <- cars$dist * 0.3
head (cars) # 冒頭の6行を表示

cor (cars)

cars.lm2 <- lm (dist ~ speed + speed2, data = cars)
summary (cars.lm2)


speed dist
