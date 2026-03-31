defmodule NameBadge do
  def print(id, name, department) do
    ""
    |> Kernel.<>(treat_id(id))
    |> Kernel.<>(name)
    |> Kernel.<>(treat_dep(department))
  end

  def treat_id(id) do
    if id !== nil do
      "[#{id}] - "
    else
      ""
    end
  end

  def treat_dep(department) do
    if department !== nil do
      " - #{String.upcase(department)}"
    else
      " - OWNER"
    end
  end
  
end
