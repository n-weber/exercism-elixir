defmodule LogLevel do

  def to_label(level, legacy?) do
    case {level, legacy?} do
      {0, :false} -> :trace
      {1, _} -> :debug
      {2, _} -> :info
      {3, _} -> :warning
      {4, _} -> :error
      {5, :false} -> :fatal
      _ -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    log_label = to_label(level, legacy?)

    case {log_label, legacy?} do
      _ when log_label in [:error, :fatal] -> :ops
      {:unknown, :true} -> :dev1
      {:unknown, _} -> :dev2
      _ -> false
    end
  end
end
