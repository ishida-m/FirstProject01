# 2.1 R言語とデータ構造


###2.1.1 四則演算
1 + 1
2 - 2
3 * 3
4 / 4


(1 + 2) * 3  / 4    ;    1 * 2 / (3 - 2 + 1)

1:10
1:10 + 1

# 途中で改行するが，式は続く
1 + 2 + 3 +
  4 + 5 + 6

###2.1.2 変数あるいはオブジェクト
x <- c (1.0, 1.2, 1.3)
x
x * 10
y <- 石田基広
y <- "石田基広"
y

# オブジェクト名には日本語も使える（推奨はしない）
 (石田 <- "基広" ) # 丸括弧を使って代入と同時に中身を表示
_underBar <- 5
 $4 <- 5
 if <- 1

LETTERS
letters

##### コラム：文字コードとバイト
 charToRaw("あ")
 0x82
 0xa0
#####

# 2.2 添字
LETTERS [1:5]
LETTERS [ c (1, 3, 5, 20:26)]

z <- 1:30
z [1:5]
z [c (1, 3, 5, 25:30) ]

##### コラム：余計な半角スペース
 x <- 1
 x < - 3
#####

# アルファベット大文字の最後の３つだけを抽出
LETTERS [ - (1:23)] #この場合丸括弧が必要

# 犬の名前をベクトルにする
dogs <- c ("モモ", "チョコ", "マロン", "ナナ")
# その犬種を名前として情報登録する
names (dogs) <- c ("チワワ", "コーギ", "柴犬", "コーギ" ) ; dogs
dogs ["コーギ"]


## 2.3 関数について

x <- 1:100       # 1, 2, 3, ..., 98, 99, 100 のベクトル
sum (x)          # 合計

mean (x)         # 平均

y <- 1:3         # 1,2,3 のベクトル
rep (y, 3)       # 3 回繰り返す

z <- c ("A", "B", "C")   # アルファベット三つのベクトル
rep (z, 5)               # 5 回繰り返す

seq (10)                        # 1 から 10 までの整数の列

seq (from = 0, to = 10, by = 2) # 間隔を 2 としたベクトル

seq (0, 10, 3)                  # 間隔を 3 としたベクトル

seq (0, 1, 0.1)                 # 間隔を 0.1 としたベクトル


## 2.4 ヘルプの参照
help.search ("sequence")

##### コラム：Rでのヘルプ表示
 ?seq   # この行を実行する
#####


## 2.5 関数の応用
x <- 1:6
sample (x, 1)

sample (x, 10)
# 以下にエラー sample(x, 10) : 
#   'replace = FALSE' なので、母集団以上の大きさの標本は取ることができません 
sample (x, 10, rep = TRUE)

kuji <- c ("大吉", "中吉", "小吉") # 札を用意
kuji
# [1] "大吉" "中吉" "小吉"
sample (kuji, 1)                   # おみくじを引く
# [1] "中吉" 
# おみくじの出現確率を調整
sample (kuji, 1, prob = c (1/10, 2/10, 7/10) )

x <- sample (kuji, 10000, rep = T,  prob = c(1/10, 2/10, 7/10) )
(z <- table (x) )
# x
# 小吉 大吉 中吉 
# 7002  963 2035 
barplot (z)


## 2.6 データ型とデータ構造
###2.6.1 データ型
# 実数
(x <- 1)
# [1] 1
typeof (x)
# [1] "double"
# 整数
(y <- 1L)
# [1] 1
typeof (y)
# [1] "integer"

(x <- 1 + 2i)


x <- 'あいう'
y <- "DEF"

LETTERS
letters

paste (LETTERS, collapse = "")
# [1] "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

strsplit (x, "")
## [[1]]
## [1] "あ" "い" "う"

x <- c ("男", "女")
x
## [1] "男" "女"
class (x)
## [1] "character"
xf <- as.factor (x)
xf
## [1] 男 女
## Levels: 女 男
class (xf)
## [1] "factor"


str (xf)
## Factor w/ 2 levels "女","男": 2 1

x <- 5
x >= 3
## [1] TRUE

x <- 1:5
x <= 3; x < 3; x > 3; x == 3; x != 3
## [1]  TRUE  TRUE  TRUE FALSE FALSE
## [1]  TRUE  TRUE FALSE FALSE FALSE
## [1] FALSE FALSE FALSE  TRUE  TRUE
## [1] FALSE FALSE  TRUE FALSE FALSE
## [1]  TRUE  TRUE FALSE  TRUE  TRUE

sum (x >= 3)
## [1] 3


y <- c ("A", "B", "C")
y == "B"
## [1] FALSE  TRUE FALSE


z <- c ("A", "B", "O", "AB", "A", "B", "O", "AB")
z == c ("AB", "B")
## [1] FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE


z == c ("AB", "B", "AB", "B", "AB", "B", "AB", "B")
## [1] FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE


z %in% c ("AB", "B")
# [1] FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE
sum ( z %in% c ("AB", "B") )
## [1] 4
which ( z %in% c ("AB", "B") )
## [1] 2 4 6 8


