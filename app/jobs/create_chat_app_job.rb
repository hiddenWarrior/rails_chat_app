class CreateChatAppJob < ApplicationJob
  queue_as :default

  def perform(name, token)
    app = ChatApp.new(name: name, token: token)
    app.save
    key = app.cache_key(token)
    app.cache_object(key)
  end
end
