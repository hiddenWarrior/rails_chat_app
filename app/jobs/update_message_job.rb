class UpdateMessageJob < ApplicationJob
  queue_as :default

  def perform(token, chat_id, chat_number, number, text)
    key = Message.cache_key(token, chat_number, number)
    message_cache = Message.load_cache(key)
    message = Message.find(message_cache.id)
    message.update(text: text)
    message.save
    message.cache_object(key)
  end
end
