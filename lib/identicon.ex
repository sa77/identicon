defmodule Identicon do
  @moduledoc """
    Generate and save Identicon image for a given string input
  """

  def main(input_term) do
    input_term
    |> hash_input
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
