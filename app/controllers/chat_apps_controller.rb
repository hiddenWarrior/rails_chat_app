class ChatAppsController < ApplicationController
    def create
        begin
            token = (0...20).map { ('a'..'z').to_a[rand(26)] }.join #random at first then fix it
            app = ChatApp.new(name: params[:name], token: token)
            app.save
            render json: app.as_json(except: [:id, :created_at, :updated_at])
                
        rescue
            render json: "Failed: failed to save the chat app please use another name"
        end

    end




end
