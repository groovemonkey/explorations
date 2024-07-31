defmodule ExplorationsWeb.PageController do
  use ExplorationsWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
