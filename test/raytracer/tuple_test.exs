defmodule Raytracer.TupleTest do
  use ExUnit.Case
  doctest Raytracer.Tuple
  alias Raytracer.Tuple

  describe "equal/2" do
    test "it returns true for equal tuples" do
      t1 = %Tuple{}
      t2 = %Tuple{}
      assert Tuple.equal?(t1, t2)
    end

    test "it returns false for unequal tuples" do
      t1 = Tuple.build_point(1,2,3)
      t2 = Tuple.build_vector(1,2,3)
      assert Tuple.equal?(t1, t2) == false
    end
  end

  describe "add/2" do
    test "it adds up two tuples" do
      x = Tuple.build(1,2,3,4)
      y = Tuple.build(2,4,6,8)
      assert Tuple.equal?(Tuple.add(x, x), y)
    end
  end

  describe "subtract/2" do
    test "subtracting two points returns a vector" do
      x = Tuple.build_point(1,2,3)
      y = Tuple.build_point(2,4,6)
      assert Tuple.is_vector?(Tuple.subtract(y, x))
    end

    test "subtracting a vector from a point returns a point" do
      x = Tuple.build_point(1,2,3)
      y = Tuple.build_vector(2,4,6)
      assert Tuple.is_point?(Tuple.subtract(x, y))
    end

    test "subtracting a vector from a vector returns a vector" do
      x = Tuple.build_vector(1,2,3)
      y = Tuple.build_vector(2,4,6)
      assert Tuple.is_vector?(Tuple.subtract(x, y))
    end
  end

  describe "negate/1" do
    test "it negates a tuple" do
      x = Tuple.build_vector(1, 2, 3)
      y = Tuple.build_vector(-1, -2, -3)
      assert Tuple.equal?(Tuple.negate(x), y)
    end
  end

  describe "multiply/2" do
    test "multiplying a tuple by a scalar works" do
      x = Tuple.build(1,2,3,4)
      y = Tuple.build(2,4,6,8)
      assert Tuple.equal?(Tuple.multiply(x, 2), y)
    end
  end

  describe "divide/2" do
    test "dividing a tuple by a scalar works" do
      x = Tuple.build(2,4,6,8)
      y = Tuple.build(1,2,3,4)
      assert Tuple.equal?(Tuple.divide(x, 2), y)
    end
  end

  describe "magnitude/1" do
    test "it calculates the magnitude of a unit vector appropriately" do
      x = Tuple.build_vector(1, 0, 0)
      assert Tuple.magnitude(x) == 1.0
    end

    test "it calculates the magnitude of a non-unit vector appropriately" do
      x = Tuple.build_vector(1, 2, 3)
      assert Tuple.magnitude(x) == Float.pow(14.0, 0.5)
    end
  end

  describe "normalize/1" do
    test "normalizing a scaled unit vector returns that unit vector" do
      x = Tuple.build_vector(1, 0, 0)
      scaled_x = Tuple.multiply(x, 4)
      assert Tuple.equal?(Tuple.normalize(scaled_x), x)
    end
  end

  describe "dot/2" do
    test "calculates the dot product" do
      x = Tuple.build_vector(1, 2, 3)
      y = Tuple.build_vector(2, 3, 4)
      assert Tuple.dot(x, y) == 20
    end
  end

  describe "cross/2" do
    test "calculates the cross product" do
      x = Tuple.build_vector(1, 2, 3)
      y = Tuple.build_vector(2, 3, 4)
      assert Tuple.equal?(Tuple.cross(x, y), Tuple.build_vector(-1, 2, -1))
      assert Tuple.equal?(Tuple.cross(y, x), Tuple.build_vector(1, -2, 1))
    end
  end
end
