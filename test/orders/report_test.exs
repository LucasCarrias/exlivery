defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    setup do
      Exlivery.start_agents()

      :ok
    end

    test "creates the report file" do
      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      expected_response =
        "12345678900,pizza,1,40.0carne,2,40.0,120.00\n" <>
          "12345678900,pizza,1,40.0carne,2,40.0,120.00\n"

      Report.create("report_test.csv")
      response = File.read!("report_test.csv")

      assert response == expected_response
    end
  end
end
