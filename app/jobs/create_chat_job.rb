class CreateChatJob < ApplicationJob
  queue_as :default

  def perform(chat_app_id, number)
    chat = Chat.new(chat_app_id: chat_app_id, number: number, chat_count: 0) #for now we may use queues later
    chat.save
  end
end
