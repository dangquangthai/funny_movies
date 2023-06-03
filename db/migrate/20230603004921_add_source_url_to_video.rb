class AddSourceUrlToVideo < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :source_url, :string
  end
end
