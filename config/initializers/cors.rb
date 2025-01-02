Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' #全てのオリジン
    #origins 'http://localhost:3000' # Reactアプリケーションのオリジン
    #origins 'http://127.0.0.1:3000/graphql' # Reactアプリケーションのオリジン
    #origins 'http://127.0.0.1:5500'  # 別アプリケーションのオリジン・VsCodeのLiveServer

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :delete, :options, :head]
  end
end 