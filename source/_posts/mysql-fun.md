---
post_url: mysql_fun
title: MySQL 自定义函数
date: 2019-05-21 13:43:46
tags: [存储过程, mysql]
---

```sql
BEGIN
DECLARE childOrgIds VARCHAR(4000);
DECLARE topOrgIds VARCHAR(4000);

SET childOrgIds = '';
SET topOrgIds = '';

SELECT GROUP_CONCAT(kroa.org_id) INTO topOrgIds FROM kk_role_org_authority kroa 
WHERE kroa.org_authority_bh IN(
SELECT kr.org_authority_bh FROM kk_role kr WHERE kr.role_id IN(
SELECT kur.role_id FROM kk_user_role kur WHERE kur.user_id = userId)
);

WHILE topOrgIds IS NOT NULL
DO
SET childOrgIds = CONCAT(childOrgIds, ',', topOrgIds);
SELECT GROUP_CONCAT(org_id) INTO topOrgIds FROM kk_org WHERE FIND_IN_SET(father_id, topOrgIds) > 0;
END WHILE;
RETURN RIGHT(childOrgIds, CHAR_LENGTH(childOrgIds)-1);
END
```