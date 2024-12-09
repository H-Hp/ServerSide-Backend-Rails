#require 'bcrypt'

class WebSecurityController < ApplicationController

  
  def hash
    #MD5は使わないようにしよう・MD5は衝突が発生しやすいため、最新のアプリケーションではSHA-256やSHA-3などのより強力なハッシュ関数を使うことが推奨されています

    #BcryptとScryptの使い分けはBcryptは一般的にWebアプリケーションのパスワード保護に使用されています。一方、ScryptはBitcoinなどの暗号通貨や、ディスクの暗号化など、より高度なセキュリティが求められる分野で使用されています。

    # パスワードをハッシュ化する
  password = "mypassword"
  salt = BCrypt::Engine.generate_salt
  hashed_password = BCrypt::Engine.hash_secret(password, salt)
  puts hashed_password
  # 出力例: $2a$12$C5.pO남PK7W7Mh5n2CtHen637sVskmxahOm8vbrzBES8bY4pVMea

  # ハッシュ値を検証する
  test_password = "mypassword"
  if BCrypt::Password.new(hashed_password) == test_password
    puts "パスワードが一致しました"
  else
    puts "パスワードが一致しませんでした"
  end

  # コストを指定してハッシュ化する (コストが高いほど計算時間が長くなる)
  costly_hashed_password = BCrypt::Password.create(password, cost: 12)
  puts costly_hashed_password
  # 出力例: $2a$12$yfqTFgxZYcUN7Bj81vziluaXPFM1V6YGFg8dyXcM/Unu28jhv7/26

  end

  def cors
    #APIを外部からアクセス可能にするために、CORS（Cross-Origin Resource Sharing）を設定する必要があります。
  end

  def csp
    
  end
end
