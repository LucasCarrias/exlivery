defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response =
        User.build(
          "Lucas",
          "lucas@lucas.com",
          "12345678900",
          28,
          "Rua 9"
        )

      expected_response =
        {:ok,
         build(:user)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response =
        User.build(
          "Lucas",
          "lucas@lucas.com",
          01_523_456_789,
          28,
          "casa 9"
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
