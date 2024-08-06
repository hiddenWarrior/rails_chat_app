class DestroyMessageJob < ApplicationJob
  queue_as :default

  def perform(msg_num, chat_id)
    msg_num = params[:msg_num].to_i
    msg = Message.where("number=? and chat_id=?", msg_num, chat_id).first
    if msg != nil
      msg.destroy
    end
end
end
