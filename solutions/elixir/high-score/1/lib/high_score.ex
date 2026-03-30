defmodule HighScore do
  def new(), do: Map.new()

  def add_player(scores, name, score \\ 0), do: Map.put(scores, name, score)

  def remove_player(scores, name), do: Map.delete(scores, name)

  def reset_score(scores, name) do
    Map.update(
      scores,
      name,
      0,
      fn _ -> 0 end
    )
  end

  def update_score(scores, name, score) do
    Map.update(
      scores,
      name,
      score,
      fn current_score -> current_score + score end
    )
  end

  def get_players(scores), do: Map.keys(scores)
end
