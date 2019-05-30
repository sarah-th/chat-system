class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      t.string :token
      t.string :name
      t.integer :chats_count, :default => 0
      t.timestamps
    end
  end
end
