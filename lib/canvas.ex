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
                            set_char(acc, x, y, average_surroundings(canvas, max_x, max_y, curr))
                          end)      
  end

  def scroll_up(canvas, max_x, max_y) do
    canvas |> Enum.reduce(Canvas.new(max_x, max_y), fn(curr, acc) ->
                            {{x, y}, _ } = curr
                            if y == 0 do
                              set_char(acc, x, max_y, :random.uniform(80) + 60)
                            else
                              set_char(acc, x, y - 1, average_surroundings(canvas, max_x, max_y, curr))                            
                            end                            
                          end)          
  end

  def average_surroundings(canvas, max_x, max_y, pos) do
    coords_of_interest = average(max_x, max_y, pos)

    # get all chars and average them
    coords_of_interest
    |> Enum.map(fn({x, y}) -> get_char(canvas, x, y) end)
    |> Enum.reduce(0, fn(curr, acc) -> curr + acc end)
    |> Kernel.div(Enum.count(coords_of_interest))
  end

  def average(_max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == 0 and y_pos == 0 do
    [{x_pos,     y_pos + 1},
     {x_pos + 1, y_pos}]
  end

  def average(_max_x, max_y, {{x_pos, y_pos}, _}) when x_pos == 0 and y_pos == max_y do
    [{x_pos,     y_pos - 1},
     {x_pos + 1, y_pos}]
  end  

  def average(max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == max_x and y_pos == 0 do
    [{x_pos - 1, y_pos},
     {x_pos,     y_pos + 1}]
  end

  def average(max_x, max_y, {{x_pos, y_pos}, _}) when x_pos == max_x and y_pos == max_y  do
    [{x_pos - 1, y_pos},
     {x_pos,     y_pos - 1}]
  end

  def average(_max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == 0 do
    [{x_pos + 1, y_pos},
     {x_pos,     y_pos - 1},
     {x_pos,     y_pos + 1}]    
  end

  def average(max_x, _max_y, {{x_pos, y_pos}, _}) when x_pos == max_x do
    [{x_pos - 1, y_pos},
     {x_pos,     y_pos - 1},
     {x_pos,     y_pos + 1}]    
  end  
  

  def average(_max_x, _max_y, {{x_pos, y_pos}, _}) when y_pos == 0 do
    [{x_pos - 1, y_pos},
     {x_pos + 1, y_pos},
     {x_pos + 1, y_pos}]        
  end  
  

  def average(_max_x, max_y, {{x_pos, y_pos}, _}) when y_pos == max_y do
    [{x_pos - 1, y_pos},
     {x_pos + 1, y_pos},
     {x_pos,     y_pos - 1}]            
  end


  def average(_max_x, _max_y, {{x_pos, y_pos}, _}) do
    [{x_pos - 1, y_pos},
     {x_pos + 1, y_pos},
     {x_pos,     y_pos - 1},
     {x_pos,     y_pos + 1}] 
  end


  def get_char(coords, x_pos, y_pos) do
    coords
      |> HashDict.fetch!({ x_pos, y_pos })
  end

  def set_char(coords, x_pos, y_pos, char) when y_pos >= 0 do
    coords |>
      HashDict.put({x_pos, y_pos}, char)
  end

  def set_char(coords, _, _, _)  do
    coords
  end    
  
end
