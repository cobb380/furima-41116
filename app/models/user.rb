class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :items
  has_many :orders

  with_options presence: true do
    validates :nickname
    validates :birthday
    # 半角英数字混合のみ許可する
    validates :password, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+\z/, message: "is invalid. Input must contain both letters and numbers."}
    # ひらがな、カタカナ、漢字のみ許可する
    validates :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input full-width characters."}
    # ひらがな、カタカナ、漢字のみ許可する
    validates :last_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "is invalid. Input full-width characters."}
    # カタカナのみ許可する
    validates :first_name_kana, format: {with: /\A[ァ-ヶー]+\z/, message: "is invalid. Input full-width katakana characters."}
    # カタカナのみ許可する
    validates :last_name_kana, format: {with: /\A[ァ-ヶー]+\z/, message: "is invalid. Input full-width katakana characters."}
  end
end
