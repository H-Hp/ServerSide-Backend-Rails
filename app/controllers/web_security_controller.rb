require 'bcrypt'

class WebSecurityController < ApplicationController

  
  def hash
    #MD5は使わないようにしよう・MD5は衝突が発生しやすいため、最新のアプリケーションではSHA-256やSHA-3などのより強力なハッシュ関数を使うことが推奨されています

    #BcryptとScryptの使い分けはBcryptは一般的にWebアプリケーションのパスワード保護に使用されています。一方、ScryptはBitcoinなどの暗号通貨や、ディスクの暗号化など、より高度なセキュリティが求められる分野で使用されています。

    #いつユーザーのパスワードをハッシュ化させるのか？：Bcryptを使用してユーザーのパスワードをハッシュ化する最適なタイミングは、ユーザーの新規登録時、つまりパスワードをサーバー側で受け取った直後。ハッシュ化させたパスワードをDBに格納し、ログイン認証時に入力されたパスワードを同じ方法でハッシュ化し、データベースに保存されているハッシュと比較することができます。

    #password = "mypassword"
    user_password="nikoniko777" #ユーザー新規登録時にユーザーが設定したパスワード

    # パスワードをハッシュ化する
    salt = BCrypt::Engine.generate_salt
    #hashed_password = BCrypt::Engine.hash_secret(password, salt)
    hashed_password = BCrypt::Engine.hash_secret(user_password, salt)
    puts hashed_password # 出力例: $2a$12$C5.pO남PK7W7Mh5n2CtHen637sVskmxahOm8vbrzBES8bY4pVMea

    $db_hashed_user_password = hashed_password #このハッシュ化されたパスワードをDBに保存
  end

  def bcrypt_longin
    input_password = params[:password]

    # ハッシュ値を検証する
    if BCrypt::Password.new($db_hashed_user_password) == input_password
      puts "パスワードが一致しました。ログイン成功"
      flash[:notice] = "パスワードが一致しました。ログイン成功"
    else
      puts "パスワードが一致しませんでした。ログイン失敗"
      flash[:notice] = "パスワードが一致しませんでした。ログイン失敗"
    end

    redirect_to hash_path

    # コストを指定してハッシュ化する (コストが高いほど計算時間が長くなる)
    costly_hashed_password = BCrypt::Password.create(input_password, cost: 12)
    puts costly_hashed_password # 出力例: $2a$12$yfqTFgxZYcUN7Bj81vziluaXPFM1V6YGFg8dyXcM/Unu28jhv7/26    
  end

  def cors
    #APIを外部からアクセス可能にするために、CORS（Cross-Origin Resource Sharing）を設定する必要があります。
  end

  def csp
  end


  def csrf
  end
  #skip_before_action :verify_authenticity_token, only: [:csrf_create] #csrf対策をスキップするのでコメントアウトするとエラー消える
  def csrf_logout
    # カスタムレスポンスを返す
    render json: {
      message: "ログアウトしました",
    }
  end
end
