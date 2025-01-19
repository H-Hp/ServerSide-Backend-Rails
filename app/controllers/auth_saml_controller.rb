class AuthSamlController < ApplicationController
  #skip_before_action :verify_authenticity_token, only: [:acs]
  protect_from_forgery with: :exception
  helper_method :current_user
  skip_before_action :verify_authenticity_token, only: [:create]

  def saml_view
    @user_attributes = session[:user_attributes] # セッションから値を取得
    if @user_attributes
      puts "セッション情報：#{@user_attributes}"
      # @user_attributes を使った処理
      #@name = @user_attributes[:name]
      #@email = @user_attributes[:email]
      #@attributes = @user_attributes[:attributes]
      @email = @user_attributes['urn:oid:1.2.840.113549.1.9.1']&.first
      @first_name = @user_attributes['urn:oid:2.5.4.42']&.first
      @last_name = @user_attributes['urn:oid:2.5.4.4']&.first

      puts "Email: #{@email}"
      puts "First Name: #{@first_name}"
      puts "Last Name: #{@last_name}"
    else
      puts "セッション情報がありません"
    end
  end

  def create
    #Rails.logger.info "あSAML Callback received: #{request.env['omniauth.auth']}"
    puts "createアクション"
    auth = request.env['omniauth.auth']
    #session[:user_attributes] = {
      #name: auth.info.name,
      #email: auth.info.email,
      #attributes: auth.extra.raw_info.attributes
    #}
    session[:user_attributes] = auth.extra.raw_info.attributes
    
    puts "auth: #{auth}"
    #redirect_to root_path, notice: 'Signed in successfully'
    #redirect_to controller: 'auth_saml', action: 'saml_view', notice: 'Signed in successfully'
    redirect_to saml_path, notice: 'Signed in successfully'
  end

  def destroy
    session[:user_attributes] = nil
    #redirect_to root_path, notice: 'Signed out successfully'
    redirect_to controller: 'auth_saml', action: 'saml_view', notice: 'Signed out successfully'
  end

  def failure
    #redirect_to root_path, alert: 'Authentication failed'
    redirect_to controller: 'auth_saml', action: 'saml_view', alert: 'Authentication failed'
  end

  private
  
  def current_user
    @current_user ||= session[:user_attributes] if session[:user_attributes]
  end
  
  def authenticate_user!
    unless current_user
      #redirect_to root_path, alert: 'Please sign in first'
      redirect_to controller: 'auth_saml', action: 'saml_view', alert: 'Please sign in first'
    end
  end
end