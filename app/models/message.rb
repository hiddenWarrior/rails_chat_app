class Message < ApplicationRecord
  belongs_to :chat
  after_commit :increment_chat, on: :create
  after_commit :decrement_chat, on: :destroy
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  # we can make an action job to preform this update periodically with whenever
  #but honestly i find that solution neater
  def increment_chat
    self.chat.increment!(:chat_count)
  end
  def decrement_chat
    self.chat.decrement!(:chat_count)
  end

  def self.search_messages(chat_id, search_str)
    Message.search({"query": {"bool": {"must": {"query_string": {"query": search_str,"default_field": "text"}},"filter": {"term": {"chat_id": chat_id.to_i}}}}, sort:["number"]})
  end
  def self.get_all_messages(chat_id)
    Message.search({"query": {"term": {"chat_id": {"value":chat_id.to_i}}}, sort:["number"] })
  end
  
end
