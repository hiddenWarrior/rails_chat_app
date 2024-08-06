class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(token, chat_id, chat_number, number, text)
    message = Message.new(chat_id: chat_id, number: number, text: text)
    message.save
    key = Message.cache_key(token, chat_number, number)
    message.cache_object(key)
end
end
