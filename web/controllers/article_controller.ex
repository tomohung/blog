defmodule Blog.ArticleController do
  use Blog.Web, :controller
  alias Blog.Article

  def new(conn, _params) do
    changeset = Article.changeset(%Article{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"article" => article_params}) do
    changeset = Article.changeset(%Article{}, article_params)
    case Repo.insert(changeset) do
      {:ok, article} ->
        conn
        |> redirect(to: article_path(conn, article.id))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
