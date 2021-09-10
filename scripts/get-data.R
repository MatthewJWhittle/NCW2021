install.packages("jsonlite")

paths <- jsonlite::read_json("data/data-paths.json")

for(path in paths){
    download.file(url = path$remote, destfile = path$local)
}
