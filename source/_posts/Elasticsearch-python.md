---
post_url: Elasticsearch-python
title: 通过python使用游标查询Elasticsearch数据并写入文件
date: 2018-02-06 10:36:35
tags: [Elasticsearch, python]
---
```python
import json
import os
import sys
import urllib2
 
reload(sys)
sys.setdefaultencoding('utf-8')
 
class exportEsData():
	def __init__(self, url, siteid, startdate, enddate, scroll):
		self.url = '%s/_search' % (url)
		self.siteid = siteid
		self.startdate = startdate
		self.enddate = enddate
		self.scroll = scroll
		self.result = ""
 
	def exportData(self, scrollID):
		#esdata = urllib2.urlopen("http://www.baidu.com/").read()
		opener = urllib2.build_opener()
		headers = {'User-Agent':'Mozilla /5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6' }
		if scrollID == "":
			print("Exporting site%s..." % self.siteid)
			queryJson = { \
                    "size": 1000, \
                    "query": { "filtered": {"filter": {"bool": {"must": {"bool": {"must": [ \
                                {"query": {"match": {"b": {"query": self.siteid,"type": "phrase"}}}}, \
                                {"range":{"c":{"gte": self.startdate + " 00:00:00","lte":self.enddate + " 23:59:59"}}} \
                            ]}}}}} \
                        } \
                    }
			url2 = '%s?scroll=%s' % (self.url, self.scroll)
		else:
			queryJson = { "scroll" : self.scroll, "scroll_id" : scrollID }
			url2 = self.url + "/scroll"
		req = urllib2.Request(url2, data=json.dumps(queryJson), headers=headers)
		response = opener.open(req)
		esdata = response.read()
		self.processData(esdata)
 
	def processData(self, data):
		#msg = json.dumps(data, ensure_ascii=False)
		msg = json.loads(data)
		#print(type(data))
		#print(msg['hits']['hits'][2]['_source']['f8'])
		scrollID = msg["_scroll_id"]
		attacks = msg['hits']['hits']
		for attack in attacks:
			self.result = '%s%s\n' % (self.result, attack['_source'])
		if len(attacks) > 0:
			self.exportData(scrollID)
		else:
			self.writeFile(self.result)
 
	def writeFile(self, data):
		try:
			filename = 'AttackData_%s.txt' % (self.siteid)
			f = open(filename, "w+")
			f.write(data)
			print("site%s successfully exported" % self.siteid)
		finally:
			f.flush()
			f.close()
 
if __name__ == '__main__':
	siteids = [1912, 1918]
	for siteid in siteids:
		exportEsData("http://127.0.0.1:9201", siteid, "2017-07-03", "2017-12-01", "5m").exportData("")
 
os.system("pause")
```