class ElasticsearchTest < ApplicationRecord
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks #レコードの更新をした際に Elasticsearch のドキュメントを更新するクエリを投げてくれます
end
