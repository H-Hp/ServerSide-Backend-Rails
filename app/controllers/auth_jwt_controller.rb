class AuthJwtController < ApplicationController
    # API モードの場合、CSRF保護を無効化
    protect_from_forgery with: :null_session

    # あるいは、APIコントローラー専用の対応
    skip_before_action :verify_authenticity_token
=begin

ユーザー登録:
curl -X POST http://localhost:3000/jwt_register \
  -H "Content-Type: application/json" \
  -d '{"email": "pp@example.com", "password": "ppppppp", "password_confirmation": "ppppppp"}'

ログイン:
curl -X POST http://localhost:3000/jwt_login \
  -H "Content-Type: application/json" \
  -d '{"email": "pp@example.com", "password": "ppppppp"}'

プロファイル取得（認証が必要）:
curl -X GET http://localhost:3000/jwt_profile \
  -H "Authorization: Bearer <your_token_here>"

curl -X GET http://localhost:3000/jwt_profile \
  -H "Authorization: b5ce4919b49a7e3b0d79"


=end


  before_action :authorize_request, except: [:register, :login, :jwt]

  def jwt
    render json: { message: 'Welcome to JWT Auth API' }
  end

  def register
    @user = UserJwt.new(user_params)
    if @user.save
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { user: @user, token: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    @user = UserJwt.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      render json: { user: @user, token: token }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def profile
    render json: @current_user, status: :ok
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = UserJwt.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
