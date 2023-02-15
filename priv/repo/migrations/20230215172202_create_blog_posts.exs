defmodule Sntx.Repo.Migrations.CreateBlogPosts do
  use Ecto.Migration

  def change do
    create table(:blog_posts) do
      add :title, :string, null: false
      add :body, :string, null: false

      add :author_id, references(:user_accounts, type: :binary_id, name: :id), null: false
    end

    create index(:blog_posts, [:title])
  end
end
