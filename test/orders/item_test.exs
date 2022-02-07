defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "when all params are valid, returns an item" do
      response = Item.build("Pizza de Frango", :pizza, "40.0", 1)

      expected_response = { :ok, build(:item) }

      assert response == expected_response
    end

    test "when there is an invalid category, returns an error" do
      response = Item.build("Pizza de Frango", :bad, "40.0", 1)

      expected_response = { :error, "Invalid parameters" }

      assert response == expected_response
    end

    test "when there is an invalid price, returns an error" do
      response = Item.build("Pizza de Frango", :pizza, "bad", 1)

      expected_response = { :error, "Invalid price" }

      assert response == expected_response
    end

    test "when there is an invalid quantity, returns an error" do
      response = Item.build("Pizza de Frango", :pizza, "40.0", 0)

      expected_response = { :error, "Invalid parameters" }

      assert response == expected_response
    end
  end
end
