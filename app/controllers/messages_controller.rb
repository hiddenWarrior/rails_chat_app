class MessagesController < ApplicationController
    before_action :set_message_app, only: [:create, :search, :index, :delete, :show, :update]

    def index
        msgs = Message.get_all_messages(@chat.id)
        render json: msgs.map {|m| {"text": m.text, "number": m.number}}
    end


    def update
        msg_num = params[:msg_num].to_i
        key = Message.cache_key(@chat_app.token, @chat.number, msg_num.to_s)
        @message = Message.load_cache(key)
        if @chat_app != nil and @chat != nil and @message != nil
            number = @message.number 
            json_params = JSON.parse(request.raw_post)
            text = json_params["text"]
            UpdateMessageJob.perform_later(@chat_app.token, @chat.id, @chat.number, number, text)
            render json: {:text => text, :number => number}, :status => 200    
        else
            render json: {:error => "check the app token or chat number or message number please"}.to_json, :status => 404 
        end
    end


    def create
        if @chat_app != nil and @chat != nil
            cache_key = inc_key(@chat_app.token, @chat.number)
            Rails.cache.write(cache_key, 0, :raw => true,:unless_exist => true, :expires_in => 999999)
            number = Rails.cache.increment(cache_key, 1, :raw => true) 
            json_params = JSON.parse(request.raw_post)
            text = json_params["text"]
            CreateMessageJob.perform_later(@chat_app.token, @chat.id, @chat.number, number, text)
            render json: {:text => text, :number => number}, :status => 200    
        else
            render json: {:error => "check the app token or chat number please"}.to_json, :status => 404 
        end
    
    end

    def search
        json_params = JSON.parse(request.raw_post)
        msgs = Message.search_messages(@chat.id, json_params["search"])
        render json: msgs.map {|m| {:text => m.text, :number => m.number}}

    end

    def delete
        msg_num = params[:msg_num].to_i
        key = Message.cache_key(@chat_app.token, @chat.number, msg_num)
        @msg = Message.load_cache(key)
        if @msg != nil
            DestroyMessageJob.perform_later(@chat_app.token, @chat.number, msg_num)
            render json: {"text": @msg.text, "number": @msg.number}, :status => 202
        else
            render json: {"error":"message not found"}, :status => 404            
        end
    end

    def show
        msg_num = params[:msg_num].to_i
        key = Message.cache_key(@chat_app.token, @chat.number, msg_num)
        @msg = Message.load_cache(key)
        if @msg != nil
            render json: {"text": @msg.text, "number": @msg.number}, :status => 200
        else
            render json: {"error":"message not found"}, :status => 404            
        end
    end

    
    private
    def inc_key(token, chat_num)
        "app:#{token}inc:chat:#{chat_num}:message"
    end
    def set_message_app
        token = params[:token]
        number = params[:chat_num]
        chat_app_key = ChatApp.cache_key(token)
        @chat_app = ChatApp.load_cache(chat_app_key)
        chat_key = Chat.cache_key(token, number)
        @chat = Chat.load_cache(chat_key)
    
    end 

end
