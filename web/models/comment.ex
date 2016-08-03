defmodule Blog.Comment do
  use Blog.Web, :model

  schema "comments" do
    field :commenter, :string
    field :body, :string
    belongs_to :article, Blog.Article

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:commenter, :body, :article_id])
    |> validate_required([:commenter, :body, :article_id])
  end
end
