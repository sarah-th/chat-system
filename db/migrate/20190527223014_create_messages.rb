class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :chat
      t.integer :message_number
      t.string :body
      t.timestamps
    end
    add_index(:messages, [:chat_id, :message_number], unique: true)
  end
end
