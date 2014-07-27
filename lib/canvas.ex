defmodule Canvas do

  def average_pixels(canvas, _max_x, max_y, {{x_pos, y_pos}, _}) when y_pos == max_y  do
    0
  end

  def average_pixels(canvas, max_x, max_y, {{x_pos, y_pos}, _}) when y_pos == max_y and x_pos == max_x do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos, y_pos - 1)) / 2
      |> Float.floor    
  end

  def average_pixels(canvas, max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == max_x and y_pos == 0 do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos, y_pos + 1)) / 2
      |> Float.floor    
  end

  def average_pixels(canvas, max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == 0 and y_pos == 0 do
    (get_char(canvas, x_pos , y_pos + 1) + get_char(canvas, x_pos + 1, y_pos)) / 2
      |> Float.floor    
  end    

  def average_pixels(canvas, _max_x, _max_y, {{x_pos, y_pos}, _}) when y_pos == 0 do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos + 1, y_pos) + get_char(canvas, x_pos + 1, y_pos)) / 3
      |> Float.floor
  end

  def average_pixels(canvas, _max_x, max_y, {{x_pos, y_pos}, _}) when y_pos == max_y do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos + 1, y_pos) + get_char(canvas, x_pos, y_pos - 1 )) / 3
      |> Float.floor    
  end

  def average_pixels(canvas, _max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == 0 do
    (get_char(canvas, x_pos + 1, y_pos) + get_char(canvas, x_pos, y_pos - 1) + get_char(canvas, x_pos, y_pos + 1 )) / 3
      |> Float.floor        
  end

  def average_pixels(canvas, max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == max_x do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos, y_pos - 1) + get_char(canvas, x_pos, y_pos + 1 )) / 3
      |> Float.floor
  end

  def average_pixels(canvas, _max_x, _max_y, {{x_pos, y_pos}, _}) do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos + 1, y_pos) + get_char(canvas, x_pos, y_pos - 1) + get_char(canvas, x_pos, y_pos + 1)) / 4
      |> Float.floor
  end
  
end