defmodule Blog.CommentController do
  use Blog.Web, :controller
  alias Blog.Comment
  alias Blog.Article

  plug :scrub_params, "comment" when action in [:create] # convert require params from "" to nil

  def create(conn, %{"article_id" => article_id, "comment" => comment_params}) do
    changeset = Comment.changeset(%Comment{}, Map.put(comment_params, "article_id", article_id))
    article = Article |> Repo.get(article_id) |> Repo.preload([:comments])

    if changeset.valid? do
      Repo.insert(changeset)
      conn
      |> put_flash(:info, "Comment added.")
      |> redirect(to: article_path(conn, :show, article))
    else
      {:error, changeset} = Repo.insert(changeset) # to show beautifull error info
      render(conn, Blog.ArticleView, "show.html", article: article, changeset: changeset)
    end
  end

  def delete(conn, %{"article_id" => article_id, "id" => id}) do
    article = Repo.get(Article, article_id)
    comment = Repo.get(Comment, id)
    Repo.delete!(comment)
    conn
    |> put_flash(:info, "Comment deleted!")
    |> redirect(to: article_path(conn, :show, article))
  end
end
