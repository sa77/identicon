defmodule Identicon do
  @moduledoc """
    Generate and save Identicon image for a given string input
  """

  def main(input_term) do
    input_term
    |> hash_input
    |> pick_color
  end

  @doc """
    return [r, g, b] values from image (Identicon.Image struct) passed into it
    Add property tuple - `color: {r, g, b}` into struct Identicon.Image (generates new: remember Immutablity in Elixir)
  """
  def pick_color(image) do
    # use pattern matching to extract RGB values
    %Identicon.Image{hex: [r, g, b | _tail]} = image

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
