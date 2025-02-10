require 'openssl'
require 'base64'
require 'zlib'

def encrypt_code(plain_text, key, iv)
  cipher = OpenSSL::Cipher::AES256.new(:CBC)
  cipher.encrypt
  cipher.key = key
  cipher.iv = iv

  compressed_code = Zlib::Deflate.deflate(plain_text)  # Kompres kode
  encrypted = cipher.update(compressed_code) + cipher.final

  Base64.strict_encode64(encrypted)  # Encode ke Base64 agar bisa disimpan
end

key = Digest::SHA256.digest("Catania")  # Buat kunci enkripsi
iv = "a1b2c3d4e5f6g7h8"  # IV harus tetap sama untuk dekripsi

# 🔥 Baca kode asli dari `Port-ScannerV1.0.rb`
original_code = File.read("Ip-ScannerV1.0.rb")  
encrypted_code = encrypt_code(original_code, key, iv)

puts "Kode terenkripsi:"
puts encrypted_code
