class MessagesController < ApplicationController
    before_action :set_message_app, only: [:create]
    def create
        begin
            cache_key = inc_key(@chat_app.token, @chat.number)
            Rails.cache.write(cache_key, 0, :raw => true,:unless_exist => true, :expires_in => 999999)
            number = Rails.cache.increment(cache_key, 1, :raw => true) 
            json_params = JSON.parse(request.raw_post)
            message = Message.new(chat: @chat, number: number, text: json_params["text"]) #for now we may use queues later
            message.save
            render json: message.as_json(except: [:id, :chat_id, :created_at, :updated_at])
                
        rescue
            render json: "Failed: check the app token or chat number please"
        end
    
    end
        
    private
    def inc_key(token, chat_num)
        "app:#{token}inc:chat:#{chat_num}:message"
    end
    def set_message_app
        @chat_app = ChatApp.where(token: params[:token]).first
        # @chat = Chat.where(chat_app_id = @chat_app.id AND number = params[:chat_num])
        @chat = Chat.where("(chat_app_id = ?) and (number = ?)", @chat_app.id, params[:chat_num].to_i).first
    end 

end
