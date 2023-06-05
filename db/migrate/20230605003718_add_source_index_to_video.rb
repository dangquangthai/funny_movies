class AddSourceIndexToVideo < ActiveRecord::Migration[7.0]
  def change
    add_index :videos, [:source, :source_id, :user_id], name: 'index_source_source_id_and_user_id', unique: true
  end
end
