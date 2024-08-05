class ChatApp < ApplicationRecord
    has_many :chats

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    def self.hidden_attributes
        [:id, :created_at, :updated_at]
    end
    def self.get_apps
        begin
          ChatApp.search({sort:["created_at"] }).map{|app| app["_source"].as_json(except: ChatApp.hidden_attributes)}
        rescue
          []
        end
    end


  
end
