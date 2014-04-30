
library(bitops)
library(RCurl)
library(digest)
library(ROAuth)
library(rjson)
library(twitteR)
library(tm)
library(Rcpp)
library(RColorBrewer)
library(wordcloud)
library(SnowballC)

source("tweetMiningFunctions.R")

#OBTENER AUTENTICACION TWITTER
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
reqURL <- "https://api.twitter.com/oauth/request_token"
accessURL <- "https://api.twitter.com/oauth/access_token"
authURL <- "https://api.twitter.com/oauth/authorize"
apiKey <- "zUwcCwYi1lvL33n5iNYEuA"
apiSecret <- "Eyqz5Gs1mmmkUEMUCDcDkt7IcwMXGMtoX43524zciMs"
twitCred <- OAuthFactory$new(consumerKey=apiKey,consumerSecret=apiSecret,requestURL=reqURL,accessURL=accessURL,authURL=authURL)

## Ejecutar esta linea y esperar la url de autenticacion de la app.Introducir el el navegador,
## autorizar, copiar el numero de autorizacion y pegar
twitCred$handshake(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
##
registerTwitterOAuth(twitCred)
#FIN AUTENTICACION

# Lee los diccionarios
runner.dictionary <- tolower(readLines("dictionarys/runner.txt",encoding="UTF-8"))
divorced.dictionary <- tolower(readLines("dictionarys/divorced.txt",encoding="UTF-8"))
foodLovers.dictionary <- tolower(readLines("dictionarys/foodLovers.txt",encoding="UTF-8"))
travellers.dictionary <- tolower(readLines("dictionarys/travellers.txt",encoding="UTF-8"))
bobo.dictionary <- tolower(readLines("dictionarys/bobo.txt",encoding="UTF-8"))
dinks.dictionary <- tolower(readLines("dictionarys/dinks.txt",encoding="UTF-8"))
metrosexual.dictionary <- tolower(readLines("dictionarys/metrosexual.txt",encoding="UTF-8"))
mujeralfa.dictionary <- tolower(readLines("dictionarys/mujeralfa.txt",encoding="UTF-8"))
peterpan.dictionary <- tolower(readLines("dictionarys/peterpan.txt",encoding="UTF-8"))
stingly.dictionary <- tolower(readLines("dictionarys/stingly.txt",encoding="UTF-8"))

# Recoge tweets
#tweets = userTimeline("norcoreano", 2000)
tweets <- searchTwitter("gimnasio", n=500)

# vuelca la informacion de los tweets a un data frame
df <- twListToDF(tweets)

# obtiene el texto de los tweets
txt <- df$text

##### inicio limpieza de datos #####
# remueve retweets
txtclean = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", txt)

# remove @otragente
txtclean = gsub("@\\w+", "", txtclean)

txtclean = gsub("#\\w+", "", txtclean)

# remueve simbolos de puntuación
txtclean = gsub("[[:punct:]]", "", txtclean)

# remove números
txtclean = gsub("[[:digit:]]", "", txtclean)

# remueve links
txtclean = gsub("http\\w+", "", txtclean)


txtclean <- sapply(txtclean, tryTolower)
##### fin limpieza de datos #####

#llamada a funcion de comparacion ' sapply(txtclean, countNumberOfDictionaryWord) ' con los distintos diccionarios
tweetRunnerSummWords <- as.data.frame( sapply(txtclean, countNumberOfDictionaryWord, dictionary = runner.dictionary))
tweetDivorcedSummWords <- as.data.frame(sapply(txtclean, countNumberOfDictionaryWord, dictionary = divorced.dictionary))
tweetFoodLoversSummWords <- as.data.frame(sapply(txtclean, countNumberOfDictionaryWord, dictionary = foodLovers.dictionary))
tweetTravellersSummWords <- as.data.frame(sapply(txtclean, countNumberOfDictionaryWord, dictionary = travellers.dictionary))
tweetBoboSummWords <- as.data.frame(sapply(txtclean, countNumberOfDictionaryWord, dictionary = bobo.dictionary))
tweetDinksSummWords <- as.data.frame(sapply(txtclean, countNumberOfDictionaryWord, dictionary = dinks.dictionary))
tweetMetrosexualSummWords <- as.data.frame(sapply(txtclean, countNumberOfDictionaryWord, dictionary = metrosexual.dictionary))
tweetMujeralfaSummWords <- as.data.frame(sapply(txtclean, countNumberOfDictionaryWord, dictionary = mujeralfa.dictionary))
tweetPeterpanSummWords <- as.data.frame(sapply(txtclean, countNumberOfDictionaryWord, dictionary = peterpan.dictionary))
tweetStinglySummWords <- as.data.frame(sapply(txtclean, countNumberOfDictionaryWord, dictionary = stingly.dictionary))

tweetsId <- df$id
tweetsName <- df$screenName

allProfileMatrix <- cbind.data.frame(tweetsId,tweetsName,tweetRunnerSummWords,tweetDivorcedSummWords,tweetFoodLoversSummWords,tweetTravellersSummWords,tweetBoboSummWords,tweetDinksSummWords,tweetMetrosexualSummWords,tweetMujeralfaSummWords,tweetPeterpanSummWords,tweetStinglySummWords)
names(allProfileMatrix) <- c("id_twitter","name_twitter", "runner", "divorced", "foodLoover","traveller", "bobo", "dink", "metrosexual", "mujeralfa", "peterpan", "stingly");
allProfileMatrix
