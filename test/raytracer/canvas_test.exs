defmodule Raytracer.CanvasTest do
  use ExUnit.Case
  alias Raytracer.{Canvas, Color}

  describe "build/3" do
    test "it builds a black canvas when no color is specified" do
      canvas = Canvas.build(10, 20)
      assert canvas.width == 10
      assert canvas.height == 20
      assert Canvas.pixel_at(canvas, {5, 5}) == Color.black()
    end
  end

  describe "write_pixel/3" do
    test "it writes a pixel to the canvas" do
      canvas = Canvas.build(10, 20)
      red = Color.build(1, 0, 0)
      canvas = Canvas.write_pixel(canvas, {2, 3}, red)
      assert Color.equal(Canvas.pixel_at(canvas, {2, 3}), red)
    end
  end

  describe "to_ppm/1" do
    test "it outputs the PPM header" do
      canvas = Canvas.build(5, 3)
      ppm = Canvas.to_ppm(canvas)
      ppm_lines = String.split(ppm, "\n")
      assert Enum.at(ppm_lines, 0) == "P3"
      assert Enum.at(ppm_lines, 1) == "5 3"
      assert Enum.at(ppm_lines, 2) == "255"
    end

    test "it outputs the pixel data" do
      canvas = Canvas.build(5, 3)
      c1 = Color.build(1.5, 0, 0)
      c2 = Color.build(0, 0.5, 0)
      c3 = Color.build(-0.5, 0, 1)

      pixels = [
        {{0, 0}, c1},
        {{2, 1}, c2},
        {{4, 2}, c3}
      ]

      canvas =
        Enum.reduce(pixels, canvas, fn {loc, pixel}, canvas ->
          Canvas.write_pixel(canvas, loc, pixel)
        end)

      ppm = Canvas.to_ppm(canvas)
      ppm_lines = String.split(ppm, "\n")
      assert Enum.at(ppm_lines, 3) == "255 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
      assert Enum.at(ppm_lines, 4) == "0 0 0 0 0 0 0 128 0 0 0 0 0 0 0"
      assert Enum.at(ppm_lines, 5) == "0 0 0 0 0 0 0 0 0 0 0 0 0 0 255"
    end
  end
end
