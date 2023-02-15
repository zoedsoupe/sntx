defmodule SntxGraph.BlogPostQueries do
  use Absinthe.Schema.Notation

  alias SntxGraph.BlogPostResolver

  object :blog_post_queries do
    field :blog_posts, list_of(:blog_post) do
      resolve(&BlogPostResolver.index/2)
    end

    field :blog_post, :blog_post do
      arg :id, :uuid4

      resolve(&BlogPostResolver.get/2)
    end
  end
end
