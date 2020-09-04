require 'rails_helper'

RSpec.describe Item, type: :model do
  describe Item do
    before do
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.png')
    end

    describe '商品出品機能' do
      context '商品出品がうまくいくとき' do
        it 'name、image、price、description、category_id、status_id、prefecture_id、shipping_cost_id、shipping_day_idが存在していれば保存できる' do
          expect(@item).to be_valid
        end
        it '販売価格が300~9999999の間であること' do
          @item.price = 11_111
          expect(@item).to be_valid
        end
      end

      context '商品出品がうまくいかないとき' do
        it 'nameが空のでは保存できない' do
          @item.name = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('商品名を入力してください')
        end
        it '商品名が40文字以上の時は登録できない' do
          @item.name = Faker::Lorem.characters(40)
          @item.valid?
          expect(@item.errors.full_messages).to include('商品名は40文字以内で入力してください')
        end
        it 'imageが空では保存できない' do
          @item.image = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('画像を選択してください')
        end
        it 'priceが空では保存できない' do
          @item.price = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('販売価格を入力してください')
        end
        it 'priceが300未満であれば保存できない' do
          @item.price = 111
          @item.valid?
          expect(@item.errors.full_messages).to include('販売価格は299より大きい値にしてください')
        end
        it 'priceが9999999より大きければ保存できない' do
          @item.price = 10_000_000
          @item.valid?
          expect(@item.errors.full_messages).to include('販売価格は10000000より小さい値にしてください')
        end
        it 'descriptionが空では保存できない' do
          @item.description = nil
          @item.valid?
          expect(@item.errors.full_messages).to include('商品の説明を入力してください')
        end
        it '商品説明が1000文字以上の時は登録できない' do
          @item.description = Faker::Lorem.paragraphs(number: 500)
          @item.valid?
          expect(@item.errors.full_messages).to include('商品の説明は1000文字以内で入力してください')
        end
        it 'category_idが1では保存できない' do
          @item.category_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
        end
        it 'status_idが1では保存できない' do
          @item.status_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('商品の状態を選択してください')
        end
        it 'prefecture_idが1では保存できない' do
          @item.prefecture_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
        end
        it 'shipping_cost_idが1では登録できない' do
          @item.shipping_cost_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
        end
        it 'shipping_day_idが1では保存できない' do
          @item.shipping_day_id = 1
          @item.valid?
          expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
        end
      end
    end
  end
end
