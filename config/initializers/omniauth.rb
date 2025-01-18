Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, 
      ENV['GOOGLE_CLIENT_ID'], 
      ENV['GOOGLE_CLIENT_SECRET'],
      {
        scope: 'email,profile',
        prompt: 'select_account',

        #scope: 'email,profile',
        #prompt: 'select_account',
        image_aspect_ratio: 'square',
        image_size: 50,
        #access_type: 'offline',
        #redirect_uri: 'http://localhost:3000/auth/google_oauth2/callback', # 明示的に指定
        redirect_uri: 'http://127.0.0.1:3000/auth/google_oauth2/callback',
        name: 'google_oauth2'  # この名前をgoogle_oauth2に変更
      }
  end

# Development環境での設定
if Rails.env.development?
  OmniAuth.config.allowed_request_methods = [:post, :get]
  # SSL証明書の検証を無効化（開発環境のみ）
  OmniAuth.config.full_host = 'http://127.0.0.1:3000'
end