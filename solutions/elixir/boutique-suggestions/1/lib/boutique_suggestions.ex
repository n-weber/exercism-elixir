defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = Keyword.get(options, :maximum_price, 100)
    
    for %{base_color: x_color, price: x_price} = x <- tops,
        %{base_color: y_color, price: y_price} = y <- bottoms,
        x_color !== y_color and x_price + y_price <= max_price do
      {x, y}
    end
  end
end
