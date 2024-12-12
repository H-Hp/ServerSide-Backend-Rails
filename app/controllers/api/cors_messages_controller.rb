module Api
  class CorsMessagesController < ApplicationController
    def index
      render json: { message: "Hello from Rails!" }
    end
  end
end