class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.belongs_to :user
      t.string :source
      t.string :source_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
