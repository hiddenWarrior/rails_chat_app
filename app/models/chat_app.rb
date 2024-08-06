class ChatApp < CachedModel
    has_many :chats, dependent: :destroy

    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    
    def self.cache_key(token)
      "chat_app:obj:token:#{token}"
    end
   
    def self.cache_key_name(name)
      "chat_app:obj:name:#{name}"
    end
  
      
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
