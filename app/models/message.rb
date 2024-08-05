class Message < ApplicationRecord
  belongs_to :chat
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def self.search_messages(chat_id, search_str)
    Message.search({"query": {"bool": {"must": {"query_string": {"query": search_str,"default_field": "text"}},"filter": {"term": {"chat_id": chat_id.to_i}}}}, sort:["number"]})
  end
  def self.get_all_messages(chat_id)
    Message.search({"query": {"term": {"chat_id": {"value":chat_id.to_i}}}, sort:["number"] })
  end
  
end
