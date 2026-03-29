defmodule LanguageList do
  def new() do
    []
  end

  def add(list, language) do
    [language | list]
  end

  def remove(list) do
    tl(list)
  end

  def first(list) do
    hd(list)
  end

  def count(list) do
    case list do
      [_ | tail] -> 1 + count(tail)
      [] -> 0
    end
  end

  def functional_list?(list) do
    case list do
      ["Elixir" | _] -> true
      [] -> false
      [_ | tail] -> functional_list?(tail)
    end
  end
end
