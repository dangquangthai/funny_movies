class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user, index: true, null: false
      t.references :likeable, polymorphic: true, index: true, null: false

      t.timestamps
    end

    add_index :likes, [:likeable_type, :likeable_id, :user_id], unique: true
  end
end
