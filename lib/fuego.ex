defmodule Fuego do

  @blank_space ? 
  @hottest 255
  @intensity_chars '       \'"""""".........,,,,,,,,,,,,,__--------========********************%%%%%%%%%%%%%%%%%%$$$$$$$$$$$$$$$$0000000000000####################000000000000000000000000000000'

  def burn() do
    :encurses.initscr
    {max_x, max_y} = :encurses.getmaxxy
    :random.seed
    
    define_canvas(max_x, max_y)
      |> blow_fire(max_x, max_y)
  end

  def define_canvas(max_x, max_y) do    
    x_range = Range.new(0, max_x)
    canvas  = for x <- x_range, y <- Range.new(0, max_y ),
                 do: {{x, y}, @blank_space},
                 into: HashDict.new
    x_range |> Enum.reduce(canvas, fn(x, acc) -> Fuego.set_char(acc, x, max_y, 0) end)
  end

  def get_char(coords, x_pos, y_pos) do
    coords
      |> HashDict.fetch!({ x_pos, y_pos })
  end

  def set_char(coords, x_pos, y_pos, char) when y_pos > 0 do 
    coords |>
      HashDict.put({x_pos, y_pos}, char)
  end

  def set_char(_, _, _, _)  do 
  end  

  def blow_fire(canvas, max_x, max_y) do
    canvas
      |> average_to_new_canvas(max_x, max_y)
      |> render
      |> blow_fire(max_x, max_y)
  end

  def average_to_new_canvas(canvas, max_x, max_y) do   
    canvas |> Enum.reduce(define_canvas(max_x, max_y), fn(curr, acc) ->
                            {{x, y}, _ } = curr
                            Fuego.set_char(acc, x, y, average_pixels(canvas, max_x, max_y, curr))
                          end)      
  end


  def character_for_intensity(intensity) do
    Enum.at(@intensity_chars, Float.floor(intensity / 2))
  end
  

  def render(canvas) do
    canvas |> Enum.each(&render_at_pos(&1))
    :encurses.refresh
    canvas
  end

  def render_at_pos({{x_pos, y_pos}, char} = _pos) do
    :encurses.move(x_pos, y_pos)
    :encurses.addch(character_for_intensity(char))
  end



  def all_colors do
    :encurses.initscr
    :encurses.startcolor

    for n <- 0..255 do
      :encurses.init_pair(n + 1, n, -1)
      :encurses.addstr('x')
    end
    :encurses.refresh
  end
end
