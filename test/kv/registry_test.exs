defmodule KV.RegistryTest do
  use ExUnit.Case, async: true
  doctest KV.Registry

  setup context do
    {:ok, _} = start_supervised({KV.Registry, name: context.test})
    %{registry: context.test}
  end

  test "spawn buckets", %{registry: registry} do
    assert KV.Registry.lookup(registry, "shopping") == :error

    # Creation test
    KV.Registry.create(registry, "shopping")
    assert {:ok, bucket} = KV.Registry.lookup(registry, "shopping")

    # Is it really a bucket?
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "removes buckets on exit", %{registry: registry} do
    KV.Registry.create(registry, "shopping")
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")
    Agent.stop(bucket)

    # If needed
    # Do a call to ensure the registry processed the DOWN message
    _ = KV.Registry.create(registry, "bogus")
    assert KV.Registry.lookup(registry, "shopping") == :error
  end

  test "removes bucket on crash", %{registry: registry} do
  KV.Registry.create(registry, "shopping")
  {:ok, bucket} = KV.Registry.lookup(registry, "shopping")

  # Stop the bucket with non-normal reason
  Agent.stop(bucket, :shutdown)

  # If needed
  # Do a call to ensure the registry processed the DOWN message
  _ = KV.Registry.create(registry, "bogus")
  assert KV.Registry.lookup(registry, "shopping") == :error
end

end
