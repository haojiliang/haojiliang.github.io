---
post_url: urllib2
title: python网络请求报urllib2.HTTPError:HTTP Error 405:Not Allowed
date: 2017-12-01 10:28:52
tags: [urllib2, python]
---
报错信息：
```
Traceback (most recent call last):
  File "exportESData.py", line 45, in <module>
    exportEsData("https://www.iaiot.com", index, type, siteid).exportData()
  File "exportESData.py", line 29, in exportData
    response = opener.open(req)
  File "C:\mywork\Python27\lib\urllib2.py", line 406, in open
    response = meth(req, response)
  File "C:\mywork\Python27\lib\urllib2.py", line 519, in http_response
    'http', request, response, code, msg, hdrs)
  File "C:\mywork\Python27\lib\urllib2.py", line 444, in error
    return self._call_chain(*args)
  File "C:\mywork\Python27\lib\urllib2.py", line 378, in _call_chain
    result = func(*args)
  File "C:\mywork\Python27\lib\urllib2.py", line 527, in http_error_default
    raise HTTPError(req.get_full_url(), code, msg, hdrs, fp)
urllib2.HTTPError: HTTP Error 405: Not Allowed
```

原因：请求协议问题


解决：https换成http
