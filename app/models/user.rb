class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  with_options presence: true do
    validates :nickname
    email_validation = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, uniqueness: true, format: { with: email_validation }
    password_validation = /\A[a-zA-Z0-9]+\z/
    validates :password, confirmation: true, format: { with: password_validation }
    validates :password_confirmation
    name_validation = /\A[ぁ-んァ-ン一-龥]/
    validates :last_name, format: { with: name_validation }
    validates :first_name, format: { with: name_validation }
    name_reading_validation = /\A[ァ-ヶー－]+\z/
    validates :last_name_reading, format: { with: name_reading_validation }
    validates :first_name_reading, format: { with: name_reading_validation }
    validates :birthday
  end

  has_many :items
  has_many :purchases
  has_many :sns_credentials
  has_many :comments

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )
    # userが登録済みの場合はそのままログインの処理へ行くので、ここでsnsのuser_idを更新しておく
    if user.persisted?
      sns.user = user
      sns.save
    end
    { user: user, sns: sns }
  end
end
