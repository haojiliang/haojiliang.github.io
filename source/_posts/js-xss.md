---
title: 页面输出时用js转义替换字符串中的script标签，防止XSS
post_url: js-xss
date: 2018-02-06 09:54:06
tags: [xss, js]
---
```js
  function stringEncode(str){
      var div=document.createElement('div');
      if(div.innerText){
          div.innerText=str;
      }else{
          div.textContent=str;
      }
      return div.innerHTML;
  }
  ```

```
  tblStr = tblStr.replace(/<script>/gi, stringEncode("<script>"));
// 替换字符串变量或者结束标签这样写
tblStr = tblStr.replace(new RegExp("</script>",'gi'), stringEncode("</script>"));
$('#search-result').append(tblStr);
```
其中g表示全文替换，i表示忽略大小写；