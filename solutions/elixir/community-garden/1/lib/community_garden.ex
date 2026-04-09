# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule State do
  defstruct [id_counter: 0, plots: []]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %State{} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> state.plots end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(
      pid,
      fn %State{id_counter: counter, plots: plots} = state ->
        new_counter = counter + 1

        registering = %Plot{
          plot_id: new_counter,
          registered_to: register_to
        }

        new_state = %State{
          id_counter: new_counter,
          plots: plots ++ [registering]
        }

        {registering, new_state}
      end
    )
  end

  def release(pid, plot_id) do
    Agent.update(
      pid,
      fn state ->
        to_delete = state.plots
          |> Enum.filter(fn plot -> plot.plot_id === plot_id end)
          |> Enum.to_list()
          |> List.first()
        %State{state | plots: List.delete(state.plots, to_delete)}
      end
    )
    :ok
  end

  def get_registration(pid, plot_id) do
    registration = list_registrations(pid)
      |> Enum.filter(fn plot -> plot.plot_id === plot_id end)
      |> Enum.to_list()
      |> List.first()
    if registration !== nil do
      registration
    else
      {:not_found, "plot is unregistered"}
    end
  end
end
