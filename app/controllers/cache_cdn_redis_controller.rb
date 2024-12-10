class CacheCdnRedisController < ApplicationController
  def redis_view
    @stored_value = $redis.get("my_key")
  end

  def set_value
    $redis.set("my_key", params[:value])
    redirect_to redis_view_path, notice: 'Value has been set in Redis'
  end
end