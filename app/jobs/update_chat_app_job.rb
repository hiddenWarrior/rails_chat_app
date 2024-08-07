class UpdateChatAppJob < ApplicationJob
  queue_as :default

  def perform(token, name)
    key_name = ChatApp.cache_key_name(name)
    key = ChatApp.cache_key(token)
    cached_app = ChatApp.load_cache(key)

    if cached_app != nil
      app = ChatApp.find(cached_app.id)
      app.delete_cache(ChatApp.cache_key_name(app.name)) # the old key name
      app.update(name: name)
      app.save
      app.cache_object(key_name)    #the new key name
      app.cache_object(key)    #the new key name
          
    end

  end
end
