defmodule SportpalWeb.GoogleAuthController do
    use SportpalWeb, :controller
    alias Sportpal.Accounts.User
    alias SportpalWeb.UserAuth
    alias Sportpal.Repo
    plug Ueberauth

    def callback(conn = %{assigns: %{ueberauth_auth: auth}}, params) do
        users_params = %{email: auth.info.email}
        changeset = User.email_changeset(%User{}, users_params)

        insert_or_update_user(conn, changeset)
    end


    defp insert_or_update_user(conn, changeset) do
        case Repo.get_by(User, email: changeset.changes.email) do
            nil ->
                case Repo.insert(changeset) do 
                {:ok, user} ->
                    conn
                    |> put_flash(:info, "User created successfully.")
                    |> UserAuth.log_in_user(user)
                {:error, %Ecto.Changeset{} = changeset} ->
                    conn
                    |> put_flash(:info, "Something went wrong")
                end
            user ->
                UserAuth.log_in_user(conn, user)
        end
    end
end