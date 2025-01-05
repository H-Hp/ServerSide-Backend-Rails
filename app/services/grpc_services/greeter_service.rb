require 'grpc'
require 'greeter_pb'
require 'greeter_services_pb'

#class GreeterService
#module GreeterService
class GreeterServer < Greeter::Greeter::Service
    def self.say_hello(name)
      stub = Greeter::Greeter::Stub.new('localhost:50051', :this_channel_is_insecure)
      request = Greeter::HelloRequest.new(name: name)
      response = stub.say_hello(request)
      response.message
    rescue GRPC::Unavailable => e
      "Error: gRPC server is unavailable (#{e.message})"
    end
  end