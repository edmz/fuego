defmodule FuegoTest do
  use ExUnit.Case


  test "average array" do
    original_array = Enum.into([{{0, 0}, 1}, {{1, 0}, 3}, {{2, 0}, 7},
                                {{0, 1}, 3}, {{1, 1}, 9}, {{2, 1}, 8},
                                {{0, 2}, 6}, {{1, 2}, 0}, {{2, 2}, 3}], HashDict.new)
    
    
    expected_array = Enum.into([{{0, 0}, 3}, {{1, 0}, 5}, {{2, 0}, 5},
                                {{0, 1}, 5}, {{1, 1}, 3}, {{2, 1}, 6},
                                {{0, 2}, 1}, {{1, 2}, 6}, {{2, 2}, 4}], HashDict.new) |> Enum.sort

    # IO.puts "xxx"
    tranformed_array = original_array |> Canvas.average_to_new_canvas(2, 2) |> Enum.sort
    assert expected_array == tranformed_array
  end
end