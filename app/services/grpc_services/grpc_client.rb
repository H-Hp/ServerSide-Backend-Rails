require 'grpc'
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'greeter_services_pb'

module GrpcClient
  def self.say_hello(name)
    stub = Greeter::Greeter::Stub.new('localhost:50051', :this_channel_is_insecure)
    request = Greeter::HelloRequest.new(name: name)
    response = stub.say_hello(request)
    response.message
  end
end