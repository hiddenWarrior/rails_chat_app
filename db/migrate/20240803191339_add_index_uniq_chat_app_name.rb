class AddIndexUniqChatAppName < ActiveRecord::Migration[6.1]
  #it's not apporirate for app to have non-unique names even in case of not using it
  def change
    add_index :chat_apps, :name, unique: true
    add_index :chat_apps, :token
  end
end