dogs [names (dogs) %in%  "コーギ"]
##   コーギ   コーギ 
## "チョコ"   "ナナ"

###2.6.2 データ構造

head (sleep)
##   extra group ID
## 1   0.7     1  1
## 2  -1.6     1  2
## 3  -0.2     1  3
## 4  -1.2     1  4
## 5  -0.1     1  5
## 6   3.4     1  6


summary (sleep)
 ##     extra        group        ID   
 ## Min.   :-1.600   1:10   1      :2  
 ## 1st Qu.:-0.025   2:10   2      :2  
 ## Median : 0.950          3      :2  
 ## Mean   : 1.540          4      :2  
 ## 3rd Qu.: 3.400          5      :2  
 ## Max.   : 5.500          6      :2  
 ##                         (Other):8


x <- data.frame (Num = 1:5, Cha = LETTERS[1:5])
x
##   Num Cha
## 1   1   A
## 2   2   B
## 3   3   C
## 4   4   D
## 5   5   E 
x $ Num
## [1] 1 2 3 4 5
x $ Cha
## [1] A B C D E
## Levels: A B C D E


x $ New <- c ("あ", "い", "う", "え", "お")
nrow (x)
## [1] 5
ncol (x)
## [1] 3
x
##   Num Cha New
## 1   1   A  あ
## 2   2   B  い
## 3   3   C  う
## 4   4   D  え
## 5   5   E  お
str (x)       # 構造を確認
## 'data.frame':	5 obs. of  3 variables:
##  $ Num: int  1 2 3 4 5
##  $ Cha: Factor w/ 5 levels "A","B","C","D",..: 1 2 3 4 5
##  $ New: chr  "あ" "い" "う" "え" ...

x [1:3, c (1,3)]
##   Num New
## 1   1  あ
## 2   2  い
## 3   3  う


x [1:3, -2]      # 2 列目をのぞく
##   Num New
## 1   1  あ
## 2   2  い
## 3   3  う


# 列優先
(x <- matrix (1:9, ncol = 3))
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9


# 行優先
(y <- matrix (1:9, ncol = 3, byrow = TRUE))
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9

# 要素数が指定行・列数の倍数ではない
(z <- matrix (c (2,5,7), nrow = 2))
##      [,1] [,2]
## [1,]    2    7
## [2,]    5    2
##  警告メッセージ： 
## In matrix(c(2, 5, 7), nrow = 2) :
##    データ長 [3] が行数  [2] を整数で割った、もしくは掛けた値ではありません  


(x <- matrix (1:9, ncol = 3))
##      [,1] [,2] [,3]
## [1,]    1    4    7
## [2,]    2    5    8
## [3,]    3    6    9

t(x)  # 転置
##      [,1] [,2] [,3]
## [1,]    1    2    3
## [2,]    4    5    6
## [3,]    7    8    9


HairEyeColor
## , , Sex = Male

##        Eye
## Hair    Brown Blue Hazel Green
##   Black    32   11    10     3
##   Brown    53   50    25    15
##   Red      10   10     7     7
##   Blond     3   30     5     8

## , , Sex = Female

##        Eye
## Hair    Brown Blue Hazel Green
##   Black    36    9     5     2
##   Brown    66   34    29    14
##   Red      16    7     7     7
##   Blond     4   64     5     8



HairEyeColor [ , , Sex = "Female"]
##        Eye
## Hair    Brown Blue Hazel Green
##   Black    36    9     5     2
##   Brown    66   34    29    14
##   Red      16    7     7     7
##   Blond     4   64     5     8



HairEyeColor ["Black" , , ]
##        Sex
## Eye     Male Female
##   Brown   32     36
##   Blue    11      9
##   Hazel   10      5
##   Green    3      2


x <- lm (dist ~ speed, data = cars)
str (x)
## List of 12
##  $ coefficients : Named num [1:2] -17.58 3.93
##   ..- attr(*, "names")= chr [1:2] "(Intercept)" "speed"
##  $ residuals    : Named num [1:50] 3.85 11.85 -5.95 12.05 2.12 ...
##   ..- attr(*, "names")= chr [1:50] "1" "2" "3" "4" ...
## ．．．中略
##  - attr(*, "class")= chr "lm"
## > x [[1]]
## (Intercept)       speed 
##  -17.579095    3.932409 

x [[1]]
x $ coefficients
## (Intercept)       speed 
##  -17.579095    3.932409 
x [[1]][1]
## (Intercept) 
##   -17.57909 
coef (x)

str (x [[1]])
 ## Named num [1:2] -17.58 3.93
 ## - attr(*, "names")= chr [1:2] "(Intercept)" "speed"

x [[1]][1]
## (Intercept) 
##   -17.57909 

x $ coefficients [1]
## (Intercept) 
##   -17.57909 


is.list (x)
## [1] TRUE


is.vector (LETTERS)
## [1] TRUE
is.data.frame (iris) # irisはあやめのデータ
## [1] TRUE
