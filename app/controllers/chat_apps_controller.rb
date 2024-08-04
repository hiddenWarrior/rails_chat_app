require 'time'
require 'digest'
class ChatAppsController < ApplicationController

    MAIN_INC_KEY = "app_inc_key"


    def create
        begin
            Rails.cache.write(MAIN_INC_KEY, 0, :raw => true,:unless_exist => true, :expires_in => 999999)
            token = Digest::MD5.hexdigest(Rails.cache.increment(MAIN_INC_KEY, 1, :raw => true).to_s + Time.now().to_s)
            
            app = ChatApp.new(name: params[:name], token: token)
            app.save
            render json: app.as_json(except: [:id, :created_at, :updated_at])
                
        rescue
            render json: "Failed: failed to save the chat app please use another name"
        end

    end




end
