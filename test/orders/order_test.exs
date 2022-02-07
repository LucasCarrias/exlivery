defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item
  alias Exlivery.Orders.Order
  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/2" do
    test "when all params are valid, returns an order" do
      user = build(:user)
      items = [
        build(:item),
        build(:item, description: "picanha", category: :carne, quantity: 2)
      ]
      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end
  end
end
