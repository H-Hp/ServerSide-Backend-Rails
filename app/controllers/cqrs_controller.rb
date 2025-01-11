
class CqrsController < ApplicationController
  skip_before_action :verify_authenticity_token #CSRFチェックをスキップする

  #CQRS
  def cqrs
  end

  # クエリ（読み取り）操作
  def index
    records = execute_list_query
    render json: records
  end

  def show
    record = execute_find_query
    render json: record
  end

  # コマンド（書き込み）操作
  def create
    record = execute_create_command
    render json: record, status: :created
  end

  def update
    record = execute_update_command
    render json: record
  end

  private

  # クエリメソッド
  def execute_list_query
    Rails.cache.fetch("cqrs_tests/all", expires_in: 5.minutes) do
      CqrsTest.all.order(created_at: :desc).to_a
    end
  end

  def execute_find_query
    Rails.cache.fetch("cqrs_tests/#{params[:id]}", expires_in: 5.minutes) do
      CqrsTest.find(params[:id])
    end
  end

  # コマンドメソッド
  def execute_create_command
    ActiveRecord::Base.transaction do
      record = CqrsTest.create!(create_params)
      publish_event('created', record)
      invalidate_cache
      record
    end
  end

  def execute_update_command
    ActiveRecord::Base.transaction do
      record = CqrsTest.find(params[:id])
      record.update!(update_params)
      publish_event('updated', record)
      invalidate_cache
      record
    end
  end

  # イベント発行
  def publish_event(action, record)
    event = {
      action: action,
      record_id: record.id,
      name: record.name,
      username: record.username,
      timestamp: Time.current
    }
    
    ActionCable.server.broadcast "cqrs_test_channel", event
  end

  # キャッシュ制御
  def invalidate_cache
    Rails.cache.delete_matched("cqrs_tests/*")
  end

  # ストロングパラメータ
  def create_params
    params.require(:cqrs_test).permit(:name, :username)
  end

  def update_params
    params.require(:cqrs_test).permit(:name, :username)
  end
end