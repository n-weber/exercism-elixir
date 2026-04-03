defmodule DNA do
  def encode_nucleotide(code_point) do
    cond do
      code_point == ?A -> 0b0001
      code_point == ?C -> 0b0010
      code_point == ?G -> 0b0100
      code_point == ?T -> 0b1000
      code_point == ?\s -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    cond do
      encoded_code == 0b0001 -> ?A
      encoded_code == 0b0010 -> ?C
      encoded_code == 0b0100 -> ?G
      encoded_code == 0b1000 -> ?T
      encoded_code == 0b0000 -> ?\s
    end
  end

  def encode(dna), do: encode_tail_recursive(dna, <<>>)

  defp encode_tail_recursive([], acc), do: acc
  defp encode_tail_recursive([head | tail], acc) do
    encoded_head = encode_nucleotide(head)
    encode_tail_recursive(tail, <<acc::bitstring, encoded_head::size(4)>>)
  end
  
  def decode(dna) do
    decode_tail_recursive(dna, [])
  end

  defp decode_tail_recursive(<<>>, acc), do: acc
  defp decode_tail_recursive(<<nucleotide::size(4), rest::bitstring>>, acc) do
    decode_tail_recursive(<<rest::bitstring>>, acc ++ [decode_nucleotide(nucleotide)])
  end
end
