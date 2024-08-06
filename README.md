# README

## running
just type ``` sudo docker-compose up ```
### note
 you may find issue with database connection it was fixed by adding flag to mysql but if you encounter it just 
 ```sudo docker-compose down```   and  
 ``` sudo docker-compose up ``` again


## Models
whe have three models the `ChatApp` the main model
each `ChatApp` have internally many chats  numbered
each `Chat` have many messages ordered and numbered
`Message` are the text sent to the each `Chat`

## Endpoints
we have enpoints for each 
that is there summary and i'll discuss each of them
```
  post '/app/'
  get '/app/'
  put '/app/:token/'
  patch '/app/:token/'
  delete '/app/:token/'
  
  post '/app/:token/chat/'
  get '/app/:token/chat/'
  delete '/app/:token/chat/:number/'
  get '/app/:token/chat/:number/'
  
  post '/app/:token/chat/:chat_num/message'
  put '/app/:token/chat/:chat_num/message/:msg_num/'
  get '/app/:token/chat/:chat_num/message'
  post '/app/:token/chat/:chat_num/message/search'
  delete '/app/:token/chat/:chat_num/message/:msg_num/'
  get '/app/:token/chat/:chat_num/message/:msg_num/'```

```

