class ItemPurchase

  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :telephone_number, :token

  with_options presence: true do
    postal_code_validation = /\A[0-9]{3}-[0-9]{4}\z/
    validates :postal_code, format: { with: postal_code_validation }
    validates :city
    validates :house_number
    telephone_number_validation = /\A\d{11}\z/
    validates :telephone_number, format: { with: telephone_number_validation }
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building_name: building_name, telephone_number: telephone_number, item_id: item_id)
    Purchase.create(user_id: user_id, item_id: item_id)
  end
end