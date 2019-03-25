---
post_url: Elasticsearch-buckets
title: 通过 elasticsearch-sql 使用 SQL 语句聚合查询 Elasticsearch 获取各种 buckets 桶
date: 2017-12-28 18:08:58
tags: elasticsearch
---
Elasticsearch 的 buckets（桶）包含 Histogram、Date Histogram、Range、Date Range、Terms、IPv4 Range、Significant Terms 等；

1. Histogram：
```sql
SELECT * FROM INDEX-2017-12 GROUP BY (histogram('alias'='log_date.mthAggs', 'interval'='1', 'field'='log_date.mth'))
```
```
{
  "from" : 0,
  "size" : 0,
  "aggregations" : {
    "log_date.mthAggs" : {
      "histogram" : {
        "field" : "log_date.mth",
        "interval" : 1
      }
    }
  }
}
```
2. Date Histogram：
```sql
SELECT * FROM INDEX-2017-12 GROUP BY (date_histogram('format'='yyyy-MM', 'alias'='@timestampAggs', 'interval'='1M', 'field'='@timestamp'))
```
```
{
  "from" : 0,
  "size" : 0,
  "aggregations" : {
    "@timestampAggs" : {
      "date_histogram" : {
        "field" : "@timestamp",
        "interval" : "1M",
        "format" : "yyyy-MM"
      }
    }
  }
}
```
3. Range：
```sql
SELECT * FROM INDEX-2017-12 GROUP BY (range(log_date.mth,1,6,7,12))
```
```
{
  "from" : 0,
  "size" : 0,
  "aggregations" : {
    "range(log_date.mth,1,6,7,12)" : {
      "range" : {
        "field" : "log_date.mth",
        "ranges" : [ {
          "from" : 1.0,
          "to" : 6.0
        }, {
          "from" : 6.0,
          "to" : 7.0
        }, {
          "from" : 7.0,
          "to" : 12.0
        } ]
      }
    }
  }
}
```
4. Date Range：
```sql
SELECT * FROM INDEX-2017-12 GROUP BY (date_range('format'='yyyy-MM-dd', 'alias'='dateRangeAggs', 'field'='@timestamp','2017-01-01','2017-06-01','now-1M','now-1w','now-2d','now'))
```
```
{
  "from" : 0,
  "size" : 0,
  "aggregations" : {
    "dateRangeAggs" : {
      "date_range" : {
        "field" : "@timestamp",
        "ranges" : [ {
          "from" : "2017-01-01",
          "to" : "2017-06-01"
        }, {
          "from" : "2017-06-01",
          "to" : "now-1M"
        }, {
          "from" : "now-1M",
          "to" : "now-1w"
        }, {
          "from" : "now-1w",
          "to" : "now-2d"
        }, {
          "from" : "now-2d",
          "to" : "now"
        } ],
        "format" : "yyyy-MM-dd"
      }
    }
  }
}
```
5. Terms：
```sql
SELECT * FROM INDEX-2017-12 GROUP BY (terms('alias'='methodAggs', 'field'='method', 'size'=6))
```
```
{
  "from" : 0,
  "size" : 0,
  "aggregations" : {
    "methodAggs" : {
      "terms" : {
        "field" : "method",
        "size" : 6
      }
    }
  }
}
```
6. IPv4 Range：
```
稍后补充...
```
7. Significant Terms：
暂时没找到求 Significant Terms 的 SQL 语句，只能用原生 ES 查询语句获取了；
ES 原生查询语句如下：
```
{
  "size": 0,
  "query": {
    "bool": {
      "must": [
        {
          "query_string": {
            "query": "*",
            "analyze_wildcard": true
          }
        },
        {
          "range": {
            "@timestamp": {
              "gte": 1451297220869,
              "lte": 1514455620869,
              "format": "epoch_millis"
            }
          }
        }
      ],
      "must_not": []
    }
  },
  "_source": {
    "excludes": []
  },
  "aggs": {
    "2": {
      "significant_terms": {
        "field": "log.client.system",
        "size": 4
      }
    }
  }
}
```
count、sum、avg、max、min、percentiles (百分位数)、Unique count（基数 || 去重计数）、Median（中位数）、扩展度量（含方差、平方和、标准差、标准差界限）、Percentile ranks（百分位等级）等各种 metrics 度量值查询：https://blog.iaiot.com/20171227/Elasticsearch-metrics.html


附 elasticsearch-sql 的 GitHub 地址：https://github.com/NLPchina/elasticsearch-sql
Elasticsearch 官方文档（中文版）地址：https://www.elastic.co/guide/cn/elasticsearch/guide/cn/aggregations.html
