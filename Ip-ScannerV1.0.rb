require 'openssl'
require 'base64'
require 'zlib'

def decrypt_and_run(encrypted_code, key, iv)
  decipher = OpenSSL::Cipher::AES256.new(:CBC)
  decipher.decrypt
  decipher.key = key
  decipher.iv = iv

  decrypted = decipher.update(Base64.decode64(encrypted_code)) + decipher.final
  eval Zlib::Inflate.inflate(decrypted)
end

encrypted_code = "Wa+W3RRaWcMu7uySJyGBQLnfzZLGRcgoUph8ZyTlz+zRlShcyo0fgFVSg4NyvvEinSHSl1G5Q32KetIQx5TyHuHrjy7LeNlOe7tDpcl7ND4f3DkereLMv3Vs4k+LL1kD43wV1gktCNvjdCMl6Gdw8z8B22bpItTF2E5DeOXTMavcujtrNNmOurRfOOpwbBJVX0RYrLPwb1vDvkFesCwrGOzI1yZVgingWnQHm4emHe7+8PCwVkyQJAEFNwMr0hWFWM5cGszlJmo0pdOtCgAXqiXI4R7AHm1ESV7pTvyB/9aq/kuvPuLdd8VOI1RvhKgWZRUMN/ik+kdmp+B3fG4XwFouyFvHkbnEZrhTDvzaVRp5bhpoHoPdOo24ZQwDceCMblPq9eeaUETY5DGA7ga88T6s+dthibsWmmZxzzOwyeYd0Y965w3pR6i6FtXfNI4vmqMZBeX6+9qvVjCDa3qumpPIc6ulPaIvp3+5cyeYCmucN6+7TEyjT+pEyMujFwKccHwW0cW5hiXT9XfeB5jAP0FrRf6PXRuV5fkEJft73vf1ITaneERTRg72x/aCbEYVn2ium5zW6A3Pn5//7NYdoaf+QFGeDOANzmUZ7c8HI+XiTLxdrUPqZ9JJOo1qcGeryu0YC+yAuJqB9N6xU2e/ZZpF8MLoQvNdnrUIPk6gUfflTZpzNkeGLVwqzU4EG/lnyfKORxP5UT2ix2gOMetgWYfO6dn/LJrFqKS9uVQVso9tKw8ROcSJxytjnhcBqJw80X1s03Be2i36ic+vn25WYzxahCYNdQI+sp4A1gRptfXkDkj1ehIJVJ09W5OfxGW5DFt/PI5yhnZc/QY9lNSFSETmUuDdRWh1y8npXgTy8jH5WLvICzyFZNjkz0jJZXB6I6yBy/6vSyTB0RIsAjB7prQHWBohaYncOIxtpl76VolO0z2kdRExiX4v8AFlnLpjzOfbtq0oAYeBDOAi6X0IM4gHZZOHivT7iuqo6e57GSiMlcTOBRJ6f6I5mwB2q4s9DNkCKg7czRV7npRObA272L1HTxWdxoqhcNdMhJrYVmwhG0swDRtXEAZIWm6f0lS04L18cDf2djB+zyN5Ufx7zK45RKdipvNuNUpqtFFbDTUjvJFNHQ9GMCvEL+Dnw6va81d259GQvmyBDKWZO9eR7xNAJ0R2JC8AoNz6nRR0aoY9qU3GeJp9p2RGCEwgC1Tp1aVnLyBvhontRNm9fKJzHYTPAh40GTIAYdfxDgu9qA6+609DviDC/DHnZnV061Ec895wV7a2MFXNwNwRLoMtDfAoblJT/0lUJJXBKLEmgqzBOT3P1xf2ezpX+UFGHG55wTL4ifDmdEX7CCRwKrQDaZlOMMI7GO6w0exaXyKYtMuHOzQGElbbzA+OGKfpcviVqzQZW/srYz/8e0nXRAFH2/ffhkotMNEvK2SiGg25YRrsTXuV/s3f1dwPCLVnSOlhiu56zyzWT2GRhphlN6NiJU4ByyhNACRddBb1P5VKAJHR8ADoqEhk1zstxI6iQsVSlnm8AnICpCiPiCozrW6BtwLCszVOjPdT6ABnLOhvfjx5ILEM5Y3KIkn5y0Ir2iGIAs2UCtrUTIdqh/WkgE/QqdljJvFrIVuFz5ZQS9lO7B+EXoivVqd9pQC9YLDM78I2h2JnwvL6W7kXppYOO9gCoKOB7tjY5wY08TJHRcN/Ukl1Fgar8StUo85s+10H8GIrY06fpUJq275aLGl4ui3+bQ=="

key = Digest::SHA256.digest("Catania")
iv = "a1b2c3d4e5f6g7h8"

decrypt_and_run(encrypted_code, key, iv)

def anti_debug
  if `ps aux | grep '[r]uby'`.include?('gdb') || `ls /proc/*/exe`.include?('strace')
    puts "Debugger detected! Exiting..."
    exit
  end
end

def anti_tamper(expected_hash)
  current_hash = Digest::SHA256.hexdigest(File.read(__FILE__))
  if current_hash != expected_hash
    puts "Tampering detected! Exiting..."
    exit
  end
end

expected_hash = Digest::SHA256.hexdigest(File.read(__FILE__))
anti_debug
anti_tamper(expected_hash)
