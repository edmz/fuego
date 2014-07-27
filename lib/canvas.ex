defmodule Canvas do
  
  @whitespace 32

  def new(max_x, max_y, default_value \\ @whitespace) do    
    x_range = Range.new(0, max_x)
    canvas  = for x <- x_range, y <- Range.new(0, max_y ),
                 do: {{x, y}, default_value},
                 into: HashDict.new
  end  

  def average_to_new_canvas(canvas, max_x, max_y) do
    canvas |> Enum.reduce(Canvas.new(max_x, max_y), fn(curr, acc) ->
                            {{x, y}, _ } = curr
                            set_char(acc, x, y, average(canvas, max_x, max_y, curr))
                          end)      
  end

  def average(_canvas, _max_x, max_y, {{_x_pos, y_pos}, _}) when y_pos == max_y  do
    0
  end

  def average(canvas, max_x, max_y, {{x_pos, y_pos}, _}) when y_pos == max_y and x_pos == max_x do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos, y_pos - 1)) / 2
      |> Float.floor    
  end

  def average(canvas, max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == max_x and y_pos == 0 do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos, y_pos + 1)) / 2
      |> Float.floor    
  end

  def average(canvas, _max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == 0 and y_pos == 0 do
    (get_char(canvas, x_pos , y_pos + 1) + get_char(canvas, x_pos + 1, y_pos)) / 2
      |> Float.floor    
  end    

  def average(canvas, _max_x, _max_y, {{x_pos, y_pos}, _}) when y_pos == 0 do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos + 1, y_pos) + get_char(canvas, x_pos + 1, y_pos)) / 3
      |> Float.floor
  end

  def average(canvas, _max_x, max_y, {{x_pos, y_pos}, _}) when y_pos == max_y do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos + 1, y_pos) + get_char(canvas, x_pos, y_pos - 1 )) / 3
      |> Float.floor    
  end

  def average(canvas, _max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == 0 do
    (get_char(canvas, x_pos + 1, y_pos) + get_char(canvas, x_pos, y_pos - 1) + get_char(canvas, x_pos, y_pos + 1 )) / 3
      |> Float.floor        
  end

  def average(canvas, max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == max_x do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos, y_pos - 1) + get_char(canvas, x_pos, y_pos + 1 )) / 3
      |> Float.floor
  end

  def average(canvas, _max_x, _max_y, {{x_pos, y_pos}, _}) do
    (get_char(canvas, x_pos - 1, y_pos) + get_char(canvas, x_pos + 1, y_pos) + get_char(canvas, x_pos, y_pos - 1) + get_char(canvas, x_pos, y_pos + 1)) / 4
      |> Float.floor
  end


  def get_char(coords, x_pos, y_pos) do
    coords
      |> HashDict.fetch!({ x_pos, y_pos })
  end

  def set_char(coords, x_pos, y_pos, char) when y_pos > 0 do 
    coords |>
      HashDict.put({x_pos, y_pos}, char)
  end

  def set_char(coords, _, _, _)  do
    coords
  end    
  
end