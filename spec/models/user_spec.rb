require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    before do
      @user = FactoryBot.build(:user)
    end
    describe 'ユーザー新規登録' do
      context '新規登録がうまくいくとき' do
        it 'nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_readingとfirst_name_reading、birthdayが存在すれば登録できること' do
          expect(@user).to be_valid
        end
        it 'passwordが６文字以上あれば登録できること' do
          @user.password = '123456'
          @user.password_confirmation = '123456'
          expect(@user).to be_valid
        end
      end

      context '新規登録がうまくいかないとき' do
        it 'nicknameが空では登録できないこと' do
          @user.nickname = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Nickname can't be blank")
        end
        it 'emailが空では登録できないこと' do
          @user.email = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Email can't be blank")
        end
        it '重複したemailが存在する場合登録できないこと' do
          @user.save
          another_user = FactoryBot.build(:user, email: @user.email)
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
        end
        it 'passwordが空では登録できないこと' do
          @user.password = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Password can't be blank")
        end
        it 'passwordが存在してもpassword_confirmationが空では登録できないこと' do
          @user.password_confirmation = ''
          @user.valid?
          expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
        end
        it 'passwordが５文字以下であれば登録できないこと' do
          @user.password = '12345'
          @user.password_confirmation = '12345'
          @user.valid?
          expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
        end
        it 'last_nameが空では登録できないこと' do
          @user.last_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name can't be blank")
        end
        it 'first_nameが空では登録できないこと' do
          @user.first_name = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("First name can't be blank")
        end
        it 'last_name_readingが空では登録できないこと' do
          @user.last_name_reading = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Last name reading can't be blank")
        end
        it 'first_name_readingが空では登録できないこと' do
          @user.first_name_reading = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("First name reading can't be blank")
        end
        it 'birthdayが空では登録できないこと' do
          @user.birthday = nil
          @user.valid?
          expect(@user.errors.full_messages).to include("Birthday can't be blank")
        end
      end
    end
  end
end
