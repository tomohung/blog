defmodule Blog.Article do
  use Blog.Web, :model

  schema "articles" do
    field :title, :string
    field :text, :string
    has_many :comments, Blog.Comment, on_delete: :delete_all

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :text])
    |> validate_required([:title, :text])
    |> validate_length(:title, min: 5)
  end
end
