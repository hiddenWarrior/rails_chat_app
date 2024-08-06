require 'rails_helper'

RSpec.describe DestroyChatAppJob, type: :job do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "loads chat app from cache" do
    test_token = "122"
    app_name = "abc"
    chat_app = ChatApp.new(name: app_name, token: test_token)
    expect(ChatApp).to receive(:load_cache).with(test_token) {chat_app}
    expect(chat_app).to receive(:destroy)
    expect(ChatApp).to receive(:delete_cache).with(ChatApp.cache_key(token)) 
    expect(ChatApp).to receive(:delete_cache).with(ChatApp.cache_key_name(app.name)) 
    DestroyChatAppJob.new.perform(test_token)
    


  end
  
end
