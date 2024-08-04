class ChatController < ApplicationController
    MAIN_INC_KEY = "chat_inc_key"
    before_action :set_chat_app, only: [:create]

    def create
        begin
            cache_key = inc_key(params[:token])
            Rails.cache.write(cache_key, 0, :raw => true,:unless_exist => true, :expires_in => 999999)
            number = Rails.cache.increment(cache_key, 1, :raw => true) 
            puts "number is #{number}"
            chat = Chat.new(chat_app: @chat_app, number: number, chat_count: 0) #for now we may use queues later
            chat.save
            puts "hi bye"
            render json: chat.as_json(except: [:id, :chat_app_id, :created_at, :updated_at])
                
        rescue
            render json: "Failed: failed to save the chat check the app token please"
        end

    end
    private
    def inc_key(token)
        "app:#{token}inc:chat"
    end
    def set_chat_app
        @chat_app = ChatApp.where(token: params[:token]).first
    end 

end
