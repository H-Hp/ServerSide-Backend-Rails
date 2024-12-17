class AuthController < ApplicationController

  http_basic_authenticate_with name: "admin", password: "secret", only: :basics
  def basics
  end

  #cookie_session
  #Cookie認証:セッション情報をクライアント側（ブラウザのCookie）に保存
  #Session認証:セッション情報をサーバー側で管理
  #「cookieベース」と「セッションベース」の認証は実装上ほぼ同じになります。より明確な違いを作るには、セッションストアの設定を変更する必要があります。
  #実際のコードレベルでは、Railsではsessionメソッドを使用するため、ほとんど同じように見えます。
  #実際の違いを作るには、Railsの設定を変更して別のセッションストアを使用する必要があります。例えば、`ActiveRecord::SessionStore`を使用してデータベースにセッション情報を保存したり、`RedisSessionStore`を使用してRedisにセッション情報を保存したりすることができます。
  helper_method :current_user, :logged_in?
  def cookie_session
    @user = current_user
  end
  def cookie_session_user_new #新規登録ページ表示
    @user = User.new
  end
  def cookie_session_user_create #新規登録処理
    @user = User.new(user_params)
    if @user.save
      # 新規登録成功時に自動ログイン
      session[:user_id] = @user.id
      redirect_to cookie_session_path, notice: 'アカウントを作成しました'
    else
      render :new
    end
  end
  def sessions_new #ログインページ表示

  end
  def sessions_create #ログイン処理
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      # ログイン成功
      session[:user_id] = user.id
      redirect_to cookie_session_path, notice: 'ログインに成功しました'
    else
      # ログイン失敗
      flash.now[:alert] = 'メールアドレスまたはパスワードが間違っています'
      render :new
    end
  end

  def sessions_destroy
    # ログアウト
    session.delete(:user_id)
    redirect_to cookie_session_path, notice: 'ログアウトしました'
  end



  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = 'ログインしてください'
      redirect_to login_path
    end
  end


  def oauth

  end

  def sso

  end

end
