Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/app/', to: 'chat_apps#create'
  post '/app/:token/chat/', to: 'chat#create'
    

end
