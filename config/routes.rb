Rails.application.routes.draw do
  root 'application#index'

  #API
  resources :api_rest
  get '/graphql'  => 'api#graphql'
  get '/grpc'  => 'api#grpc'

  #authentication
  get '/basics'  => 'auth#basics'
  get '/cookie'  => 'auth#cookie'
  get '/session'  => 'auth#sessions'
  get '/token_auth'  => 'auth#token_auth'
  get '/jwt'  => 'auth#jwt'
  get '/oauth'  => 'auth#oauth'
  get '/sso'  => 'auth#sso'


  #web_security
  get 'web_security/hash'
  get '/csp'  => 'web_security#csp'
  get '/cors'  => 'web_security#cors'  

  #cache_cdn
  get '/redis_view'  => 'cache_cdn_redis#redis_view'
  post 'redis_demo', to: 'cache_cdn_redis#set_value'
  
  #Designpatterns
  get '/gof_design_patterns'  => 'designpatterns#gof_design_patterns'
  get '/cqrs'  => 'designpatterns#cqrs'
  get '/event_sourcing'  => 'designpatterns#event_sourcing'

  #serverless
  get '/aws_lambda'  => 'serverless#aws_lambda'

  #searchengines
  get '/elasticsearch'  => 'searchengines_elasticsearch#elasticsearch'

  #mq_rabbitmq
  get '/mq_rabbitmq'  => 'mq_rabbitmq#index'

  #realtimedata
  get '/web_socket'  => 'realtimedata#web_socket'

  get '/short_polling_view'  => 'realtimedata#short_polling_view'
  get '/short_polling_update_data'  => 'realtimedata#short_polling_update_data'
  
  get '/long_polling_subscribe'  => 'realtimedata#long_polling_subscribe'
  post '/long_polling_publish'  => 'realtimedata#long_polling_publish'
  get '/long_polling_view'  => 'realtimedata#long_polling'
  
  get '/sse_server_sent_events'  => 'realtimedata#sse_server_sent_events'
  get '/sse_server_sent_events_view'  => 'realtimedata#sse_server_sent_events_view'
end
