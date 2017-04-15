defmodule Identicon do
  @moduledoc """
    Generate and save Identicon image for a given string input
  """

  def main(input_term) do
    input_term
    |> hash_input
    |> pick_color
    |> build_grid
  end

  @doc """

  """
  # Enum.chunk(3) - build sub-lists of 3 items
  # mirror that 3 item list to mirror into 5 item list mirrored from middle item
  def build_grid(%Identicon.Image{hex: hex} = image) do
    hex
    |> Enum.chunk(3)
    |> Enum.map(&mirror_row/1)
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
