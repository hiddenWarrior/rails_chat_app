class DestroyChatJob < ApplicationJob
  queue_as :default

  def perform(chat_app_id, number)
    chat = Chat.get_chat_by_number(chat_app_id, number)
    chat.destroy
  end
end
