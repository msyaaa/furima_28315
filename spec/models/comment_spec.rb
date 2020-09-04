require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe Comment do
    before do
      @comment = FactoryBot.build(:comment)
    end

    describe 'コメント機能' do
      context 'コメントができるとき' do
        it 'textが存在していれば保存できる' do
          expect(@comment).to be_valid
        end
      end

      context 'コメントができないとき' do
        it 'textが空では保存できない' do
          @comment.text = nil
          @comment.valid?
          expect(@comment.errors.full_messages).to include('コメントを入力してください')
        end
      end
    end
  end
end
