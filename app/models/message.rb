class Message < ApplicationRecord
  belongs_to :chat
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  def search_messages(search_str, chat_id)
    Message.search({"query": {"bool": {"must": {"query_string": {"query": search_str,"default_field": "text"}},"filter": {"term": {"chat_id": chat_id.to_i}}}}})
  end
  
end
