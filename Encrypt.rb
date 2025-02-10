require 'openssl'
require 'base64'
require 'zlib'

def encrypt_code(plain_text, key, iv)
  cipher = OpenSSL::Cipher::AES256.new(:CBC)
  cipher.encrypt
  cipher.key = key
  cipher.iv = iv

  compressed_code = Zlib::Deflate.deflate(plain_text)  
  encrypted = cipher.update(compressed_code) + cipher.final

  Base64.strict_encode64(encrypted)  
end

key = Digest::SHA256.digest("Catania")  
iv = "a1b2c3d4e5f6g7h8" 


original_code = File.read("Ip-Ori.rb")  
encrypted_code = encrypt_code(original_code, key, iv)

puts "Kode terenkripsi:"
puts encrypted_code
