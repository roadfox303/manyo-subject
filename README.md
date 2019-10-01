# DiveIntoCode 課題[株式会社万葉様新入社員教育課題]
### バージョン情報
Ruby 2.6.3  
Rails 5.2.3
## 1.デプロイ方法
1. Heroku にログイン
```bash
$ heroku login
```
2. アプリケーションを作成
```bash
$ heroku create アプリケーション名
```
3. herokuにプッシュ
```bash
# マスターブランチからの場合
$ git push heroku master
```
```bash
# サブブランチからの場合
$ git push heroku 作業ブランチ:master
```
4. herokuのDBをマイグレート
```bash
$ heroku run rails db:migrate
# シードを作成する場合
$ heroku run rails db:seed
```
5. アプリケーションを実行
```bash
$ heroku open
```

## 2.テーブル定義

### Admins table
|カラム名|データ型|null|index|
|:--:|:--:|:--:|:--:|
|**user_id**|integer|false|unique|


### Users table
|カラム名|データ型|null|index|
|:--:|:--:|:--:|:--:|
|**name**|string|false|addition|
|**email**|string|false|unique|
|**password_digest**|string|false|

### Tasks table
|カラム名|データ型|null|defalt|index|foreign_key|
|:--:|:--:|:--:|:--:|:--:|:--:|
|**title**|string|false|新規タスク|addition|
|**comment**|text|false|||
|**priority**|integer|false|0|addition||
|**deadline**|datetime|||addition|
|**user_id**|integer||||true|

### States table
|カラム名|データ型|null|index|
|:--:|:--:|:--:|:--:|
|**progress**|string|false|unique|

### Statuses table

中間テーブル - 1対多

|カラム名|データ型|index|
|:--:|:--:|:--:|
|**task_id**|integer|
|**state_id**|integer|addition|

### Tags table
|カラム名|データ型|null|index|
|:--:|:--:|:--:|:--:|
|**name**|string|false|unique|

### Labels table

中間テーブル - 多対多

|カラム名|データ型|index|
|:--:|:--:|:--:|
|**task_id**|integer|addition|
|**tag_id**|integer|addition|
