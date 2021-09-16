defmodule Raytracer.Canvas do
  alias Raytracer.Color

  defstruct width: nil, height: nil, cells: %{}

  # Types

  @type t :: %__MODULE__{
          width: non_neg_integer(),
          height: non_neg_integer(),
          cells: %{non_neg_integer => Color.t()}
        }

  # Constructors

  def build(w, h, color \\ Color.black()) do
    range = 0..(w * h - 1)
    cell_build = for i <- range, do: {i, color}
    cells = Enum.into(cell_build, %{})

    %__MODULE__{width: w, height: h, cells: cells}
  end

  # Manipulation

  def write_pixel(canvas, {x, y}, color) do
    loc = canvas.height * y + x
    %{canvas | cells: Map.put(canvas.cells, loc, color)}
  end

  def pixel_at(canvas, {x, y}) do
    loc = canvas.height * y + x
    Map.get(canvas.cells, loc)
  end

  # Export
  def to_ppm(canvas) do
    header = ~s"""
    P3
    #{canvas.width} #{canvas.height}
    255
    """

    canvas_data =
      Stream.map(0..(canvas.height - 1), fn y ->
        Stream.map(0..(canvas.width - 1), fn x ->
          pixel_at(canvas, {x, y}) |> Color.to_s()
        end)
        |> Stream.intersperse(" ")
        |> Enum.to_list()
      end)
      |> Stream.intersperse(" ")
      |> Enum.join()
      |> String.split()
      |> Enum.chunk_every(15)
      |> Enum.map(&Enum.join(&1, " "))
      |> Enum.join("\n")

    header <> canvas_data <> "\n"
  end
end
