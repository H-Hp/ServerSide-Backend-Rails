class AuthOpenidController < ApplicationController
    #before_action :authenticate_user!
    helper_method :current_user
    helper_method :user_signed_in?

    def index
    end
    def dashboard
        #@current_user ||= session[:user_name] if session[:user_email]
        #@current_user.name= session[:user_name]
        #@current_user.email=session[:user_email]
        @current_user ||= OpenStruct.new(
            name: session[:user_name],
            email: session[:user_email]
        )
    end

    def create
        puts "a"
        auth = request.env['omniauth.auth']
        puts "auth: #{auth}"
        user = OpenidUser.find_or_create_by_auth(auth)
        
        session[:user_id] = user.id
        #session[:user_name] = user.info.name
        #puts "user.info.name: #{user.info.name}"
        #session[:user_email] = user.info.email
        #puts "user.info.email: #{user.info.email}"

        session[:user_name] = auth.info.name
        puts "user.info.name: #{auth.info.name}"
        session[:user_email] = auth.info.email
        puts "user.info.email: #{auth.info.email}"


        #redirect_to auth_openid_dashboard_path, notice: 'ログインしました'
        redirect_to controller: 'auth_openid', action: 'dashboard', notice: 'ログインしました'

    end
    
    def destroy
        session[:user_id] = nil
        #redirect_to root_path, notice: 'ログアウトしました'
        redirect_to auth_openid_index_path, notice: 'ログアウトしました'
    end
    
    def failure
        puts "認証に失敗しました"
        redirect_to auth_openid_index_path, alert: '認証に失敗しました'
    end

    def authenticate_user!
        puts "authenticate_user!"
        redirect_to auth_openid_index_path unless user_signed_in?
        #redirect_to controller: 'auth_openid', action: 'index'
    end
    
    def current_user
        @current_user ||= OpenidUser.find_by(id: session[:user_id]) if session[:user_id]
        puts "@current_user: #{@current_user}"
    end
    
    def user_signed_in?
        !!current_user
    end
end