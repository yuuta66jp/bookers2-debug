class RemoveNameFromRooms < ActiveRecord::Migration[5.2]
  def change
    remove_column :rooms, :name, :string
  end
end
