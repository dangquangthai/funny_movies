class CreateDislikes < ActiveRecord::Migration[7.0]
  def change
    create_table :dislikes do |t|
      t.references :user, index: true, null: false
      t.references :dislikeable, polymorphic: true, index: true, null: false

      t.timestamps
    end

    add_index :dislikes, 
              [:dislikeable_type, :dislikeable_id, :user_id],
              unique: true,
              name: 'index_dislikes_on_dislikeable_and_user'
  end
end
