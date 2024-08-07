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
==========================================================================================

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
==========================================================================================

- post '/app/:token/chat/:chat_num/message'

  posting a message inside chat
  ````
    curl -i -X POST \
     -H "Content-Type:application/json" \
     -d \
  '{"text": "hi"}' \
   'http://localhost:3000/app/7d90bb0081eb863131805fe95e54d06a/chat/1/message/'
  ````
- put '/app/:token/chat/:chat_num/message/:msg_num/'

  changing a message inside chat
  ````
    curl -i -X POST \
     -H "Content-Type:application/json" \
     -d \
  '{"text": "hey"}' \
   'http://localhost:3000/app/7d90bb0081eb863131805fe95e54d06a/chat/1/message/'
  ````
  

- get '/app/:token/chat/:chat_num/message'

  getting chat message with text and number
  ````
    curl -i -X GET \
   'http://localhost:3000/app/b194be3c8101e7199fd139d46019ca1b/chat/3/message/'
  ````
- post '/app/:token/chat/:chat_num/message/search'

  searching through messages of a specific chat
  ````
     curl -i -X POST \
      -H "Content-Type:application/json" \
      -d \
   '{"search": "hi"}' \
    'http://localhost:3000/app/7d90bb0081eb863131805fe95e54d06a/chat/1/message/search'
  ````
  
- delete '/app/:token/chat/:chat_num/message/:msg_num/'
  
  deleting a message
  ````
    curl -i -X DELETE \
   'http://localhost:3000/app/7d90bb0081eb863131805fe95e54d06a/chat/1/message/18/'
  ````
- get '/app/:token/chat/:chat_num/message/:msg_num/'```

  get a specific message
  ````
    curl -i -X GET \
   'http://localhost:3000/app/7d90bb0081eb863131805fe95e54d06a/chat/1/message/18/'
  ````
==========================================================================================


## technical specs
- for the numbering in distrbuted system i used redis incr which prevent race errors in incrementing it
- for elasticserach interface i used elasticsearch-rails very easy to use
- for async save i used resque whic is not the best but i knew that later sidkiq is better and i didn't use golang because it would have taken me lots of time to integrate with rails models and elasticsearch interface
- for caching to prevent alot of querying you will find a generic model called CachedModel contains most internal parts in caching the rest is the jobs and controllers i used elasticsearch in some cases too
- i tried to add tests but when i tried with Rspec and i added multiple tests but the model started to act weird so i dropped it because it's more important to rspec code without harming
- i should have dropped the puma server and use nginx that is bad
- i should use resources(Model routes)  but im kinda relearning rails and i wanted to move fast
- i should make cache 0 to make it permanant but i didn't have time to test it
- for any questions don't hesitate asking
## note
as i told in technical details of my failed rspec trial you will find it in this pull request
https://github.com/hiddenWarrior/rails_chat_app/pull/1
    
