defmodule Blog.ArticleController do
  use Blog.Web, :controller
  alias Blog.Article

  def new(conn, _params) do
    changeset = Article.changeset(%Article{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, params) do
    text conn, inspect(params)
  end
end
