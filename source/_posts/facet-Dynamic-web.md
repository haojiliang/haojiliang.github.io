---
post_url: facet-Dynamic-web
title: 解决Cannot change version of project facet Dynamic web module to 3.0
date: 2017-06-18 15:58:52
tags:
---
问题：Cannot change version of project facet Dynamic web module to 3.0

解决：项目所在文件夹下搜索org.eclipse.wst.common.project.facet.core.xml

将其中的<installed facet="jst.web" version="2.*"/>

       改为<installed facet="jst.web" version="3.0"/>

然后eclipse中项目右键maven→Update project
