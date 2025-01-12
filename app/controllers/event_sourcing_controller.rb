
class EventSourcingController < ApplicationController
  def index
    @es_tests = EsTest.all
  end

  def show
    @es_test = EsTest.find(params[:id])
    @password_history = @es_test.password_change_history
  end

  def edit
    @es_test = EsTest.find(params[:id])
  end

  def change_password
    @es_test = EsTest.find(params[:id])
    
    if @es_test.change_password(password_params[:new_password])
      redirect_to event_sourcing_path, notice: 'パスワードが正常に変更されました'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def password_history
    @es_test = EsTest.find(params[:id])
    render json: @es_test.password_change_history
  end

  private

  def password_params
    params.require(:es_test).permit(:new_password)
  end
end