class AuthController < ApplicationController

  http_basic_authenticate_with name: "admin", password: "secret", only: :basics
  def basics
  end

  def cookie

  end

  def sessions

  end




  def token_auth

  end

  def jwt

  end

  def oauth

  end

  def sso

  end

end
