defmodule Api007.Auth.User do
	use Ecto.Schema
  import Ecto.Changeset
	# alias Api007.Blogpost.Post

  schema "users" do
		field :email, :string
		field :name, :string
    field :is_active, :boolean, default: false
    field :password, :string, virtual: true
    field :password_hash, :string
		has_many :posts, Api007.Blogpost.Post

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :name, :is_active, :password])
    |> validate_required([:email, :name, :is_active, :password])
    |> unique_constraint(:email)
		|> put_password_hash()
  end

	def set_active_changeset(user) do
		user
		|> cast(%{}, [:is_active])
		|> put_change(:is_active, true)
	end

	def set_inactive_changeset(user) do
		user
		|> cast(%{}, [:is_active])
		|> put_change(:is_active, false)
	end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, password_hash: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset) do
    changeset
	end
end