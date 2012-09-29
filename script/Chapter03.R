# 第3章

## 3.1 条件文
x <- 8
if (x <5) print("はい") else print ("いいえ")

if (x >= 5)
  "はい"
else
  "いいえ"

if (x >= 5){
  "はい"
} else {
  "いいえ"
}

x <- 11
if (x <= 5){
  "5以下です"
} else if (x <= 10) {
  "5より大きく10以下"
} else {
  "10を超えます"
}

x <- 1:10
if (x < 5) print ("X < 5") else print ("x >= 5")

ifelse(x > 5, "YES", "NO")

y <- ifelse(x > 5, 
       {cat("YES"); print (x / 10)},
       {cat ("NO"); print (x * 10)}
)
# コードの意図は5より大きい数値だけを対象に10でわった値を返す
y

x <- 2
y <- 3
z <- "*"
switch (z,
        "+" = {print("足し算を実行します"); x + y},
        "-" = {print("引き算を実行します"); x - y},
        "*" = {print("掛け算を実行します"); x * y},
        "/" = {print("割り算を実行します"); x / y},
        "加減乗除だけできます"
        )

## 3.1.1
# なおRおよびRStudioでは円マークはバックスラッシュで表示されます
for (i in 1:5){
  cat (i, "回目の実行\n")
}

for (i in c ("春","夏","秋","冬")){
  print (i)
}

x <- 1:100
i <- 0
for (j in x) {
  i <- i + j
}


### 3.1.2
i <- 0
while ( i < 100){
  i <- i+ 1
}

print (i)

### 3.1.2
i <- 0
while ( i < 100){
  i <- i+ 1
  if (i %% 10 != 0) next
  if (i %% 90 == 0){
    cat ("\n")
    break
  }
  cat (i, "\t")
}

### 3.1.3
set.seed (1)
x <- 1:6
res <- numeric (1000)
for (i in 1:1000) {
  tmp <- sample (x, 100, rep = T)
  res [i] <- sum (tmp)
}
mean (res)

##### コラム；乱数
  runif (1)
  runif (3)
  set.seed (123)
  runif (1)
  runif (3)
  set.seed (123) # 同じ整数をタネとして再設定
  runif (1)
  runif (3)


##### コラム：平均値と大数の法則
   1 * 1/6 + 2 * 1/6 + 3 * 1/6 + 4 * 1/6 + 5 * 1/6 + 6 * 1/6
   x <- 1:6; sum (x * (1/6))
   
## 3.2
myName <- function () {
  print ("石田基広")
}

myName
myName()

myPlus <- function (x = 0, y = 1) {
  x + y
}
myPlus ()
myPlus (x = 2)
x <- myPlus (2, 3)


##### コラム：オブジェクトの有効範囲
z <- 10
func <- function (){
  z <- 3
  print (z)
}

func ()
z


## 3.3 応用
sample (x = 1:face, size = toss, rep = TRUE)

dice <- function (face, toss){
  sample(x = 1:face, size = toss, rep = TRUE)
}

dice (6, 10)

dice ()


###3.3.1 エラーの予防

dice <- function (face = 6, toss = 1){
  sample(x = 1:face, size = toss, rep = TRUE)
}


dice (to = 3)
dice (0)

dice <- function (face = 6, toss = 1){
  if (face < 2 || toss < 1) stop ("引数が不正です")
  sample(x = 1:face, size = toss, rep = TRUE)
}

dice (1)

dice <- function (face = 6, toss = 1){
  stopifnot  (face > 1,toss > 0)
  sample(x = 1:face, size = toss, rep = TRUE)
}

dice (to = 0)

## 3.4 ベクトル演算
x <- 1:10
x + 1

sum (x)
mean (x)

x <- matrix (1:9, nrow = 3)
rowSums (x)
colSums (x)

tmp <- 0
for (i in 1:3){
  for (j in 1:3) {
    tmp <- tmp + x [i, j]
  }
  print (tmp)
  tmp <- 0
}

tmp <- 0
for (i in 1:3){
  for (j in 1:3) {
    tmp <- tmp + x [j, i]
  }
  print (tmp)
  tmp <- 0
}

apply (x, 1, sum)
apply (x, 2, sum)

apply (x, 1, "+", 100)    # ＋演算子と組み合わせる
apply (x, 2, paste, "番", sep = "") # paste()とその引数
apply (x, 1, function(z){z + z*10 + z * 100}) #無名関数

tmpf <-  function(z){z + z*10 + z * 100}
apply (x, 1, tmpf)

lapply (x, "+", 1) #リスト(List)を返り値とする
sapply (x, "+", 1) #シンプル (simple) な返り値にする

(xx <- list (x1 = x, x2 = x * 10)) #行列二つを要素とするリスト
lapply (xx, mean)   #リストの要素ごとの平均

sapply (xx, mean)   # 結果をベクトルで返す

