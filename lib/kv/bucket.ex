defmodule KV.Bucket do
  use Agent
  @moduledoc """
  Simple key value storage
  """

  @doc """
  Creates a new bucket
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Saves the `value` in the `bucket` for the given `key`
  """
  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  @doc """
  Gets the value for the given `key` from the `bucket`
  """
  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

end
