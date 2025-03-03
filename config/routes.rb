Rails.application.routes.draw do

  get 'my_test/hello'
  root 'application#index'

  #API
  resources :api_rest

  get '/graphql'  => 'api#graphql'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute" #これによって、/graphqlのURLにPOSTでアクセスすることでGraphQLのメソッドが実行されます。

  get '/grpc'  => 'api#grpc'

  #authentication
  get '/basics'  => 'auth#basics'
  
  get '/cookie_session'  => 'auth#cookie_session'
  get '/user_new'  => 'auth#cookie_session_user_new' #ユーザー新規登録ページ表示
  post '/user_create'  => 'auth#cookie_session_user_create' #ユーザー新規登録処理
  get '/session_new'  => 'auth#sessions_new' #ログインページ表示
  post '/session_login'  => 'auth#sessions_create' #ログイン処理
  delete '/session_logout', to: 'auth#sessions_destroy' #ログアウト処理
  resources :cookie_session, only: [:show]

  # jwtのトークンベース認証のエンドポイント
  get '/jwt'  => 'auth_jwt#jwt'
  post '/jwt_register', to: 'auth_jwt#register'
  post '/jwt_login', to: 'auth_jwt#login'
  get '/jwt_profile', to: 'auth_jwt#profile'

  get '/sso'  => 'auth#sso'

  get '/saml'  => 'auth_saml#saml_view'
  #get '/saml/callback', to: 'auth_saml#create'
  get '/auth/saml/callback', to: 'auth_saml#create'
  post '/auth/saml/callback', to: 'auth_saml#create'
  get '/auth/failure', to: 'auth_saml#failure'
  #get '/saml/failure', to: 'auth_saml#failure'
  get '/saml/logout', to: 'auth_saml#destroy'
  resource :auth_saml, only: [:create, :destroy]
  #delete '/saml_logout', to: 'auth_saml#delete'

  #OpenID Connect
  #get '/oauth'  => 'auth#oauth'
  get '/openid/index', to: 'auth_openid#index' , as: 'auth_openid_index'
  get '/openid/failure', to: 'auth_openid#failure'
  get '/openid/logout', to: 'auth_openid#destroy'
  get '/openid/dashboard', to: 'auth_openid#dashboard',as: 'auth_openid_dashboard_path'
  #get '/apenidconnect/google_oauth2/callback', to: 'auth_openid#create'
  #get '/openid/:provider/callback', to: 'auth_openid#create'
  #get '/apenidconnect/:provider/callback', to: 'auth_openid#create'
  #get '/auth/google_oauth2/callback', to: 'auth_openid#create'
  get '/auth/:provider/callback', to: 'auth_openid#create'
  #post '/auth/:provider/callback', to: 'sessions#create'
  #post '/auth/:provider/callback', to: 'auth_openid#create'

  #web_security
  #get 'web_security/hash'
  get '/hash'  => 'web_security#hash' 
  post '/bcrypt_longin'  => 'web_security#bcrypt_longin' 
  get '/csp'  => 'web_security#csp'
  get '/cors'  => 'web_security#cors' 
  namespace :api do
    resources :cors_messages, only: [:index]
  end 
  get '/csrf'  => 'web_security#csrf'
  post 'csrf_logout' => 'web_security#csrf_logout' 
  

  #cache_cdn
  get '/redis_view'  => 'cache_cdn_redis#redis_view'
  post 'redis_demo', to: 'cache_cdn_redis#set_value'
  
  #Designpatterns
  get '/gof_design_patterns_claude'  => 'designpatterns#gof_design_patterns_claude'
  get '/gof_design_patterns_v0'  => 'designpatterns#gof_design_patterns_v0'
  #get '/cqrs'  => 'cqrs#cqrs'
  resources :cqrs, only: [:index, :show, :create, :update]
  get '/event_sourcing'  => 'event_sourcing#index'
  get 'event_sourcing/:id', to: 'event_sourcing#show', as: :show_event_sourcing
  resources :event_sourcing do
    member do
      get :edit_password
      patch :change_password
      #post :change_password
    end
  end

  #serverless
  get '/aws_lambda'  => 'serverless#aws_lambda'

  #searchengines
  get '/elasticsearch'  => 'searchengines_elasticsearch#index'

  #mq_rabbitmq
  get '/mq_rabbitmq_view'  => 'mq_rabbitmq#index'
  post '/mq_rabbitmq_publish'  => 'mq_rabbitmq#publish'
  get '/mq_rabbitmq_subscribe'  => 'mq_rabbitmq#subscribe'
  #get '/mq_rabbitmq_show'  => 'mq_rabbitmq#show'


  #realtimedata
  get '/web_socket'  => 'realtimedata#web_socket'

  get '/short_polling_view'  => 'realtimedata#short_polling_view'
  get '/short_polling_update_data'  => 'realtimedata#short_polling_update_data'
  
  get '/long_polling_subscribe'  => 'realtimedata#long_polling_subscribe'
  post '/long_polling_publish'  => 'realtimedata#long_polling_publish'
  get '/long_polling_view'  => 'realtimedata#long_polling'
  
  get '/sse_server_sent_events'  => 'realtimedata#sse_server_sent_events'
  get '/sse_server_sent_events_view'  => 'realtimedata#sse_server_sent_events_view'


  #Frontend
  get '/bem'  => 'frontend#bem'
  get '/react'  => 'frontend#react'
  get '/vue', to: 'frontend#vue'
  get '/typescript', to: 'frontend#typescript'
  get '/tailwind', to: 'frontend#tailwind'
  get '/web_component', to: 'frontend#web_component'
  get '/pwa', to: 'frontend#pwa'
 


end
