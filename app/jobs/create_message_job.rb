class CreateMessageJob < ApplicationJob
  queue_as :default

  def perform(chat_id, number, text)
    message = Message.new(chat_id: chat_id, number: number, text: text)
    message.save
end
end
