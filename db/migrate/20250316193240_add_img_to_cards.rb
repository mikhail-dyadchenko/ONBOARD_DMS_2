class AddImgToCards < ActiveRecord::Migration[7.2]
  def change
    add_column :cards, :img, :string
  end
end
