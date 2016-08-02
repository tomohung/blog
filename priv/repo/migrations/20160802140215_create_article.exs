defmodule Blog.Repo.Migrations.CreateArticle do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :text, :text

      timestamps()
    end

  end
end
