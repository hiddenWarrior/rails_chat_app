class Chat < CachedModel
  belongs_to :chat_app
  has_many :messages, dependent: :destroy


  def self.cache_key(token, number)
    "chat:obj:token:#{token}:num:#{number}"
  end

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  def self.get_chats(chat_app_id)
    Chat.search({"query": {"term": {"chat_app_id": {"value":chat_app_id.to_i}}}, sort:["number"] })
  end

  def self.get_chat_by_number(chat_app_id, number)
    Chat.where("chat_app_id = ? and number = ?", chat_app_id, number).first
  end
end
