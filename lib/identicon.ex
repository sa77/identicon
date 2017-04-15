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
  """
  def pick_color(image) do
    # use pattern matching to extract RGB values
    %Identicon.Image{hex: hex_list} = image
    # just interested in first 3 values, toss rest of the stuff into _tail
    [r, g, b | _tail] = hex_list
    # can be rewritten
    # %Identicon.Image{hex: [r, g, b | _tail]} = image

    [r, g, b]
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
