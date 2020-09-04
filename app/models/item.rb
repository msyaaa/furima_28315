class Item < ApplicationRecord
  has_one :address
  has_one :purchase
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_one_attached :image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_day

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    price_validation = /\A[0-9]+\z/
    validates :price, format: { with: price_validation }
    validates :price, numericality: { only_integer: true, greater_than: 299, less_than: 10_000_000 }
    validates :description, length: { maximum: 1000 }
    validates :image, presence: { message: 'を選択してください' }
  end

  with_options numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :status_id
    validates :prefecture_id
    validates :shipping_cost_id
    validates :shipping_day_id
  end

  def self.search(search)
    if search != ''
      Item.where('name LIKE(?)', "%#{search}%").order(created_at: 'DESC')
    else
      Item.order(created_at: 'DESC')
    end
  end
end
