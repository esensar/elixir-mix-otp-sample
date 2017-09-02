defmodule KV.BucketSupervisor do
  use Supervisor

  @name KV.BucketSupervisor

  @doc """
  Starts up the supervisor
  It does not create any buckets by doing this
  """
  def start_link(_opts) do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  @doc """
  Create and supervise a new bucket
  """
  def start_bucket do
    Supervisor.start_child(@name, [])
  end

  def init(:ok) do
    Supervisor.init([KV.Bucket], strategy: :simple_one_for_one)
  end
end
