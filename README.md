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
```
Now run curator to migrate from movies to moview_new
```
./migration-script_movie.sh
```

Insert Data into new schema
```
curl -H "Content-Type: application/json" -XPUT http://localhost:9200/movies_new/movie/234325462 -d '{
"genre": ["Horro"],
"title": "bhoot",
 "year": 2020,
 "hero": "bh"
}'
```

Verify new index in Elastic Head

```
dex
_type
_id
▲
_score
title
year
hero
movies_new
movie
109487
1
Interstellar
2014
movies_new
movie
234325462
1
bhoot
2020
bh
movies_new
movie
12345
1
tumbaad
2020

