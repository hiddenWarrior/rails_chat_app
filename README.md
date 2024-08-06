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

-  post '/app/'
  
   to create ChatApp 
````
```
    curl -i -X POST \
   -H "Content-Type:application/json" \
   -d \
'{"name": "chat name"}' \
 'http://localhost:3000/app/' ```
````

-  get '/app/'

   to list all apps
   ````
      curl -i -X GET 'http://localhost:3000/app/' 
   ````
-  put/patch '/app/:token/'

   to change the name of the ChatApp if you like
   ````
     curl -i -X PUT \
     -H "Content-Type:application/json" \
     -d \
     '{"name": "adam1"}' \
     'http://localhost:3000/app/ef7ff51da82f3fa000b81f0484bb3c8b/'
   ````
-  delete '/app/:token/'

   to delete ChatApp
   ````
      curl -i -X DELETE \
      'http://localhost:3000/app/966cabf4a389d972880a1eec25ac04b5/'

   ````

- post '/app/:token/chat/'

  create new chat with app token and it return it's numbers with token again
  ````
    curl -i -X POST \
     -d \
  '{"name": "adam1"}' \
   'http://localhost:3000/app/7d90bb0081eb863131805fe95e54d06a/chat/'
  ````

- get '/app/:token/chat/'
     return all chat as get hyperlinks(without host relative url)
    ````
        curl -i -X GET \
     'http://localhost:3000/app/b194be3c8101e7199fd139d46019ca1b/chat/'
    ````

-  delete '/app/:token/chat/:number/'
     delete Chat by ChatApp token and it's number
     ````
              curl -i -X DELETE \
       'http://localhost:3000/app/966cabf4a389d972880a1eec25ac04b5/chat/1/'
     ````
- get '/app/:token/chat/:number/'
    get all messages of this chat as list the text only
        
    ````
       curl -i -X GET 'http://localhost:3000/app/966cabf4a389d972880a1eec25ac04b5/chat/1/' 
    ````

    
