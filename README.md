# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false, unique: true |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false, unique: true |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_year         | string | null: false               |
| birth_month        | string | null: false               |
| birth_day          | date   | null: false               |

### Association

- has_many :items
- has_many :orders
- has_many :comments

## items テーブル

| Column          | Type       | Options                        |
| ----------------| ---------- | ------------------------------ |
| image           | string     | null: false                    |
| description     | text       | null: false                    |
| name            | string     | null: false                    |
| price           | integer    | null: false                    |
| seller          | references | null: false, foreign_key: true |
| category        | text       | null: false                    |
| status          | string     | null: false                    |
| shipping_charge | string     | null: false                    |
| shipping_region | string     | null: false                    |
| shipping_date   | string     | null: false                    |

### Association

- belongs_to :user
- has_one :order
- has_many :comments

## orders テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| item     | references | null: false, foreign_key: true |
| buyer    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :sale
- has_one :delivery

## deliveries テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| post_code    | string     | null: false                    |
| prefecture   | string     | null: false                    |
| street       | string     | null: false                    |
| building     | string     | null: false                    |
| phone_number | string     | null: false                    |

### Association

- belongs_to :order

## sales テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| commission       | string     | null: false                    |
| profit           | string     | null: false                    |

### Association

- belongs_to :user
- has_one :order
- has_many :comments

## comments テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | null: false                    |
| item      | references | null: false, foreign_key: true |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :sale
