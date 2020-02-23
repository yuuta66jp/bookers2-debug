class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable
  # 各modelとの関連付け（アソシエーション）
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # throughオプションでユーザーがいいねしているbookを取得
  has_many :favorite_books, through: :favorites
  attachment :profile_image

  has_many :relationships
  # source: :followにてrelationshipsテーブルのfollow_idを参考にしてfollowinsモデルにアクセス
  has_many :followings, through: :relationships, source: :follow
  # foreign_key: 'follow_id'にてfollow_idを入り口としてrelaitionshipsテーブルにアクセスする（入り口）
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  # source: :userで出口をuser_idにする。userテーブルから自分をフォローしているuserを取ってくる
  has_many :followers, through: :reverse_of_relationships, source: :user

  # userモデルにフォロー機能のメッソドを記載
  def follow(other_user)
    # フォローしようとしているother_userが自分自身ではないか検証
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  # フォローがあればアンフォローを行う
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  # self.followingsによりフォローしているUser達を取得。include?(other_user)によりother_userが含まれていないか確認
  def following?(other_user)
    self.followings.include?(other_user)
  end

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: { maximum: 50 }
end
