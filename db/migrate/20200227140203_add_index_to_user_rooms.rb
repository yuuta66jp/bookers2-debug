class AddIndexToUserRooms < ActiveRecord::Migration[5.2]
  def change
    add_index :user_rooms, [:user_id, :room_id], unique: true
  end
end
