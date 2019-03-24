---
post_url: Windows-PowerShell-ExecutionPolicy
title: Windows PowerShell 执行策略 ExecutionPolicy
date: 2018-12-03 15:53:49
tags: ExecutionPolicy
---
获取当前执行策略：Get-ExecutionPolicy

获取影响当前会话的所有执行策略，并按优先顺序显示：Get-ExecutionPolicy -List

获取当前用户作用域的执行策略：Get-ExecutionPolicy -Scope CurrentUser

更改执行策略：Set-ExecutionPolicy -ExecutionPolicy <PolicyName>

    例：Set-ExecutionPolicy -ExecutionPolicy RemoteSigned

设置某个特定作用域中的执行策略：Set-ExecutionPolicy -ExecutionPolicy <PolicyName> -Scope <scope>

    例：Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

删除本地计算机的所有用户的执行策略：Set-ExecutionPolicy Undefined

    或 Set-ExecutionPolicy Undefined -scope LocalMachine

如果未在任何作用域中设置执行策略，则有效的执行策略是 Restricted（默认执行策略）

为某个会话设置一个不同的执行策略（只在当前会话期间生效）：

PowerShell.exe -ExecutionPolicy AllSigned

PowerShell.exe -ExecutionPolicy UnRestricted -File .\install-service-filebeat.ps1

 

全文：https://docs.microsoft.com/zh-cn/previous-versions/windows/powershell-scripting/hh847748(v%3dwps.640)
