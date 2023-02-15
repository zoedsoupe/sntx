defmodule Sntx.BlogPost do
  use Sntx.Schema

  import Ecto.Changeset

  alias Sntx.User.Account

  @required_fields ~w(title body author_id)

  schema "blog_posts" do
    field :body, :string
    field :title, :string

    belongs_to :author, Account
  end

  def changeset(%__MODULE__{} = source, params) do
    source
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:author_id)
  end
end
