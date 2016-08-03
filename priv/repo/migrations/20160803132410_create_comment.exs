defmodule Blog.Repo.Migrations.CreateComment do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :commenter, :string
      add :body, :text
      add :article_id, references(:articles, on_delete: :nothing)

      timestamps()
    end
    create index(:comments, [:article_id])

  end
end
