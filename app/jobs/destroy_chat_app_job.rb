class DestroyChatAppJob < ApplicationJob
  queue_as :default

  def perform(token)
    app = ChatApp.load_cache(ChatApp.cache_key(token))
    app.destroy
    ChatApp.delete_cache(ChatApp.cache_key(token))
    ChatApp.delete_cache(ChatApp.cache_key_name(app.name))
    
  end
end
