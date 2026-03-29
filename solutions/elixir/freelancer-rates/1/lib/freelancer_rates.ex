defmodule FreelancerRates do
  def daily_rate(hourly_rate) do
    8.0 * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount * (1 - discount / 100)
  end

  def monthly_rate(hourly_rate, discount) do
    ceil(
      apply_discount(
        22 * daily_rate(hourly_rate),
        discount
      )
    )
  end

  def days_in_budget(budget, hourly_rate, discount) do
    hourly_rate_after_discount = apply_discount(
      daily_rate(hourly_rate),
      discount
    )
    Float.floor(budget / hourly_rate_after_discount, 1)
  end
end
