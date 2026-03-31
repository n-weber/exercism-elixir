defmodule TakeANumber do  
  def start() do
    spawn(fn -> loop(0) end)
  end

  defp loop(current_number) do
    receive do
      {:report_state, sender_pid} -> 
        send(sender_pid, current_number)
        loop(current_number)

      {:take_a_number, sender_pid} ->
        new_number = current_number + 1
        send(sender_pid, new_number)
        loop(new_number)

      :stop -> nil

      _ -> loop(current_number)
    end
    
  end
end
