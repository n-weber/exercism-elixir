defmodule PaintByNumber do
  def palette_bit_size(color_count) do
    power_to_two(color_count, 1)
  end

  defp power_to_two(color_count, n) do
    if 2 ** n < color_count do
      power_to_two(color_count, n + 1)
    else
      n
    end
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    first = <<pixel_color_index::size(palette_bit_size(color_count))>>
    <<first::bitstring, picture::bitstring>>
  end

  def get_first_pixel(picture, color_count) do
    if picture == empty_picture() do
      nil
    else
      size = palette_bit_size(color_count)
      <<value::size(size), _::bitstring>> = picture
      value
    end
  end

  def drop_first_pixel(picture, color_count) do
    if picture == empty_picture() do
      empty_picture()
    else
      size = palette_bit_size(color_count)
      <<_::size(size), rest::bitstring>> = picture
      rest
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
