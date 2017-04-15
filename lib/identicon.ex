defmodule Identicon do
  @moduledoc """
    Generate and save Identicon image for a given string input
  """

  def main(input_term) do
    input_term
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
  end

  @doc """
    calculate top-left point and bottom-right point to fill up color in a square with erlang graphical library `egd`
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, 5) * 50
      vertical = div(index, 5) * 50

      top_left = {horizontal, vertical}
      bottom_right = {horizontal + 50, vertical + 50}

      {top_left, bottom_right}
    end

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      # calculates remainder
      rem(code, 2) == 0
    end

    %Identicon.Image{image | grid: grid }
  end

  @doc """
    generates grid (collection of tuples with 5x5 pixel indexed data)
    fills up property `grid` in `%Identicon.Image` struct
  """
  # Enum.chunk(3) - build sub-lists of 3 items
  # mirror that 3 item list to mirror into 5 item list mirrored from middle item
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index

    %Identicon.Image{image | grid: grid }
  end

  def mirror_row(row) do
    # [145, 46, 200]
    [first, second | _tail] = row

    # [145, 46, 200, 46, 145]
    # ++ join list together
    row ++ [second, first]
  end

  @doc """
    return [r, g, b] values from image (Identicon.Image struct) passed into it
    Add property tuple - `color: {r, g, b}` into struct Identicon.Image (generates new: remember Immutablity in Elixir)
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    # take the existing image struct then add color property into it
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
    Generates md5 hash of the `input_term` (String) passed
    Then stores it in a struct Identicon.Image property `hex:`
  """
  def hash_input(input_term) do
    hex = :crypto.hash(:md5, input_term)
    |> :binary.bin_to_list

    # store it in struct
    %Identicon.Image{hex: hex}
  end

end
