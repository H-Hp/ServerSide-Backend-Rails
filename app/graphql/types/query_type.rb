# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject

    # フィールド(:user)の説明と引数を記載します。
    field :post, Types::PostType, null: true do
      description "Find post by ID" #省略可
      argument :id, ID, required: true
    end

    # 実行のコマンド(リゾルバ)を書きます
    def post(id:)
      Post.find(id)
    end
    def posts(page: nil, items: nil)
      Post.all
    end

    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World!"
    end
  end
end
