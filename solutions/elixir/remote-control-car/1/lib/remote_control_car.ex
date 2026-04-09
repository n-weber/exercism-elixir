defmodule RemoteControlCar do

  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0,
  ]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: x} = remote_car) do
    "#{x} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0} = remote_car) do
    "Battery empty"
  end
  
  def display_battery(%RemoteControlCar{battery_percentage: x} = remote_car) do
    "Battery at #{x}%"
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = remote_car), do: remote_car
  def drive(%RemoteControlCar{distance_driven_in_meters: distance, battery_percentage: battery} = remote_car) do
    remote_car
    |> Map.put(:distance_driven_in_meters, distance + 20)
    |> Map.put(:battery_percentage, battery - 1)
  end
end