## 3.5 オブジェクト指向
methods (plot)
getS3method (f = "plot", class = "histogram")

###3.5.1 S3クラス
# 通常の文字オブジェクト
x <- "A"
print (x)

# 独自のメソッドを定義
print.str <- function (x) {
   cat ("x = ", x, "; charToRaw (x) = ", charToRaw (x), "\n");
}
 # オブジェクトのクラスを設定
class (x) <- "str"
 # メソッドを呼び出す
print (x)
## x =  A; charToRaw (x) =  41


###3.5.2 S4クラス
setClass (Class = "family",
          representation (mother = "character",
                          father = "character",
                          children = "numeric"),
          prototype (mother = "母", father =  "父",
                     children = 0) )

fm1 <- new ("family", mother = "花子", father = "一郎",
             children = 3)
fm1

setMethod (f = "show", signature = "family",
            function (object) {
            # 父親と母親だけ表示
            cat (object@father, object@mother, "\n")
 } )

setValidity ("family", function (object) {
   if (nchar (object@mother) < 1 | nchar (object@father) < 1 )
     return (FALSE) 
 })

fm2 <- new ("family",  mother = "", father = "", children = 3  )
print (i)


fm1 <- new ("family", mother = "花子",
               father = "一郎", children = 3)
fm1


## 3.6 Rで遊ぶ

###3. 6.1 九九表の作成
A1 <- 1:9
A2 <- 1:9
A1 * A2

as.matrix (A1) # 行列に変換

# 転置する
t (A2)
##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
## [1,]    1    2    3    4    5    6    7    8    9
class (t (A1)) # クラスは行列
## [1] "matrix"
# 行列積を計算
A1 %*% t (A2)
 ##      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
 ## [1,]    1    2    3    4    5    6    7    8    9
 ## [2,]    2    4    6    8   10   12   14   16   18
 ## [3,]    3    6    9   12   15   18   21   24   27
 ## [4,]    4    8   12   16   20   24   28   32   36
 ## [5,]    5   10   15   20   25   30   35   40   45
 ## [6,]    6   12   18   24   30   36   42   48   54
 ## [7,]    7   14   21   28   35   42   49   56   63
 ## [8,]    8   16   24   32   40   48   56   64   72
 ## [9,]    9   18   27   36   45   54   63   72   81

outer (A1, A1, "*")
outer (A1, A1, "+")

paste (1:9, 1:9, sep = "*")
outer (1:9, 1:9,  paste, sep = "*")

paste( outer (1:9, 1:9,  paste, sep = "*"), outer (1:9, 1:9, "*"), sep = "=")


##### コラム：Rのオプション指定
options ()
getOption ("digits")
0.123456789012         # 表示幅を超える入力
options (digits  = 12) # 表示幅を広げる
0.123456789012         # 表示幅を超える入力
options (digits  = 7) # もとに戻す
#####

### 3.6.2 連番の作成

x <- c ("加藤", "佐藤", "鈴木", "田中", "野田")
y <- c (100, 90, 80, 70, 60)
xy <- data.frame (Name = x, Score = y)
xy

 (tmp <- paste ("student", 1:5, sep = "-"))
#[1] "student-1" "student-2" "student-3" "student-4" "student-5"
xy $ ID <- tmp  
xy


names (xy)
## [1] "Name"  "Score" "ID"   
xy2 <- xy [ , c ("ID", "Score")]
xy2

xy $ Sex <- c ("F", "M", "M", "F", "F")
xy

(tmp <- paste (xy$Sex, 1:5, sep = "-"))
## [1] "F-1" "M-2" "M-3" "F-4" "F-5"
xy $ Id <- tmp
xy


### 3.6.3 組み合わせの作成

female <- c ("陽菜", "結愛", "結衣", "杏", "莉子")
male <-  c ("大翔", "蓮", "颯太", "樹", "大和")
paste (sample (female, 5) , sample(male, 5) , sep = "＋")

# 絵柄（を示すアルファベット大文字）を用意
mark <- c ("H", "C", "D", "S")
# 数字を用意
suji <- c("A", 2:10, "J", "Q", "K")
suji # 中身を確認

cards <- outer (mark, suji, "paste", sep = "-")
cards <- c (cards, "Joker") # 最後にジョーカーを 1 枚足す
length (cards) # 結局枚数は?
## [1] 53
cards # 中身を確認
sample(cards, 5)


## 3.7 文字処理
index <- "A CERTAIN MAGICAL INDEX" # これは文字列としては1個
length (index) # 1個の文字列
## [1] 1
nchar (index)# 文字列の文字数
## [1] 23
# 二つの文字列を要素とするベクトル
x <- c ("ABC", "efghi")
length (x)
## [1] 2
nchar (x)

tolower(index)  # 大文字を小文字に変換
## [1] "a certain magical index"
toupper (x)     # 小文字を大文字に

