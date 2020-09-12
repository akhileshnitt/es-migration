# es-migration

create movies schema

```
curl -H "Content-Type: application/json" -XPUT http://localhost:9200/movies -d '
{
	"mappings": {
		"movie": {
			"properties": {
				"year": { "type": "date"}
			}
		}
	}
}'
```
check mapping 
```
http://localhost:9200/movies/_mapping?pretty
{
  "movies" : {
    "mappings" : {
      "movie" : {
        "properties" : {
          "genre" : {
            "type" : "text",
            "fields" : {
              "keyword" : {
                "type" : "keyword",
                "ignore_above" : 256
              }
            }
          },
          "title" : {
            "type" : "text",
            "fields" : {
              "keyword" : {
                "type" : "keyword",
                "ignore_above" : 256
              }
            }
          },
          "year" : {
            "type" : "date"
          }
        }
      }
    }
  }
}
```
add movie data

```
curl -H "Content-Type: application/json" -XPUT http://localhost:9200/movies/movie/109487 -d '
{
		"genre": ["Sci-Fi","IMAX"],
		"title": "Interstellar",
		"year": 2014
}'

curl -H "Content-Type: application/json" -XPUT http://localhost:9200/movies/movie/109487 -d '
{
		"genre": ["Horror"],
		"title": "Tumbad",
		"year": 2020
}'
````


Create new movies schema , where we will migrate move

```
curl -H "Content-Type: application/json" -XPUT http://localhost:9200/movies_new -d '
{
	"mappings": {
		"movie": {
			"properties": {
				"year": { "type": "date"},
				"hero": { "type": "text"}
			}
		}
	}
}'
```

check mapping 
```
{
  "movies_new" : {
    "mappings" : {
      "movie" : {
        "properties" : {
          "genre" : {
            "type" : "text",
            "fields" : {
              "keyword" : {
                "type" : "keyword",
                "ignore_above" : 256
              }
            }
          },
          "hero" : {
            "type" : "text"
          },
          "title" : {
            "type" : "text",
            "fields" : {
              "keyword" : {
                "type" : "keyword",
                "ignore_above" : 256
              }
            }
          },
          "year" : {
            "type" : "date"
          }
        }
      }
    }
  }
}
