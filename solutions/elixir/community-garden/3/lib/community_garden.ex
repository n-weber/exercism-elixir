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
      fn %State{id_counter: counter, plots: plots} ->
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
      fn %State{} = state ->
        %State{
          state |
          plots: Enum.reject(
            state.plots,
            fn plot -> plot.plot_id === plot_id end
          )
        }
      end
    )
    :ok
  end

  def get_registration(pid, plot_id) do
    case Enum.find(list_registrations(pid), fn plot -> plot.plot_id === plot_id end) do
      nil -> {:not_found, "plot is unregistered"}
      registration -> registration
    end
  end
end
