defmodule SntxGraph.BlogPostResolver do
  import SntxWeb.Payload

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

  def create(%{input: params}, %{context: %{user: user}}) do
    params
    |> Map.put(:author_id, user.id)
    |> BlogPost.create()
    |> case do
      {:ok, blog_post} -> {:ok, blog_post}
      error -> mutation_error_payload(error)
    end
  end

  def update(%{input: params}, %{context: %{user: user}}) do
    with {:ok, blog_post} <- BlogPost.get(params.id) do
      if blog_post.author_id == user.id do
        BlogPost.update(blog_post, params)
      else
        {:error, :not_blog_post_author}
      end
    end
  end

  def delete(%{id: id}, %{context: %{user: user}}) do
    with {:ok, blog_post} <- BlogPost.get(id) do
      if blog_post.author_id == user.id do
        BlogPost.delete(blog_post)
      else
        {:error, :not_blog_post_author}
      end
    end
  end
end
