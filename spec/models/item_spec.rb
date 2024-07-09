# spec/models/item_spec.rb
require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品の出品' do
    context '出品がうまくいくとき' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品がうまくいかないとき' do
      it '商品画像が必須であること' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名が必須であること' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明が必須であること' do
        @item.explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Explanation can't be blank")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end

      it '商品の状態の情報が必須であること' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end

      it '配送料の負担の情報が必須であること' do
        @item.postage_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end

      it '発送元の地域の情報が必須であること' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '発送までの日数の情報が必須であること' do
        @item.until_shipping_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Until shipping can't be blank")
      end

      it '価格の情報が必須であること' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it '価格は半角数値のみ保存可能であること' do
        @item.price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be in half-width numbers between 300 yen and 9,999,999 yen")
      end

      it '価格が¥300~¥9,999,999の間のみ保存可能であること' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be in half-width numbers between 300 yen and 9,999,999 yen")
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be in half-width numbers between 300 yen and 9,999,999 yen")
      end

      it 'userが紐づいていない場合出品できないこと' do
        item = FactoryBot.build(:item, user: nil)
        item.valid?
        expect(item.errors[:user]).to include("must exist")
      end
    end
  end
end