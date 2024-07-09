class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :until_shipping
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :explanation, presence: true
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :postage_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :until_shipping_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :price, presence: true, numericality: { only_integer:true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999,
   message: "must be in half-width numbers between 300 yen and 9,999,999 yen" 
  }
end