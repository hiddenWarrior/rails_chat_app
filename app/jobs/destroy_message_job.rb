class DestroyMessageJob < ApplicationJob
  queue_as :default

  def perform(token, chat_number, msg_num)
    key = Message.cache_key(token, chat_number, msg_num)
    msg = Message.load_cache(key)    
    if msg != nil
      msg.destroy
      Message.delete_cache(key)
    end

end
end
