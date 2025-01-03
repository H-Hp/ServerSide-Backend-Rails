
class SearchenginesElasticsearchController < ApplicationController
  def index

    #データ取得
    #response = ElasticsearchTest.search 'bill'
    response = ElasticsearchTest.search('林')    
    puts  response #<Elasticsearch::Model::Response::Result:0x00007fe181b8ee20>
    puts "response.took: #{response.took}" #10 ElasticsearchTest Load (1.4ms)  SELECT "elasticsearch_tests".* FROM "elasticsearch_tests" WHERE "elasticsearch_tests"."id" = $1  [["id", 1]]
    puts "response.records.to_a: #{response.records.to_a}" #[#<ElasticsearchTest id: 1, name: "林", username: "ring", created_at: "2025-01-03 11:42:40.628672000 +0000", updated_at: "2025-01-03 11:42:40.628672000 +0000">]
    puts "response.results.total: #{response.results.total}" #1
    #puts response.results.first._score
    #puts response.results.first._source.title
  end
end