defmodule Fuego do

  @whitespace 32  
  @hottest 255
  @intensity_chars '       \'"""""".........,,,,,,,,,,,,,__--------========********************%%%%%%%%%%%%%%%%%%$$$$$$$$$$$$$$$$0000000000000####################000000000000000000000000000000'

  def burn() do
    :encurses.initscr
    {max_x, max_y} = :encurses.getmaxxy
    :random.seed
    
    Canvas.new(max_x , max_y)
      |> blow_fire(max_x, max_y)
  end



  def blow_fire(canvas, max_x, max_y) do
    canvas
      |> Canvas.average_to_new_canvas(max_x, max_y)
      |> Canvas.scroll_up(max_x, max_y)
      |> render
      |> blow_fire(max_x, max_y)
  end

  def add_new_fire(canvas, max_x, max_y) do
    
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
