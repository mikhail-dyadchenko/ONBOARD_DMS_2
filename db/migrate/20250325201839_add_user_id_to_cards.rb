class AddUserIdToCards < ActiveRecord::Migration[7.2]
  def change
    add_column :cards, :user_id, :integer
  end
end
