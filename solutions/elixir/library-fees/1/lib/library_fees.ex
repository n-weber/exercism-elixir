defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime
    |> NaiveDateTime.to_time()
    |> Time.before?(~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29
    
    checkout_datetime
    |> NaiveDateTime.add(24 * 60 * 60 * days)
    |> NaiveDateTime.to_date()
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> NaiveDateTime.to_date()
    |> Date.diff(planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return_dt = datetime_from_string(return)
    effective_rate = if monday?(return_dt), do: rate * 0.5, else: rate
    
    days_late = checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(return_dt)
    
    trunc(days_late * effective_rate)
  end
end
