class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :house_number, :building_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :user_id, presence: { message: "can't be blank" }
    validates :item_id, presence: { message: "can't be blank" }
    validates :postal_code,
              format: { with: /\A[0-9]{3}-[0-9]{4}\z/,
                        message: 'is invalid. Include hyphen (-) and must be half-width numbers' }
    validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :house_number
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'must be a 10 or 11 digit number' }
  end
  def save
    order = Order.create(user_id:, item_id:)
    Address.create(postal_code:, prefecture:, city:, house_number:,
                   building_name:, phone_number:, order_id: order.id)
  end
end
