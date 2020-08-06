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
- has_one :address

## items テーブル
|     Column     |  Type  |   Options   |
| -------------- | ------ | ----------- |
|      name      | string | null: false |
|      image     | string | null: false |
|    category    | string | null: false |
|     status     | string | null: false |
|      price     | integer | null: false |
|   description  | text | null: false |
|  shipping_cost | string | null: false |
|  shipping_days | string | null: false |
|    user_id     | references | null: false, foreign_key: true |
|  purchase_id   | references | null: false, foreign_key: true |
|  address_id    | references | null: false, foreign_key: true |

### Association
- belongs_to :address
- belongs_to :purchase
- belongs_to :user
- belongs_to_active_hash :category
- belongs_to_active_hash :status
- belongs_to_active_hash :shipping_days
- belongs_to_active_hash :shipping_cost

## purchases テーブル
|   Column   |    Type    |   Options   |
| ---------- | ---------- | ----------- |
|   price    |  integer   | null: false |
|   user_id  | references | null: false, foreign_key: true |
| address_id | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_many :items
- belongs_to :address

## addresses テーブル
|      Column      |  Type  |   Options   |
| ---------------- | ------ | ----------- |
|    postal_code   | string | null: false |
|    prefecture    | integer | null: false |
|       city       | string | null: false |
|   house_number   | string | null: false |
|   building_name  | string | 
| telephone_number | string | null: false |
|     user_id      | references | null: false, foreign_key: true |

### Association
- has_many :purchases
- has_many :items
- belongs_to :user
- belongs_to_active_hash :prefecture