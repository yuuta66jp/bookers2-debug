class Relationship < ApplicationRecord

  belongs_to :user

  # class_name: 'User'でfollowモデルが存在せずにuserモデルにbelongs_toするよう明示
  belongs_to :follow, class_name: 'User'

  # どちらか一つでもなかった場合保存されないようにvalidationを設定する
  validates :user_id, presence: true
  validates :follow_id, presence: true

end
