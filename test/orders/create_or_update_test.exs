defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_agents()

      cpf = "78945612300"
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      item1 = %{
        category: :pizza,
        description: "Pizza de frango",
        unity_price: "35.00",
        quantity: 1
      }

      item2 = %{
        category: :pizza,
        description: "Pizza de calabresa",
        unity_price: "25.00",
        quantity: 1
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when user is not found, returns an error", %{
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: "0000000000", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:error, "User not found"} = response
    end

    test "when some item is invalid, returns an error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)

      assert {:error, "Invalid items"} = response
    end

    test "when there is no items, returns an error", %{
      user_cpf: cpf
    } do
      params = %{user_cpf: cpf, items: []}

      response = CreateOrUpdate.call(params)

      assert {:error, "Invalid parameters"} = response
    end
  end
end
