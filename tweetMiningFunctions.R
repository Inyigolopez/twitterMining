
countNumberOfDictionaryWord <- function(tweet, dictionary ){
        numeroPalabras <- 0;
        tweetWords <- strsplit(tweet, split=" ")       
        for(i in 1:length(dictionary) ){
                for(j in 1:length(tweetWords[[1]] )){
                        if( identical( tweetWords[[1]][j], dictionary[i])){
                                numeroPalabras <- numeroPalabras + 1;    
                        }
                }
        }
        numeroPalabras                       
}

tryTolower <- function(x){        
        # tryCatch error
        try_error <- tryCatch(tolower(x), error = function(e) e)
        # if not an error
        if (!inherits(try_error, "error")){
                y <- tolower(x)
        }else{
                y <- x
        }
        y
}