require 'grpc'
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'greeter_services_pb'

module GrpcClient
  def self.say_hello(name)
    puts "name: #{name}"
    stub = Greeter::Greeter::Stub.new('localhost:50051', :this_channel_is_insecure)
    puts "stub: #{stub}"
    puts "利用可能なメソッド: #{stub.methods}"  # 利用可能なメソッドを確認
    request = Greeter::HelloRequest.new(name: name)
    puts "request: #{request}"
    #ここまでの処理はうまくいった
    response = stub.say_hello(request) #serve.pyのSayHelloメソッドの呼び出し
    puts "response: #{response}"
    return response.message
    puts "response.message: #{response.message}"
=begin
  
=end
  end
end