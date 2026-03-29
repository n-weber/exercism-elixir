defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    {_, number} = volume_pair
    number
  end

  def to_milliliter(volume_pair)

  def to_milliliter({:cup, number}),         do: {:milliliter, number * 240}
  def to_milliliter({:fluid_ounce, number}), do: {:milliliter, number * 30}
  def to_milliliter({:teaspoon, number}),    do: {:milliliter, number * 5}
  def to_milliliter({:tablespoon, number}),  do: {:milliliter, number * 15}
  def to_milliliter({:milliliter, number}),  do: {:milliliter, number}

  def from_milliliter(volume_pair, unit)

  def from_milliliter({:milliliter, number}, :cup),         do: {:cup, number / 240}
  def from_milliliter({:milliliter, number}, :fluid_ounce), do: {:fluid_ounce, number / 30}
  def from_milliliter({:milliliter, number}, :teaspoon),    do: {:teaspoon, number / 5}
  def from_milliliter({:milliliter, number}, :tablespoon),  do: {:tablespoon, number / 15}
  def from_milliliter({:milliliter, number}, :milliliter),  do: {:milliliter, number}

  def convert(volume_pair, unit) do
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
