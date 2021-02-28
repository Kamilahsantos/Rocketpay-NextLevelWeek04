defmodule RocketpayWeb.UsersController do
  use RocketpayWeb, :controller

  alias Rocketpay.User

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rocketpay.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  defp handle_response({:error, result}, conn) do
    conn
    |> put_status(:bad_request)
    |>put_view(RocketpayWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
