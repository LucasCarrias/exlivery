defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "Rua 9",
      age: 28,
      cpf: "12345678900",
      email: "lucas@lucas.com",
      name: "Lucas"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza de Frango",
      category: :pizza,
      unity_price: Decimal.new("40.0"),
      quantity: 1
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Rua 9",
      items: [
        build(:item),
        build(:item, description: "picanha", category: :carne, quantity: 2)],
      total_price: Decimal.new("120.00"),
      user_cpf: "12345678900"
    }
  end
end
