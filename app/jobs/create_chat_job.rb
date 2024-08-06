class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(chat_app_id, token, number)
    chat = Chat.new(chat_app_id: chat_app_id, number: number, chat_count: 0) 
    chat.save
    key = Chat.cache_key(token, number)
    chat.cache_object(key)
  end
end
