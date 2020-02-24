class Book < ApplicationRecord
  # userモデルに従属する
  belongs_to :user
  # 1件のbookに対して複数のいいねの関係
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  # throughオプションでbookが誰にいいねされているのかを取得
  has_many :favorite_users, through: :favorites

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 検索機能
  # self.はBook.を意味する
  def self.search(method,word)
    if method == "forward_match"
      @books = Book.where("title LIKE ?","#{word}%")
    elsif method == "backward_match"
      @books = Book.where("title LIKE ?","%#{word}")
    elsif method == "perfect_match"
      @books = Book.where("title LIKE ?","#{word}")
    elsif method == "partial_match"
      @books = Book.where("title LIKE ?","%#{word}%")
    end
  end

	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
