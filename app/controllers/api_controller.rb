require 'grpc_services/grpc_client'
#require 'grpc_services/greeter_service'

class ApiController < ApplicationController
  def graphql
    query_string = "
{
  post(id: 1) {
    id
    title
  }
}"
    result_hash = ServerSideBackendRailsSchema.execute(query_string)

    #puts "id: #{result_hash}"
    # データへのアクセス
    if result_hash["data"] && result_hash["data"]["post"]
      post = result_hash["data"]["post"]
      puts "id: #{post['id']}, title: #{post['title']}"
    else
      puts "データが見つかりませんでした"
    end
  end

  def grpc
    @message = GrpcClient.say_hello('Rails User')
    #@message = GreeterService.say_hello("name")
  end

end
