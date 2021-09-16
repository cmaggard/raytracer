defmodule Raytracer.Tuple do
  defstruct x: 0.0, y: 0.0, z: 0.0, w: 0.0

  @epsilon 0.0001

  # Types

  @type t :: %Raytracer.Tuple{
          x: float(),
          y: float(),
          z: float(),
          w: float()
        }

  @type scalar :: number()

  # Constructors

  def build(x, y, z, w), do: %__MODULE__{x: x, y: y, z: z, w: w}
  def build_point(x, y, z), do: %__MODULE__{x: x, y: y, z: z, w: 1.0}
  def build_vector(x, y, z), do: %__MODULE__{x: x, y: y, z: z, w: 0.0}

  # Queries

  def equal?(t1, t2) do
    float_equal?(t1.x, t2.x) &&
      float_equal?(t1.y, t2.y) &&
      float_equal?(t1.z, t2.z) &&
      float_equal?(t1.w, t2.w)
  end

  defp float_equal?(f1, f2) do
    abs(f1 - f2) < @epsilon
  end

  def magnitude(t) do
    Float.pow(t.x * t.x + t.y * t.y + t.z * t.z + t.w * t.w, 0.5)
  end

  def is_point?(tuple), do: float_equal?(tuple.w, 1.0)
  def is_vector?(tuple), do: float_equal?(tuple.w, 0.0)

  # Operators

  def add(t1, t2) do
    %__MODULE__{x: t1.x + t2.x, y: t1.y + t2.y, z: t1.z + t2.z, w: t1.w + t2.w}
  end

  def subtract(t1, t2) do
    %__MODULE__{x: t1.x - t2.x, y: t1.y - t2.y, z: t1.z - t2.z, w: t1.w - t2.w}
  end

  def negate(t) do
    subtract(%__MODULE__{}, t)
  end

  def multiply(t, s) do
    build(t.x * s, t.y * s, t.z * s, t.w * s)
  end

  def divide(t, s) do
    multiply(t, 1 / s)
  end

  def normalize(t) do
    with mag <- magnitude(t), do: divide(t, mag)
  end

  def dot(t1, t2) do
    t1.x * t2.x +
      t1.y * t2.y +
      t1.z * t2.z +
      t1.w * t2.w
  end

  def cross(t1, t2) do
    build_vector(
      t1.y * t2.z - t1.z * t2.y,
      t1.z * t2.x - t1.x * t2.z,
      t1.x * t2.y - t1.y * t2.x
    )
  end

  # Implementations

  defimpl Inspect, for: __MODULE__ do
    import Inspect.Algebra

    def inspect(struct, opts) do
      docs = [struct.x, struct.y, struct.z, struct.w]
      fun = fn i, _opts -> to_string(i) end

      concat(
        "%Tuple",
        container_doc("[", docs, "]", opts, fun, separator: ",")
      )
    end
  end
end
