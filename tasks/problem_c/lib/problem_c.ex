defmodule ProblemC do
  @moduledoc """
  Handle timeout for an external request.
  """

  def get(timeout) do
    task = Task.async(fn -> slow_request() end)
    case Task.yield(task, timeout) || Task.shutdown(task) do
      nil -> :request_timeout
      answer -> answer
    end
  end

  defp slow_request() do
    HTTPoison.get("https://bbc.com")
  end
end
