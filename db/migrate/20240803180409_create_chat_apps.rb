class CreateChatApps < ActiveRecord::Migration[6.1]
  def change
    create_table :chat_apps do |t|
      t.string :name
      t.string :token

      t.timestamps
    end
  end
end
