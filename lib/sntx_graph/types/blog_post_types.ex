defmodule SntxGraph.BlogPostTypes do
  use Absinthe.Schema.Notation

  object :blog_post do
    field :id, :uuid4
    field :title, :string
    field :body, :string
    field :author, :user_account
  end

  input_object :blog_post_create_input do
    field :title, non_null(:string)
    field :body, non_null(:string)
  end

  input_object :blog_post_update_input do
    field :id, non_null(:uuid4)
    field :title, :string
    field :body, :string
  end
end