# Lewis Carroll Alice's Adventures in Wonderland
alice <-  c ("Alice was beginning to get very tired of sitting by her sister on the bank",
               "and of having nothing to do:")
length (alice)
## [1] 2
nchar (alice)
## [1] 74 28
strsplit (alice, " ") # 文字列を空白で切り取ってベクトル化する

alice2 <- unlist (strsplit (alice, " ")) # 結果のリストをベクトルに変換
alice2
##  [1] "Alice"     "was"       "beginning" "to"        "get"       "very"     
##  [7] "tired"     "of"        "sitting"   "by"        "her"       "sister"   
## [13] "on"        "the"       "bank"      "and"       "of"        "having"   
## [19] "nothing"   "to"        "do:"
length (alice2)  # 語数は

table (alice2) # 頻度表を作成

as.data.frame (table (alice2))

alice3 <- readLines (file ("http://www.gutenberg.org/files/11/11.txt"))
###### なお，以下の操作による出力において，表示の順番や合計などが，
###### 本書の記載内容と異なることがあるかもしれません．

head (alice3, 50)
grep ("THE END", alice3)
alice3 [3365:3375]


alice3 <- alice3 [41:3370]
head (alice3)

tail (alice3)

alice.vec <- unlist (strsplit (alice3, split = "[[:space:]]+|[[:punct:]]+"))
length (alice.vec)



##### コラム：正規表現
texts <- "太郎くんの電話番号は 123-456-7890，次郎くんの電話番号は 321-654-0987, 花子さんの電話番号は 135-246-8709 です"
gsub ("[0-9]{3}-[0-9]{3}-[0-9]{4}", "XXX-XXX-XXXX", x = texts)

gsub ("[0-9]{3}-[0-9]{3}-[0-9]{4}", "XXX-XXX-XXXX",   x = texts)
#####


head (alice.vec)
sum (alice.vec == "")

# 分割結果が空の場合 ("") となる結果を除いて，ベクトルを再構成
alice.vec <- alice.vec [alice.vec != ""]
# 解析結果の長さ，つまり総単語数を求める
length(alice.vec)


sum (alice.vec == "the")


alice.freq <- as.data.frame (table (alice.vec))
alice.sorted <- alice.freq [order (alice.freq$Freq, decreasing = TRUE), ]
head (alice.sorted)
rownames (alice.sorted)[1:5]
## [1] "2515" "83"   "2593" "1"    "1209"
# 行数は語彙数
nrow (alice.sorted)


##### コラム：order()関数の働き

x <- c (3, 1, 2, 5, 4)
sort (x)

x <- c (3, 1, 2, 5, 4)
order (x) # 並びかえた場合の，もとの位置番号
## [1] 2 3 1 5 4
# 最小値である1はベクトルの2番目の要素 
x [order(x)]

set.seed (123)  # 乱数を設定する
x <- sample (1:3, 10, rep = TRUE) 
y <- sample (1:3, 10, rep = TRUE)
(alpha <- sample (LETTERS[1:3], 10, rep = TRUE)) 
##  [1] "C" "C" "B" "C" "B" "C" "B" "B" "A" "A"
(x.y <- data.frame (name = alpha, x = x, y = y))

# orderを使って並び換え
x.y [order(x.y$name, x.y$x, x.y$y), ]
#####

alice.sorted2 <- alice.freq [order (alice.freq$alice.vec),]
head (alice.sorted2)

alice.sorted2 [grep ("swim", alice.sorted2$alice.vec), ]

# install.packages ("Snowball") # インストール
# library (Snowball)            # ロード 
# stemming を実行
alice.sn <- SnowballStemmer(tolower (alice.vec))
# 頻度表を作成
alice.sn.freq <- as.data.frame (table (alice.sn))
alice.sn.sorted <- alice.sn.freq [order (alice.sn.freq$alice.sn),]
head (alice.sn.sorted)

sum(alice.sn.sorted$Freq)
## [1] 27329
sum (alice.sorted$Freq)

which(alice.sn == "")
alice.sn[610:620]

nrow (alice.sn.sorted)


## 3.8 日本語処理
###### なお，以下の操作による出力において，表示の順番や合計などが，
###### 本書の記載内容と異なることがあるかもしれません．

library (RMeCab)
setwd ("C:/data")

res <- RMeCabC ("ご飯を食べた", 1)
unlist (res)

dazai <- docDF ("merosu.txt")
head (dazai)
tail (dazai)


dazai <- docDF("merosu.txt",type = 1)
head (dazai)
tail (dazai)

# 検索する
dazai2 <- dazai [(dazai$POS1 %in% c("名詞","形容詞")), ]
nrow (dazai2)
## [1] 704

# 解析時に指定する
dazai <- docDF ("merosu.txt", type = 1, pos = c("名詞","形容詞"))
head (dazai [order(dazai$merosu.txt, decreasing = TRUE),], 10)
