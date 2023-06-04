class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :whodunit, null: false, foreign_key: { to_table: :users }, index: true
      t.references :notifiable, polymorphic: true, null: false, index: true
      t.string :action, null: false
      t.datetime :read_at
      t.datetime :notified_at
      t.timestamps
    end
  end
end
