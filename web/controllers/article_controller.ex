defmodule Blog.ArticleController do
  use Blog.Web, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, params) do
    text conn, inspect(params)
  end
end
