# frozen_string_literal: true

module Types
  class PostType < Types::BaseObject
    field :id, Int
    field :title, String
    field :body, String
  end
end
