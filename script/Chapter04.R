# 第4章 グラフィックスの基礎／グラフィックスで遊ぶ


##4.2 plot()関数

plot (1:10, cex = 2, cex.lab = 1.5, cex.axis = 1.3)
dev.off()


##### マージンを確認するためのプロット ## ここから
# 四つの外部マージンを3 行分の高さに設定
par(oma = rep(3, 4), bg = "gray")
plot(c(0, 1), c(0, 1), type="n", ann = FALSE, axes = FALSE)
par(xpd = TRUE) # 作図領域に加工を加える
# 作図領域を黄色に塗る
rect(par()$usr[1] - par()$mai[2], par()$usr[3] - par()$mai[1],
par()$usr[2] + par()$mai[4], par()$usr[4] + par()$mai[3],
col = "yellow", border = NA)
box("figure") # 作図領域全体を黒枠で囲む
par(xpd = FALSE) # 描画の対象をプロット領域に戻す
# プロット領域を白く塗りつぶす
rect(par()$usr[1], par()$usr[3],
par()$usr[2], par()$usr[4],
col = "white", border = NA)
box("plot", lty = "dashed", col = "green") # プロット領域を囲む
text(.5, .5, "plot region", cex = 1.8)
# 四つの内部マージンに描画
mtext("figure region", side = 3, line = 2, adj = 1, cex = 1.8)
# line = 2 は内部マージン上(side=3) の 2 行目の高さに描くことを指定
# adj は 0 なら左端，1 なら右端に描画．
for (i in 1:4)
mtext(paste("inner margin", i), side = i, cex = 1.4,
las = 0, line = 1, outer = FALSE)
# 四つの外部マージンに描画# outer = TRUE
for (i in 1:4)
mtext(paste("outer margin", i), side = i, cex = 1.4,
las = 0, line = 1, outer = TRUE)
# 外部マージンにラベルを付ける
mtext("device region", side=3, line=2, adj = 1, outer = TRUE,cex = 1.8)
# 最後にプロット全体を赤い枠で囲む
box("outer", col = "red", lwd = 3)
# axis(1) # これまで作成した図と重なるが，x 軸の目盛を描く
# axis(2) # y 軸の目盛を描く
###### ここまで実行
dev.off()

##### コラム：リサイクル
plot (1:10, col = c ("red", "blue"))
x <- rep (10, 10)
x
## [1] 10 10 10 10 10 10 10 10 10 10
x / c (2, 5) 
## [1] 5 2 5 2 5 2 5 2 5 2

x / c (2, 5, 10)
######



plot (1:10, type = "n")
text (1:10, LETTERS [1:10], col = 1:10, cex = 1:10)


##4.3 manipulate パッケージ
manipulate (plot (1:10, col = myColors),
            myColors = pickers ("red", "green", "blue"))

manipulate(
  plot (cars, xlim = c (x.min, x.max), type = type, 
        axes = axes, ann = label),
  x.min = slider (0,15),
  x.max = slider (15,30, initial = 25),
  type = picker ("p", "l", "b", "c", "o", "h", "s", "S", "n"),
  axes = checkbox (TRUE, "Draw Axes"),
  label = checkbox (FALSE, "Draw Labels")
  )


##4.4 高水準グラフィックス関数

plot (cars, type = "h")
dev.off()

# plot (cars, type = "p")

## 4.5 散布図
cars $ speed2 <-  speed * 1.6
cars $ dist2 <- dist * 0.3
head (cars)

cars <- transform (cars, speed2 = speed * 1.6, dist2 = dist * 0.3)

plot (dist2 ~ speed2, data = cars2,
       main = "速度と停止距離の関係",
       sub = "datasets::carsの変数を変換",
       xlab = "速度 (km/h)", ylab = "距離 (m)")

identify (cars2 [, c ("speed2", "dist2")])

text (locator (1), "トヨタ")
text (locator (2), c ("トヨタ", "日産"))

plot (Petal.Width ~ Petal.Length,
       pch = c (Species), col = Species,
       las = 1,  cex = 1.8,  data = iris, 
       xlab  = "花びらの長さ (cm)",
       ylab = "花びらの幅 (cm)")

legend (locator (1),  legend = levels (iris$Species),
         pch = 1:3, col = 1:3,  text.col = 1:3, cex = 1.8)

###4.5.1 拡張パッケージによるプロット

library (lattice)
xyplot (Sepal.Width ~ Sepal.Length,
         groups = Species, data = iris)

pdf (file = "C:/data/Iris.pdf")
xyplot (Sepal.Width ~ Sepal.Length,  groups = Species, data = iris)
dev.off()

library (ggplot2)
p <- ggplot (iris, aes(Sepal.Width, Sepal.Length))
p2 <- p + geom_point(aes(colour = Species))
print (p2)


###4.5.2 棒グラフ
?VADeath

nrow (VADeaths); ncol (VADeaths) # 行数と列数
rownames (VADeaths) 
## [1] "50-54" "55-59" "60-64" "65-69" "70-74"
colnames (VADeaths)

barplot (VADeaths)

barplot (VADeaths, beside = TRUE,
         col = c ("lightblue", "mistyrose", "lightcyan",
           "lavender", "cornsilk"),
         legend = rownames(VADeaths), ylim = c(0, 100))
title (main = "バージニア州の死亡率", font.main = 4)

library (lattice)
barchart (t(VADeaths))
barchart (t (VADeaths), stack = FALSE)

library (reshape) # ファイル・パネルの Packages でも実行可能
x <- melt (VADeaths)
x

library (ggplot2)
p <- ggplot (x, aes (X1, value))
p + geom_bar() + facet_wrap(~X2)

###4.5.3 ヒストグラム
x <- hist (trees$Height)
x
y <- hist (trees$Height, break = c (60, 70, 80, 90))

nclass.Sturges

log2 (c (1,2,4,8,16,32))

nclass.Sturges(trees$Height)

###4.5.4 箱ヒゲ図

x <- boxplot (trees$Height)
x
76 + (8 * 1.58 / sqrt (31))
## [1] 78.27021
76 - (8 * 1.58 / sqrt (31))

y <- boxplot (count ~ spray, data = InsectSprays,
              col = "lightgray")
y

bwplot (count ~ spray, data = InsectSprays)

p <- ggplot(InsectSprays, aes (spray, count))
p + geom_boxplot()

##4.6 プロット記号やカラーの指定

library(grid)
grid.rect (gp = gpar(col = "grey"))
> for (i in 1:nrow) {
   for (j in 1:ncol) {
     x <- unit(j/(ncol+1), "npc")
     y <- unit(i/(nrow + 1), "npc")
     pch <- (i - 1) * ncol + j - 1
     if (pch > 25) 
       pch <- c ("A", "b", ".", "#")[pch - 25]
     grid.points(x + unit(3, "mm"), y, 
       pch = pch, gp = gpar(fill = "yellow", cex = 2))
     grid.text(pch, x - unit(4, "mm"), y,
               gp = gpar(col = "grey", cex = 1.4))
   }
 }

plot (1:10, col = 1:10, cex = 12.0, pch = 19)

length (colors())
## [1] 657
colors()[1:10]


###4.6.1 線分

plot (1:10, cex = 12.0)
lines (c (1,5), c(1,5), lwd = 5.0, col = "blue")
lines (c (6,10), c(6,8), lwd = 5.0, lty = 3)

## プロットの保存

library (ggplot2)
p <- ggplot(iris, aes(Sepal.Width, Sepal.Length))
p2 <- p + geom_point(aes(colour = Species))
print (p2)

par (family = "Japan1")  # Windows 
# par (family = "Osaka") # Mac OS X
