 
install.packages("jsonlite")
install.packages("httpuv")
install.packages("httr")
 
 library(jsonlite)
 library(httpuv)
 library(httr)
 
 # Can be github, linkedin etc depending on application
 oauth_endpoints("github")
 # Change based on your appname, key, and secret 
 myapp <- oauth_app(appname = "MyApp",
            key = "d315987cc4001edb6fa7",
            secret = "137c8d9dd174ce6e44cc363a1135d09d27246558")
 
 # Get OAuth credentials
 github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# Use API
 gtoken <- config(token = github_token)
 req <- GET("https://api.github.com/users/jtleek/repos", gtoken)

 # Take action on http error
 stop_for_status(req)
 
 # Extract content from a request
 json1 = content(req)
 
 # Convert to a data.frame
 gitDF = jsonlite::fromJSON(jsonlite::toJSON(json1))
 
 # Subset data.frame
 gitDF[gitDF$full_name == "jtleek/datasharing", "created_at"] 