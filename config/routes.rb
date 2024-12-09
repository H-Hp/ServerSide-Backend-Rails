Rails.application.routes.draw do
  root 'application#index'

  #API
  get 'api/rest'
  resources :api_rest
  get '/graphql'  => 'api#graphql'
  get '/grpc'  => 'api#grpc'
  resources :posts
  get '/posts/index'  => 'posts#index'
  #get '/'  => 'api#index'

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
  get '/redis'  => 'cache_cdn_redis#redis'
  
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
  get '/short_polling'  => 'realtimedata#short_polling'
  get '/long_polling'  => 'realtimedata#long_polling'
  get '/sse_server_sent_events'  => 'realtimedata#sse_server_sent_events'

end
