# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# テーブル設計
## users テーブル
|      Column       |  Type  |   Options   |
| ----------------- | ------ | ----------- |
|      nickname     | string | null: false |
|      email        | string | null: false |
|      password     | string | null: false |
| password_confirmation | string | null: false |
|      last_name     | string | null: false |
|     first_name     | string | null: false |
| last_name_reading  | string | null: false |
| first_name_reading | string | null: false |
|     birthday      |  date  | null: false |

### Association
- has_many :items
- has_many :purchases
- has_many :sns_credentials
- has_many :comments

## items テーブル
|     Column     |  Type  |   Options   |
| -------------- | ------ | ----------- |
|      name      | string | null: false |
|    category_id    | integer | null: false |
|     status_id     | integer | null: false |
|      price     | integer | null: false |
|      prefecture_id     | integer | null: false |
|   description  | text | null: false |
|  shipping_cost_id | integer | null: false |
|  shipping_day_id | integer | null: false |
|    user     | references | null: false, foreign_key: true |

### Association
- has_one :address
- has_one :purchase
- has_many :comments, dependent: :destroy
- belongs_to :user
- belongs_to_active_hash :category
- belongs_to_active_hash :status
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :shipping_day
- belongs_to_active_hash :shipping_cost

## purchases テーブル
|   Column   |    Type    |   Options   |
| ---------- | ---------- | ----------- |
|   user  | references | null: false, foreign_key: true |
|   item  | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item

## addresses テーブル
|      Column      |  Type  |   Options   |
| ---------------- | ------ | ----------- |
|    postal_code   | string | null: false |
|    prefecture    | integer | null: false |
|       city       | string | null: false |
|   house_number   | string | null: false |
|   building_name  | string | 
| telephone_number | string | null: false |
|     item      | references | null: false, foreign_key: true |

### Association
- belongs_to :item
- belongs_to_active_hash :prefecture

## sns_credentials テーブル
|    Column   |  Type  |   Options   |
| ----------- | ------ | ----------- |
|   provider  | string | 
|     uid     | string | 
|    user     | references | foreign_key: true | 

### Association
- belongs_to :user, optional: true

## comments テーブル
| Column|  Type  |   Options   |
| ----- | ------ | ----------- |
|  text |  text  | null: false |
|  user | references | null: false, foreign_key: true | 
|  item | references | null: false, foreign_key: true | 

### Association
- belongs_to :user
- belongs_to :item