class MessagesController < ApplicationController
    before_action :set_message_app, only: [:create, :search, :index, :delete, :show]

    def index
        msgs = Message.get_all_messages(@chat.id)
        render json: msgs.map {|m| {"text": m.text, "number": m.number}}
    end



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
            render json: {:error => "check the app token or chat number please"}.to_json
        end
    
    end

    def search
        json_params = JSON.parse(request.raw_post)
        msgs = Message.search_messages(@chat.id, json_params["search"])
        render json: msgs.map {|m| m.text}

    end

    def delete
        msg_num = params[:msg_num].to_i
        @msg = Message.where("number=? and chat_id=?", msg_num, @chat.id).first
        if @msg != nil
            @msg.destroy
            render json: {"text": @msg.text, "number": @msg.number}, :status => 202
        else
            render json: {"error":"message not found"}, :status => 404            
        end
    end

    def show
        msg_num = params[:msg_num].to_i
        @msg = Message.where("number=? and chat_id=?", msg_num, @chat.id).first
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
        @chat_app = ChatApp.where(token: params[:token]).first        
        @chat = Chat.get_chat_by_number(@chat_app.id, params[:chat_num].to_i)
    end 

end
