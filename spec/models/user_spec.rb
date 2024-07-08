require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'バリデーション' do
    it 'ニックネームが必須であること' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが必須であること' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意性であること' do
      existing_user = FactoryBot.create(:user, email: 'test@example.com')
      @user.email = 'test@example.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

    it 'メールアドレスは、@を含む必要があること' do
      @user.email = 'testexample.com'
      @user.valid?
      expect(@user.errors.full_messages).to include("Email is invalid")
    end

    it 'パスワードが必須であること' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      @user.password = '12345'
      @user.password_confirmation = '12345'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
      @user.password = 'password'
      @user.password_confirmation = 'password'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is invalid. Input must contain both letters and numbers.")
    end

    it 'パスワードが数字のみでは登録できないこと' do
      @user.password = '123456'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid. Input must contain both letters and numbers."
    end

    it 'パスワードが全角だと登録できないこと' do
      @user.password = 'ｐａｓｓｗｏｒｄ１'
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is invalid. Input must contain both letters and numbers."
    end

    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      @user.password_confirmation = 'mismatch'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'お名前(全角)は、名字が必須であること' do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'お名前(全角)は、名前が必須であること' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it '名字が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.last_name = 'Smith'
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name is invalid. Input full-width characters."
    end

    it '名前が全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      @user.first_name = 'John'
      @user.valid?
      expect(@user.errors.full_messages).to include "First name is invalid. Input full-width characters."
    end

    it 'お名前カナ(全角)は名字が必須であること' do
      @user.last_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank"
    end

    it 'お名前カナ(全角)は名前が必須であること' do
      @user.first_name_kana = ''
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end

    it 'お名前カナ(全角)は名字が全角カタカナでの入力が必須であること' do
      @user.last_name_kana = 'すみす'
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana is invalid. Input full-width katakana characters."
    end

    it 'お名前カナ(全角)は名前が全角カタカナでの入力が必須であること' do
      @user.first_name_kana = 'じょん'
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana is invalid. Input full-width katakana characters."
    end

    it '生年月日が必須であること' do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
  end

  describe '正常系' do
    it '全ての項目が正しく入力されている場合、正常に登録できること' do
      expect(@user).to be_valid
    end
  end
end