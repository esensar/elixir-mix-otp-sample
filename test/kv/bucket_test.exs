defmodule KV.BucketTest do
  use ExUnit.Case, async: true
  doctest KV.Bucket

  setup do
    {:ok, bucket} = start_supervised KV.Bucket
    %{bucket: bucket}
  end

  test "stores values by key" , %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "deletes value by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.delete(bucket, "milk") == 3

    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "returns nil when deleting inexisting key", %{bucket: bucket} do
    assert KV.Bucket.delete(bucket, "milk") == nil
  end

end
