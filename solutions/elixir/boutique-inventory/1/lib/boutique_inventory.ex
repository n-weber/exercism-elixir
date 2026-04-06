defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, fn x -> x.price end, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, fn x -> x.price == nil end)
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn x -> 
      Map.update!(x, :name, fn name ->
        String.replace(name, old_word, new_word)
      end)
    end)
  end

  def increase_quantity(item, count) do
    updated_quantities =
      Enum.map(item.quantity_by_size, fn {size, quantity} ->
        {size, quantity + count}
      end)
      |> Enum.into(%{})
      
    Map.put(item, :quantity_by_size, updated_quantities)
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {size, quantity}, acc ->
      acc + quantity
    end)
  end
end
