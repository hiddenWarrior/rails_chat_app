require 'time'
require 'digest'
class ChatAppsController < ApplicationController

    MAIN_INC_KEY = "app_inc_key"
    def index
        render json: ChatApp.get_apps()
    end

    def update
        app = ChatApp.where("token = ?", params[:token]).first
        if app == nil
            render :json => {:error => "not found"}.to_json, :status => 404
        else
            js = JSON.parse(request.raw_post)
            if js["name"] != nil
              app.update(name: js["name"])
            end
            render json: app.as_json(except: ChatApp.hidden_attributes), :status => 202   
        end
        
    end
    def delete
        app = ChatApp.where("token = ?", params[:token]).first
        if app == nil
            render :json => {:error => "not found"}.to_json, :status => 404
        else
            app.destroy
            render json: app.as_json(except: ChatApp.hidden_attributes), :status => 202   
        end
        
    end



    def create
        begin
            Rails.cache.write(MAIN_INC_KEY, 0, :raw => true,:unless_exist => true, :expires_in => 999999)
            token = Digest::MD5.hexdigest(Rails.cache.increment(MAIN_INC_KEY, 1, :raw => true).to_s + Time.now().to_s)
            puts token.to_s
            puts ChatApp.hidden_attributes
            app = ChatApp.new(name: params[:name], token: token)
            app.save
            render json: app.as_json(except: ChatApp.hidden_attributes), :status => 201
                
        rescue
            render json: "Failed: please use another name", :status => 400
        end

    end




end
