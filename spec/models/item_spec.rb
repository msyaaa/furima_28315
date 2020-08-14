require 'rails_helper'

RSpec.describe Item, type: :model do
  describe Item do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end
    
    describe "商品出品機能" do
      context "商品出品がうまくいくとき" do
        it "name、image、price、description、category_id、status_id、prefecture_id、shipping_cost_id、shipping_day_idが存在していれば保存できる"do
        expect(@item).to be_valid
        end
        it "販売価格が300~9999999の間であること" do
          @item.price = 11111
          expect(@item).to be_valid
        end
      end

      context "商品出品がうまくいかないとき" do
        it "nameが空のでは保存できない" do
          @item.name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Name can't be blank")
        end
        it "imageが空では保存できない" do 
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Image can't be blank")
        end
        it "priceが空では保存できない" do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Price can't be blank")
        end
        it "priceが300未満であれば保存できない" do
          @item.price = 111
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be greater than 299")
        end
        it "priceが9999999より大きければ保存できない" do
          @item.price = 10000000
          @item.valid?
          expect(@item.errors.full_messages).to include("Price must be less than 10000000")
        end
        it "descriptionが空では保存できない" do
          @item.description = nil
          @item.valid?
          expect(@item.errors.full_messages).to include("Description can't be blank")
        end
        it "category_idが1では保存できない" do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Category must be other than 1")
        end
        it "status_idが1では保存できない" do
          @item.status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Status must be other than 1")
        end
        it "prefecture_idが1では保存できない" do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
        end
        it "shipping_cost_idが1では登録できない" do
          @item.shipping_cost_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping cost must be other than 1")
        end
        it "shipping_day_idが1では保存できない" do
          @item.shipping_day_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include("Shipping day must be other than 1")
        end
      end 
    end
  end
end
