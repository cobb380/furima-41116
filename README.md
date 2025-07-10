# Furima-41116
URL：https://furima-41116.onrender.com
ID：admin
PASS：2222

## テーブル定義

### users テーブル

| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birthday           | date   | null: false               |

#### アソシエーション

- has_many :items
- has_many :buys

### items テーブル

| Column            | Type       | Options                        |
|-------------------|------------|--------------------------------|
| name              | string     | null: false                    |
| explanation       | text       | null: false                    |
| category_id       | integer    | null: false                    |
| condition_id      | integer    | null: false                    |
| postage_id        | integer    | null: false                    |
| prefecture_id     | integer    | null: false                    |
| until_shipping_id | integer    | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

#### アソシエーション

- belongs_to :user
- has_one :buy

### orders テーブル

| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

#### アソシエーション

- belongs_to :user
- belongs_to :item
- has_one :address

### addresses テーブル

| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| postal_code     | string     | null: false                    |
| prefecture_id   | integer    | null: false                    |
| city            | string     | null: false                    |
| house_number    | string     | null: false                    |
| building_name   | string     |                                |
| phone_number    | string     | null: false                    |
| buy             | references | null: false, foreign_key: true |

#### アソシエーション

- belongs_to :buy
