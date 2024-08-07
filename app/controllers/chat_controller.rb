class ChatController < ApplicationController
    before_action :set_chat_app, only: [:create, :index, :delete, :show]
    def index
        if @chat_app != nil
            chats = Chat.get_chats(@chat_app.id)
            render json: chats.map {|m| "/app/#{@token}/chat/#{m.number}/"}
        else
            render json: {:result => "check the app token please"}, :status => 404
        end

    end

    def show
        number = params[:number].to_i
        key = Chat.cache_key(@token, number)
        chat = Chat.load_cache(key)
        if chat != nil
            msgs = Message.get_all_messages(chat.id)
            render json: msgs.map {|m| m.text}
        else
            render json: {:result => "check the app token or chat number please"}, :status => 404
        end
    end


    def delete
        number = params[:number].to_i
        DestroyChatJob.perform_later(@chat_app.id, @token, number)
        render :json => {:result => "command registered succesffuly"}

    end

    def create
        begin
            cache_key = inc_key(@token)
            Rails.cache.write(cache_key, 0, :raw => true,:unless_exist => true, :expires_in => 999999)
            number = Rails.cache.increment(cache_key, 1, :raw => true) 
            CreateChatJob.perform_later(@chat_app.id, @token, number)
            render :json => {:token => @token, :number => number}
                
        rescue
            render json: {:error => "check the app token please"}, :status => 400
        end

    end
    private
    def inc_key(token)
        "app:#{token}inc:chat"
    end
    def set_chat_app
        @token = params[:token]
        @chat_app = ChatApp.load_cache(ChatApp.cache_key(params[:token]))
    end 

end
