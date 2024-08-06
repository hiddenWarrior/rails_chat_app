require 'time'
require 'digest'
class ChatAppsController < ApplicationController

    MAIN_INC_KEY = "app_inc_key"
    def index
        render json: ChatApp.get_apps()
    end

    def update
        js = JSON.parse(request.raw_post)
        name = js["name"]
        token = params[:token]
        puts ChatApp.cache_key_name(name)
        puts ChatApp.load_cache(ChatApp.cache_key_name(name))
        if ChatApp.load_cache(ChatApp.cache_key_name(name)) != nil 
            render :json => {:error => "please choose another name"}.to_json, :status => 400
        elsif ChatApp.load_cache(ChatApp.cache_key(token)) == nil 
            render :json => {:error => "unknown app token"}.to_json, :status => 404            
        else
            puts "keep at"
            UpdateChatAppJob.perform_later(token, name)
            render :json => {:name => name, :token => token}, :status => 200   
        end
        # app = ChatApp.where("token = ?", params[:token]).first
        # if app == nil
        #     render :json => {:error => "not found"}.to_json, :status => 404
        # else
        #     js = JSON.parse(request.raw_post)
        #     if js["name"] != nil
        #       app.update(name: js["name"])
        #     end
        #     render json: app.as_json(except: ChatApp.hidden_attributes), :status => 202   
        # end
        
    end
    def delete
        token = params[:token]

        app = ChatApp.load_cache(ChatApp.cache_key(token))
        if app != nil
            DestroyChatAppJob.perform_later(token)
            render json: app.as_json(except: ChatApp.hidden_attributes), :status => 200
        else
            render :json => {:error => "not found"}.to_json, :status => 404
        end
        # app = ChatApp.where("token = ?", params[:token]).first
        # if app == nil
        #     render :json => {:error => "not found"}.to_json, :status => 404
        # else
        #     app.destroy
        #     render json: app.as_json(except: ChatApp.hidden_attributes), :status => 202   
        # end
        
    end



    def create
        begin
            Rails.cache.write(MAIN_INC_KEY, 0, :raw => true,:unless_exist => true, :expires_in => 999999)
            token = Digest::MD5.hexdigest(Rails.cache.increment(MAIN_INC_KEY, 1, :raw => true).to_s + Time.now().to_s)
            name = params[:name]
            #to preserve uniquness i'll leave it commented
            # CreateChatAppJob.perform_later(name, token)
            app = ChatApp.new(name: params[:name], token: token)
            app.save
            key_name = ChatApp.cache_key_name(name)
            key = ChatApp.cache_key(token)
            app.cache_object(key_name)
            app.cache_object(key)
            
            render json: {:name => name, :token => token}, :status => 200
                
        rescue
            render json: {:error => "please choose another name"}, :status => 400
        end

    end




end
