defmodule SntxGraph.BlogPostResolver do
  alias Sntx.BlogPost

  def index(_, _resolution) do
    {:ok, BlogPost.list()}
  end

  def get(%{id: id}, _resolution) do
    case BlogPost.get(id) do
      {:ok, post} -> {:ok, post}
      _ -> {:error, :not_found}
    end
  end
end
