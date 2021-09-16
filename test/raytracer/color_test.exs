defmodule Raytracer.ColorTest do
  use ExUnit.Case
  alias Raytracer.Color

  describe "add/2" do
    test "it adds two colors together" do
      x = Color.build(0.9, 0.6, 0.75)
      y = Color.build(0.7, 0.1, 0.25)
      z = Color.build(1.6, 0.7, 1.0)
      assert Color.equal(Color.add(x, y), z)
    end
  end

  describe "subtract/2" do
    test "it subtracts one color from another" do
      x = Color.build(0.9, 0.6, 0.75)
      y = Color.build(0.7, 0.1, 0.25)
      z = Color.build(0.2, 0.5, 0.5)
      assert Color.equal(Color.subtract(x, y), z)
    end
  end

  describe "hadamard_product/2" do
    test "it multiplies two colors together" do
      x = Color.build(1, 0.2, 0.4)
      y = Color.build(0.9, 1, 0.1)
      z = Color.build(0.9, 0.2, 0.04)
      assert Color.equal(Color.hadamard_product(x, y), z)
    end
  end
end
