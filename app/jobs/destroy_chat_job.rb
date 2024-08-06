class DestroyChatJob < ApplicationJob
  queue_as :default

  def perform(chat_app_id, token,  number)
    key = Chat.cache_key(token, number)
    chat = Chat.load_cache(key)
    chat.destroy
    Chat.delete_cache(key)
  end
end
