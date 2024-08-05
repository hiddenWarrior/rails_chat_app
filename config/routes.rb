Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/app/', to: 'chat_apps#create'
  get '/app/', to: 'chat_apps#index'
  put '/app/:token/', to: 'chat_apps#update'
  patch '/app/:token/', to: 'chat_apps#update'
  delete '/app/:token/', to: 'chat_apps#delete'
  
  post '/app/:token/chat/', to: 'chat#create'
  post '/app/:token/chat/:chat_num/message', to: 'messages#create'
    

end
