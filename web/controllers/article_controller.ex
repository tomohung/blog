defmodule Blog.ArticleController do
  use Blog.Web, :controller
  alias Blog.Article
  alias Blog.Comment

  def index(conn, _params) do
    articles = Repo.all(Article)
    render conn, "index.html", articles: articles
  end

  def show(conn, %{"id" => id}) do
    article = Repo.get(Article, id) |> Repo.preload([:comments])
    changeset = Comment.changeset(%Comment{})
    render conn, "show.html", article: article, changeset: changeset
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
        |> put_flash(:info, "Article created")
        |> redirect(to: article_path(conn, :show, article))
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => id}) do
    article = Repo.get(Article, id)
    changeset = Article.changeset(article)
    render conn, "edit.html", article: article, changeset: changeset
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Repo.get(Article, id)
    changeset = Article.changeset(article, article_params)
    case Repo.update(changeset) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article updated")
        |> redirect(to: article_path(conn, :show, article))
      {:error, changeset} ->
        render conn, "edit.html", article: article, changeset: changeset
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Repo.get(Article, id)

    # use ! because it should always work, otherwise raise an error
    Repo.delete!(article)
    conn
    |> put_flash(:info, "Article deleted")
    |> redirect(to: article_path(conn, :index))

  end

end
