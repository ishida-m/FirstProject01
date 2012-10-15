##　『Rで学ぶデータ・プログラミング入門―RStudioを活用する― 共立出版 付録ファイル

http://www.kyoritsu-pub.co.jp/bookdetail/9784320110298

本書の内容について，更新情報を以下に公開しています．

https://github.com/ishida-m/FirstProject01

誤植などの出版後の最新情報は Info.pdf ファイルにまとめています．

質問などの問い合わせは

ishida-m@ias.tokushima-u.ac.jp

までお送り下しさい．


#######################

# 添付の dot.Rprofile.txt について
Rはホームフォルダ（Windowsでは「C:/Users/ユーザ名」フォルダ，Mac では「/Users/ユーザ名」フォルダ）に
.Rrofile という名前のファイルが存在すると，起動時に読み込んで，初期の環境設定を行います．
Windowsの場合，dot.Rprofile.txt を一度メモ帳などで開き，「別名で保存する」を選び，ファイルの種類は「すべてのファイル」と指定して，.Rrofile と変更してフォルダに保存します．
Macの場合，ドットで始まるファイルを作成するには，ターミナルを使うのが簡単です．まずdot.Rprofile.txtを「/Users/ユーザ名」にコピーしておきます．
次にターミナルを起動して，以下のように入力して，ファイル名を変更します．

mv  dot.Rprofile.txt  .Rprofile




# 第3章ルビを取るプログラム
scriptフォルダに含まれる
Aozora_Win.R （Windowsユーザー向け）ないし Aozora_UTF8.R （Macユーザー向け）
を利用して下さい．

利用方法は，まずスクリプトを source() 関数で読み込み，
つづいて青空文庫からダウンロードしたファイルを指定して実行します．

 source("C:/Users/ishida/Documents/data/script/Aozora_Win.R")

 Aozora_Win ("C:/Users/ishida/Documents/data/対象ファイル名")


実行すると，もとのファイル名に "-u.txt" ないし "-w.txt" を付加したファイルが
同じ場所に保存されています．

なお，本スクリプトは簡易的な処理を行なっていますので，
形態素解析にかける前に，変換されたファイルを開いて内部を確認して下さい．


# 付録A.2
本書のスクリプトを Github に公開しています．
ただし，登録ファイルはShift-JISになっています．
UTF-8で利用するユーザーは，レポジトリをいったん取り込んだ後，
フォルダ内の全ファイルをUTF-8に変換した上，念のためRStudioを起動し，
本書26ページの手順で，プロジェクト全体のコード設定をUTF-8に変更して下さい．

なお文字コードの変換方法の一つとして以下を手順を行なって下さい．
たとえばレポジトリから取り込んだFirstProject01がホームフォルダ（/User/ishida）
にあるとします．本書のscriptフォルダにある CP932toUTF8.sh をホームフォルダに
コピーし，以下のように実行します

  cd ~
  chmod 755 CP932toUTF8.sh
  ./CP932toUTF8.sh


