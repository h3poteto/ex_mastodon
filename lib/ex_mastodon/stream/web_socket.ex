defmodule ExMastodon.Stream.WebSocket do
  use WebSockex

  def start_link(bot_handler, initial_state, url, token) do
    stream_url = "#{url}&access_token=#{token}"
    state = %{
      initial_state: initial_state,
      bot_handler: bot_handler
    }
    WebSockex.start_link(stream_url, __MODULE__, state)
  end

  @doc false
  def handle_connect(conn, %{bot_handler: bot_handler} = state) do
    bot_handler.handle_connect(conn, state)
  end

  @doc false
  def handle_frame({type, msg} = _frame, %{bot_handler: bot_handler} = state) do
    %{"event" => event, "payload" => payload} = Poison.decode!(msg)
    bot_handler.handle_frame(type, event, Poison.decode!(payload), state)
  end

  @doc false
  def handle_cast(message, %{bot_handler: bot_handler} = state) do
    bot_handler.handle_cast(message, state)
  end

  @doc false
  def handle_info(message, %{bot_handler: bot_handler} = state) do
    bot_handler.handle_info(message, state)
  end

  @doc false
  def handle_disconnect(connection_status_map, %{bot_handler: bot_handler} = state) do
    bot_handler.handle_disconnect(connection_status_map, state)
  end

  @doc false
  def terminate(close_reason, %{bot_handler: bot_handler} = state) do
    bot_handler.terminate(close_reason, state)
  end
end
