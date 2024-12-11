require 'bunny'
class MqRabbitmqController < ApplicationController
  def index
    # メッセージ一覧ページを表示するアクション
    # 現在は空の配列を設定していますが、将来的にはメッセージ履歴を表示する可能性があります
    @messages = []
  end

  #キューにメッセージを追加する（基本）
  def publish
    message = params[:message]
    puts "message: #{message}"

    # RabbitMQに接続
    conn = Bunny.new(:host => "localhost", :vhost => "/", :user => "guest", :pass => "guest")
    conn.start

    # channelを作成
    ch = conn.create_channel

    # queue1というキューを作成
    # キューが無い場合は作成（既にある場合もエラーにはならない）
    q  = ch.queue("queue1")
    #q  = ch.queue("queue1", :durable => true) # :durable => trueとすることで、再起動してもキューは残る

    # queue1にメッセージを追加
    #q.publish("Hello, world!")
    q.publish(message)
    #q.publish("Hello, world!", :persistent => true) # :persistent => trueとすることで、再起動してもメッセージは残る

    # close
    conn.stop

    # メッセージ一覧ページにリダイレクトし、成功メッセージを表示
    redirect_to mq_rabbitmq_subscribe_path, notice: 'Message sent successfully!'

  end

  def subscribe
    # RabbitMQに接続
    conn = Bunny.new(:host => "localhost", :vhost => "/", :user => "guest", :pass => "guest")
    conn.start

    # channelを作成
    ch = conn.create_channel

    # queue1というキューを作成
    q  = ch.queue("queue1")
    #q  = ch.queue("queue1", :durable => true)

    # メッセージを取得
    # 取得するとキューからメッセージは削除される
    q.subscribe do |delivery_info, properties, msg|
      p "queue  = #{q.name}" #=> "queue  = queue1"
      @message=msg
      p "message= #{msg}"    #=> "message= Hello, world!"
    end

    # close
    conn.stop
  end
end