defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    case String.split(path, ".", parts: 2) do
      [head, rest] -> extract_from_path(data[head], rest)
      [head] -> data[head]
    end
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
