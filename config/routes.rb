Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/app/', to: 'chat_apps#create'
  get '/app/', to: 'chat_apps#index'
  put '/app/:token/', to: 'chat_apps#update'
  patch '/app/:token/', to: 'chat_apps#update'
  delete '/app/:token/', to: 'chat_apps#delete'
  
  post '/app/:token/chat/', to: 'chat#create'
  get '/app/:token/chat/', to: 'chat#index'
  delete '/app/:token/chat/:number', to: 'chat#delete'
  get '/app/:token/chat/:number/', to: 'chat#show'
  
  post '/app/:token/chat/:chat_num/message', to: 'messages#create'
  get '/app/:token/chat/:chat_num/message', to: 'messages#index'
  post '/app/:token/chat/:chat_num/message/search', to: 'messages#search'
  delete '/app/:token/chat/:chat_num/message/:msg_num/', to: 'messages#delete'
  get '/app/:token/chat/:chat_num/message/:msg_num/', to: 'messages#show'

end
