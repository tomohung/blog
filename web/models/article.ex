defmodule Blog.Article do
  use Blog.Web, :model

  schema "articles" do
    field :title, :string
    field :text, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :text])
    |> validate_required([:title, :text])
  end
end
