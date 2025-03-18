class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :avatar
      t.text :bio
      t.string :contact
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
