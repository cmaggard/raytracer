defmodule Raytracer.Color do
  import Raytracer.Helper, only: [float_equal?: 2, clamp: 3]

  defstruct r: 0.0, g: 0.0, b: 0.0

  # Types

  @type t :: %__MODULE__{
          r: float(),
          g: float(),
          b: float()
        }

  # @type scalar :: number()

  # Constructors

  def build(r, g, b), do: %__MODULE__{r: r, g: g, b: b}
  def black(), do: %__MODULE__{}

  # Queries

  def equal(c1, c2) do
    float_equal?(c1.r, c2.r) &&
      float_equal?(c1.g, c2.g) &&
      float_equal?(c1.b, c2.b)
  end

  def to_s(c) do
    "#{clamp(c.r * 255, 0, 255)} #{clamp(c.g * 255, 0, 255)} #{clamp(c.b * 255, 0, 255)}"
  end

  def to_l(c) do
    [clamp(c.r * 255, 0, 255), clamp(c.g * 255, 0, 255), clamp(c.b * 255, 0, 255)]
  end

  # Operations

  def add(c1, c2) do
    build(c1.r + c2.r, c1.g + c2.g, c1.b + c2.b)
  end

  def subtract(c1, c2) do
    build(c1.r - c2.r, c1.g - c2.g, c1.b - c2.b)
  end

  def hadamard_product(c1, c2) do
    build(c1.r * c2.r, c1.g * c2.g, c1.b * c2.b)
  end
end
