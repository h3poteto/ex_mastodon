defmodule ExMastodon.Stream do
  defmacro __using__(_) do
    quote do
      @doc false
      def handle_connect(_conn, state) do
        {:ok, state}
      end

      @doc false
      def handle_frame(_frame, state), do: {:ok, state}

      @doc false
      def handle_cast(_message, state), do: {:ok, state}

      @doc false
      def handle_info(_message, state), do: {:ok, state}

      @doc false
      def handle_disconnect(_connection_status_map, state), do: {:ok, state}

      @doc false
      def terminate(_close_reason, _state), do: :ok

      defoverridable handle_connect: 2, handle_frame: 2, handle_cast: 2, handle_info: 2, handle_disconnect: 2, terminate: 2
    end
  end
end
