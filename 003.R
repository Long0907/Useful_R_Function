library("tm")
library('SnowballC')
library("wordcloud")
library("RColorBrewer")
filepath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
text <- readLines(filepath)

docs <- Corpus(VectorSource(text))

#replacing "/, @, | with space.
toSpace <- content_transformer(function(x, pattern) gsub(pattern, "", x))

docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")

#clean your text

docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)

#remove common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))

#you can also remove your own stop words

#docs <- tm_map(docs, removeWords, c("blasz1", "blaz 2"))

#remove punctuations
docs <- tm_map(docs, removePunctuation)

#Eliminate extra white spaces
docs <- tm_map(docs, stripWhitespace)

#text stemming

docs_1 <- tm_map(docs, stemDocument)


#build a term-document matrix

dtm <- TermDocumentMatrix(docs_1)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = T)
d <- data.frame(word=names(v), freq=v)
head(d, 10)


set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words = 200, random.order = F, rot.per = 0.35,
          colors = brewer.pal(8, "Dark2")) #random.order=F put most frequent word in the middle. 


barplot(d[1:10,]$freq, las = 2, names.arg = d[1:10,]$word,
        col = 'lightblue',main = "Most frequent words",
        ylab="Word frequencies")



findFreqTerms(dtm, lowfreq = 5)



















