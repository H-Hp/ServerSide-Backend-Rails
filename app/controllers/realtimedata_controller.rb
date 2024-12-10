
class RealtimedataController < ApplicationController
  protect_from_forgery #これはCSRF(Cross-Site Request Forgery）の対策

  def web_socket
  end

  #short_polling
  def short_polling_view
  end
  # Optional: method to update the data (for testing purposes)
  def short_polling_update_data
    @@short_polling_data = { message: params[:message] || "変更したらその変更がクライアントに送られる・Updated messagああ" }
    #render json: { status: "Data updated" }
    render json: @@short_polling_data
  end

  include ActionController::Live

  #long_polling
  def long_polling_view
  end
  @@subscribers = {}

  def long_polling_subscribe
    response.headers['Content-Type'] = 'text/plain'
    response.headers['Cache-Control'] = 'no-cache, must-revalidate'

    id = SecureRandom.uuid
    @@subscribers[id] = response.stream
    puts "@@subscribers[id]:#{@@subscribers[id]}"


    begin
      # Keep the connection open
      puts "Keep the connection open"
      sleep
    rescue IOError
      # Client disconnected
      puts "Client disconnected"

    ensure
      @@subscribers.delete(id)
      response.stream.close
    end
  end

  def long_polling_publish
    message = params[:message]
    puts "message:#{message}"
    @@subscribers.each do |id, stream|
      begin
        stream.write(message)
        puts "long_polling_publishのbegin"
      rescue IOError
        puts "long_polling_publishのrescue IOError"
        # Client disconnected, remove from subscribers
        @@subscribers.delete(id)
      end
    end
    @@subscribers.clear

    render plain: 'ok'
  end


  #sse
  def sse_server_sent_events
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Last-Modified'] = Time.now.httpdate

    sse = SSE.new(response.stream, event: "message")

    sse.write({ message: 'Hi there' })

    sleep 2

    sse.write({ message: 'How are you?' })

    sleep 2

    sse.write({ message: 'I am fine' })
  ensure
    sse.close  end

  def sse_server_sent_events_view

  end
end