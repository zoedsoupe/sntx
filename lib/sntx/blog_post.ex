defmodule Sntx.BlogPost do
  use Sntx.Schema

  import Ecto.Changeset
  import SntxWeb.Gettext

  alias Sntx.Repo
  alias Sntx.User.Account

  @required_fields ~w(title body author_id)a

  schema "blog_posts" do
    field :body, :string
    field :title, :string

    belongs_to :author, Account

    timestamps()
  end

  def changeset(%__MODULE__{} = source, params) do
    source
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> foreign_key_constraint(:author_id)
  end

  def create(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> Repo.insert()
  end

  def list do
    Repo.all(__MODULE__)
  end

  def get(id) do
    case Repo.get_by(__MODULE__, id: id) do
      nil -> {:error, dgettext("global", "Blog Post not found")}
      blog_post -> {:ok, blog_post}
    end
  end
end
