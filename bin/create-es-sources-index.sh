export ES_HOST="http://localhost:9200"

curl -XDELETE "$ES_HOST/http_sources_v1"

curl -XPUT "$ES_HOST/http_sources_v1" -d '
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "http_source": {
      "_source": {
        "enabled": true
      },
      "properties": {
        "created": {
          "type": "date",
          "format": "date_optional_time",
          "index": "not_analyzed",
          "doc_values": true
        },
        "updated": {
          "type": "date",
          "format": "date_optional_time",
          "index": "not_analyzed",
          "doc_values": true
        },
        "url": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true,
          "copy_to": "search_field"
        },
        "name": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true,
          "copy_to": "search_field"
        },
        "timezone": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "language": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "url_crawl_delay_secs": {
          "type": "integer",
          "index": "not_analyzed",
          "doc_values": true
        },
        "feed_crawl_delay_secs": {
          "type": "integer",
          "index": "not_analyzed",
          "doc_values": true
        },
        "sitemap_crawl_delay_secs": {
          "type": "integer",
          "index": "not_analyzed",
          "doc_values": true
        },
        "enabled": {
          "type": "boolean",
          "index": "not_analyzed",
          "doc_values": true
        },
        "discovery_enabled": {
          "type": "boolean",
          "index": "not_analyzed",
          "doc_values": true
        },
        "urls": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true,
          "copy_to": "search_field"
        },
        "sitemaps": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true,
          "copy_to": "search_field"
        },
        "feeds": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true,
          "copy_to": "search_field"
        },
        "countries": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "categories": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "app_ids": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "url_filters": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "url_normalizers": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "title_selectors": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "date_selectors": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "text_selectors": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "text_normalizers": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "date_regexps": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "date_formats": {
          "type": "string",
          "index": "not_analyzed",
          "doc_values": true
        },
        "search_field": {
          "type": "string"
        }
      }
    }
  }
}'

curl -XPOST "$ES_HOST/_aliases" -d '
{
    "actions" : [
        { "add" : { "index" : "http_sources_v1", "alias" : "http_sources" } }
    ]
}'