class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :chat_app, null: false, foreign_key: true
      t.integer :number
      t.integer :chat_count

      t.timestamps
    end
  end
end
