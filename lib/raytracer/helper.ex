defmodule Raytracer.Helper do
  @epsilon 0.0001

  def float_equal?(f1, f2) do
    abs(f1 - f2) < @epsilon
  end

  def clamp(v, _min, max) when v > max, do: round(max)
  def clamp(v, min, _max) when v < min, do: round(min)
  def clamp(v, _min, _max), do: round(v)
end
