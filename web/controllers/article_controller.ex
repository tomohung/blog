defmodule Blog.ArticleController do
  use Blog.Web, :controller
  alias Blog.Article

  def index(conn, _params) do
    articles = Repo.all(Article)
    render conn, "index.html", articles: articles
  end

  def new(conn, _params) do
    changeset = Article.changeset(%Article{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"article" => article_params}) do
    changeset = Article.changeset(%Article{}, article_params)
    case Repo.insert(changeset) do
      {:ok, article} ->
        conn
        |> redirect(to: article_path(conn, :show, article))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def show(conn, %{"id" => id}) do
    article = Repo.get(Article, id)
    render conn, "show.html", article: article
  end
end
