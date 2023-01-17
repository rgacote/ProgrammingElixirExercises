defmodule Issues.GithubIssues do
  @user_agent [{"User-agent", "Elixir dave@pragprog.com"}]
  @github_url Application.get_env(:issues, :github_url)

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    bob = "#{@github_url}/repos/#{user}/#{project}/issues"
    IO.inspect(bob)
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    status_code
    |> check_for_error()

    body
    |> Poison.Parser.parse!()
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
