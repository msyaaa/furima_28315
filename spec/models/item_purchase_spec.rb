require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  describe ItemPurchase do
    before do
      @item_purchase = FactoryBot.build(:item_purchase)
    end

    describe '商品購入機能' do
      context '商品購入がうまくいくとき' do
        it 'token、postal_code、prefecture_id、city、house_number、telephone_numberが存在していれば保存できる' do
          expect(@item_purchase).to be_valid
        end
        it 'building_nameは空でも保存ができる' do
          @item_purchase.building_name = nil
          expect(@item_purchase).to be_valid
        end
        it 'postal_codeはハイフンが必要で、前3桁後4桁、半角数字であること' do
          @item_purchase.postal_code = '123-4567'
          expect(@item_purchase).to be_valid
        end
        it 'telephone_numberはハイフンが不要で11桁以内であること' do
          @item_purchase.telephone_number = '09012345678'
          expect(@item_purchase).to be_valid
        end
      end

      context '商品購入がうまくいかないとき' do
        it 'tokenが空では保存できない' do
          @item_purchase.token = nil
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("カード情報を入力してください")
        end
        it 'postal_codeが空では保存できない' do
          @item_purchase.postal_code = nil
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("郵便番号を入力してください")
        end
        it 'postal_codeはハイフンがないと保存できない' do
          @item_purchase.postal_code = '1234567'
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include('郵便番号は不正な値です')
        end
        it 'postal_codeは半角数字でないと保存できない' do
          @item_purchase.postal_code = '１２３-４５６７'
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include('郵便番号は不正な値です')
        end
        it 'postal_codeは前3桁以外だと保存できない' do
          @item_purchase.postal_code = '12-3456'
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include('郵便番号は不正な値です')
        end
        it 'postal_codeは後4桁以外だと保存できない' do
          @item_purchase.postal_code = '123-456'
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include('郵便番号は不正な値です')
        end
        it 'prefecture_idが1では保存できない' do
          @item_purchase.prefecture_id = 1
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include('都道府県を選択してください')
        end
        it 'cityが空では保存できない' do
          @item_purchase.city = nil
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("市区町村を入力してください")
        end
        it 'house_numberが空では保存できない' do
          @item_purchase.house_number = nil
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("番地を入力してください")
        end
        it 'telephone_numberが空では保存できない' do
          @item_purchase.telephone_number = nil
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include("電話番号を入力してください")
        end
        it 'telephone_numberはハイフンがあると保存できない' do
          @item_purchase.telephone_number = '090-1234-5678'
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include('電話番号は不正な値です')
        end
        it 'telephone_numberは12桁以上だと保存できない' do
          @item_purchase.telephone_number = '090123456789'
          @item_purchase.valid?
          expect(@item_purchase.errors.full_messages).to include('電話番号は不正な値です')
        end
      end
    end
  end
end
