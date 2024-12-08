Rails.application.routes.draw do
  get 'web_security/hash'
  resources :posts
  root 'posts#index'
  get '/'  => 'posts#index'

end
