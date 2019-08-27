# DiveIntoCode 課題[株式会社万葉様新入社員教育課題]

## 1.テーブル定義

### Admins table
|カラム名|データ型|null|unique|
|:--:|:--:|:--:|:--:|
|**name**|string|false|
|**email**|string|false|true|
|**password_digest**|string|false|

### Users table
|カラム名|データ型|null|unique|
|:--:|:--:|:--:|:--:|
|**name**|string|false|
|**email**|string|false|true|
|**password_digest**|string|false|

### Tasks table
|カラム名|データ型|null|defalt|foreign_key|
|:--:|:--:|:--:|:--:|:--:|
|**title**|string|false|新規タスク|
|**comment**|text|
|**priority**|integer|false|0|
|**deadline**|datetime|
|**user_id**|integer|||true|

### States table
|カラム名|データ型|null|unique|
|:--:|:--:|:--:|:--:|
|**progress**|string|false|true|

### Statuses table

中間テーブル - 1対多アソシエーション

|カラム名|データ型|
|:--:|:--:|
|**task_id**|integer|
|**state_id**|integer|

### Tags table
|カラム名|データ型|null|unique|
|:--:|:--:|:--:|:--:|
|**name**|string|false|true|

### Labels table

中間テーブル - 多対多アソシエーション

|カラム名|データ型|
|:--:|:--:|
|**task_id**|integer|
|**tag_id**|integer|
