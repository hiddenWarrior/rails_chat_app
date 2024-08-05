class ChatController < ApplicationController
    before_action :set_chat_app, only: [:create, :index, :delete]
    def index
        chats = Chat.get_chats(@chat_app.id)
        render json: chats.map {|m| "/app/#{params[:token]}/chat/#{m.number}/"}
    end

    def delete
        chat = Chat.get_chat_by_number(@chat_app.id, params[:number].to_i)
        if chat == nil
            render json: {:error => "chat not found"}, :status => 404
        else
            chat.destroy
            render json: chat.as_json(except: [:id, :chat_app_id, :created_at, :updated_at]), :status => 202
        end

    end

    def create
        begin
            cache_key = inc_key(params[:token])
            Rails.cache.write(cache_key, 0, :raw => true,:unless_exist => true, :expires_in => 999999)
            number = Rails.cache.increment(cache_key, 1, :raw => true) 
            chat = Chat.new(chat_app: @chat_app, number: number, chat_count: 0) #for now we may use queues later
            chat.save
            render json: chat.as_json(except: [:id, :chat_app_id, :created_at, :updated_at]), :status => 201
                
        rescue
            render json: {:error => "check the app token please"}, :status => 400
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
