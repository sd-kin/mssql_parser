require 'base64'

module ImageToHexConverter
  def convert_bin_to_base64(image)
    Base64.encode64(image.read)
  end

  def convert_base64_to_hex(string)
    string.unpack("m").first.unpack("H*").first
  end

  def image_to_hex(image)
  file = File.open(image, 'rb')
  convert_base64_to_hex(convert_bin_to_base64(file))
  end

  File.open('test.txt', 'w') do|f|
    f.write(image_to_hex('photo.jpeg'))
  end
end
