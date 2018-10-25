defmodule ExMastodon.REST.API.Client do
  defstruct [:url, :access_token]
end


defmodule ExMastodon.REST.API do
  def client(base_url, access_token) do
    %ExMastodon.REST.API.Client{
      url: base_url,
      access_token: access_token,
    }
  end

  def get(%ExMastodon.REST.API.Client{url: url, access_token: access_token}, path, params \\ []) do
    headers = ["Authorization": "Bearer #{access_token}", "Accept": "Application/json; Charset=utf-8"]
    parameters = params
    |> Enum.map(fn({key, value}) ->
      "#{key}=#{value}"
    end)
    |> Enum.join("&")
    {:ok, response} = HTTPoison.get("#{url}#{path}?#{parameters}", headers)
    {:ok, json} = response.body
    |> Poison.decode
    {:ok, json, response.headers}
  end

  def post(%ExMastodon.REST.API.Client{url: url, access_token: access_token}, path, body \\ %{}) do
    headers = ["Authorization": "Bearer #{access_token}", "Accept": "Application/json; Charset=utf-8"]
    {:ok, response} = HTTPoison.post("#{url}#{path}", Poison.encode!(body), headers)
    {:ok, json} = response.body
    |> Poison.decode
    {:ok, json, response.headers}
  end

  def patch(%ExMastodon.REST.API.Client{url: url, access_token: access_token}, path, body \\ %{}) do
    headers = ["Authorization": "Bearer #{access_token}", "Accept": "Application/json; Charset=utf-8"]
    {:ok, response} = HTTPoison.patch("#{url}#{path}", Poison.encode!(body), headers)
    {:ok, json} = response.body
    |> Poison.decode
    {:ok, json, response.headers}
  end

  def delete(%ExMastodon.REST.API.Client{url: url, access_token: access_token}, path) do
    headers = ["Authorization": "Bearer #{access_token}", "Accept": "Application/json; Charset=utf-8"]
    {:ok, response} = HTTPoison.delete("#{url}#{path}", headers)
    {:ok, json} = response.body
    |> Poison.decode
    {:ok, json, response.headers}
  end
end
