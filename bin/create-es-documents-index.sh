export ES_HOST="http://localhost:9200"

curl -XDELETE "$ES_HOST/docs_v6"

curl -XPUT "$ES_HOST/docs_v6" -d '
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0,
    "analysis": {
      "filter": {
        "english_stop": {
          "type":       "stop",
          "stopwords":  "_english_"
        },
        "english_light_stemmer": {
          "type":       "stemmer",
          "language":   "light_english"
        },
        "english_possessive_stemmer": {
          "type":       "stemmer",
          "language":   "possessive_english"
        }
      },
      "analyzer": {
        "english_stem_cs": {
          "tokenizer":  "standard",
          "filter": [
            "english_possessive_stemmer",
            "english_stop",
            "english_light_stemmer"
          ]
        },
        "english_stem_ci": {
          "tokenizer":  "standard",
          "filter": [
            "english_possessive_stemmer",
            "lowercase",
            "english_stop",
            "english_light_stemmer"
          ]
        },
        "english_nostem_cs": {
          "tokenizer":  "standard",
          "filter": [
            "english_possessive_stemmer",
            "english_stop"
          ]
        },
        "english_nostem_ci": {
          "tokenizer":  "standard",
          "filter": [
            "english_possessive_stemmer",
            "lowercase",
            "english_stop"
          ]
        }
      }
    }
  },
  "mappings": {
    "doc": {
      "_source": {
        "enabled": true
      },
      "properties": {
        "created": {
          "type": "date",
          "doc_values": true
        },
        "published": {
          "type": "date",
          "doc_values": true
        },
        "discovered": {
          "type": "date",
          "doc_values": true
        },
        "updated": {
          "type": "date",
          "doc_values": true
        },
        "url": {
          "type": "keyword",
          "doc_values": true
        },
        "source": {
          "type": "keyword",
          "doc_values": true
        },
        "status": {
          "type": "keyword",
          "doc_values": true
        },
        "app_ids": {
          "type": "keyword",
          "doc_values": true
        },
        "title": {
          "type": "text",
          "index": true,
          "doc_values": false,
          "fields": {
            "stem_cs": {
              "type": "text",
              "index": true,
              "analyzer": "english_stem_cs"
            },
            "stem_ci": {
              "type": "text",
              "index": true,
              "analyzer": "english_stem_ci"
            },
            "nostem_cs": {
              "type": "text",
              "index": true,
              "analyzer": "english_nostem_cs"
            },
            "nostem_ci": {
              "type": "text",
              "index": true,
              "analyzer": "english_nostem_ci"
            }
          }
        },
        "text": {
          "type": "text",
          "doc_values": false,
          "fields": {
            "stem_cs": {
              "type": "text",
              "index": true,
              "analyzer": "english_stem_cs"
            },
            "stem_ci": {
              "type": "text",
              "index": true,
              "analyzer": "english_stem_ci"
            },
            "nostem_cs": {
              "type": "text",
              "index": true,
              "analyzer": "english_nostem_cs"
            },
            "nostem_ci": {
              "type": "text",
              "index": true,
              "analyzer": "english_nostem_ci"
            }
          }
        }
      }
    },
    "event": {
      "_parent": {
        "type": "doc"
      },
      "_source": {
        "enabled": true
      },
      "properties": {
        "threat": {
          "type": "keyword",
          "doc_values": true
        },
        "attack": {
          "type": "keyword",
          "doc_values": true
        },
        "vector": {
          "type": "keyword",
          "doc_values": true
        },
        "objecttype": {
          "type": "keyword",
          "doc_values": true
        },
        "target": {
          "type": "keyword",
          "doc_values": true
        },
        "created": {
          "type": "date",
          "doc_values": true
        },
        "published": {
          "type": "date",
          "doc_values": true
        },
        "geo_location": {
          "type": "geo_point"
        }
      }
    }
  }
}'

curl -XPOST "$ES_HOST/_aliases" -d '
{
    "actions" : [
        { "add" : { "index" : "docs_v6", "alias" : "docs" } }
    ]
}'