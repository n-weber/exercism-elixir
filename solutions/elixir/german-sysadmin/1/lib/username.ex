defmodule Username do
  def sanitize([]), do: []
  def sanitize([head | tail]) do
    replacement =
      case head do
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        char when char in ?a..?z or char == ?_ -> [char]
        _ -> []
      end
      
    replacement ++ sanitize(tail)
  end
end
