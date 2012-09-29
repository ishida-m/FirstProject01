# USAGE:
# source ("Aozora_UTF8.R")
# Aozora_UTF8("test.txt")

Aozora_UTF8<- function(x){  
  if(!file.exists (x)) stop ("specify file!")
#  tmp <- 1
  con <- file(x, 'r', encoding = "CP932" )
  outfile <- file(paste(x, "-u.txt", sep = ""), 'w', encoding = "utf8")
  flag <- 0;
  while (length(input <- readLines(con, n=1, encoding = "CP932")) > 0){
    if (grepl("^��{", input)) break ;
    if (grepl("�y���͎Ғ��z", input)) break;
    if (grepl("^------", input)) {
      flag <- !flag
      next;
    }
    if (!flag){
      input <- gsub ("�m��[^�n]*�n", "", input, perl = TRUE)
      input <- gsub ("�s[^�t]*�t", "", input, perl = TRUE)
      input <- gsub ("�b", "", input, perl = TRUE)
      writeLines(input, con=outfile)
#      tmp <- tmp +1
#      if (tmp > 100) stop ("something wrong")
    }
  }
  close(con); close(outfile)  
}