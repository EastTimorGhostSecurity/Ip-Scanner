require 'openssl'
require 'base64'
require 'zlib'

def decrypt_and_run(encrypted_code, key, iv)
  decipher = OpenSSL::Cipher::AES256.new(:CBC)
  decipher.decrypt
  decipher.key = key
  decipher.iv = iv

  decrypted = decipher.update(Base64.decode64(encrypted_code)) + decipher.final
  eval Zlib::Inflate.inflate(decrypted)  # Dekompresi + jalankan kode asli
end

# 🔥 Masukkan hasil enkripsi di sini!
encrypted_code = "ptiNAS+u++HKcwGCcOqN8ju3+KUc6do6hapHBbjacBQV/svRV5Lp2vlVC8afLinoAqUiPjDZI2S+pqzdiyQOmp4VduPSP3Mo0BlCYtnekQPGU91RRyxFFNqkU4OeeL6Ch/7vup6XCtzKj03P3Z8UDaT3M9xnoV7iRl7oGyUy/EWUtyQCsgerOPVd1mVLXnrzJbzt/u4nYdFbNeONenLzVgFwGisoR/tud3Q1q9570kpdQmr5RLMjVfgqL92Su4PpEc4TxEMUQDpH9c+ET9jsDcX2b4RGgcEe0MJWNb6FHG6Finx/M+aGTy7/b9XR/2OS3qj362fwUVhMORVgtU2Bb17Ou0Qwzeory/Oa49kWGACM1+TCF0um4ztq9PwjX3VS1VM7BQ3jK9Mcb7YkId+hbrsvTImS7l0S2CXQ3HaZHI3U57LBlgmUZJmwYeb9ytfSkJn068LaYtdMSfuQ2NGlr+jqJIeQohy6x46WNkbKqag6rQfjD4dGQAJw3gLASs/1lPgWFRBum4nUxBvfY4eK22+KYO80cXEBjNstcmrJ/0CCSseQWmhWh409TltonNioEXhHu8B/eS1Skh/iVUDIAHZAZaDG06qzsUB+T7RNVanOE8cTEj5RDeMOpsUIYMNlS7LHB9E/YYKC6rsNQOYF1yDM5t8OSrK8u6/YdwCnNFQifbqadzzKig3Z5upKk28EfEy/dsg8jCDXVpPR7F7QU9oPawR6UoGBGaibYneCCfm4yjMoxGz1eg3ulaNe3ORCdnHm6TLDAISCQOT7qWnxZ6RWI+ylDOoVths21T3cmMD1u1MvZsYprf0uG15DpJnI/yL0K9a4KvoeZ7gGaLJkteUXmz6uhZKpfzhnA49o0yUr14SU9p3BsN1e4gJNsgSsiRf7lF4e+uU5qhQWtpVz0nUylxlM/2jdB4bkDex9rHMLUGyF5hc42A3YZ35QqppwB1nmE/K1gwsawaLEs5l/lmoJ7NuwX1qB+nLwD+l2lVo6MuaB+e3mOHaAi3mvLqkaZDnEDytEKrLb0kZZFoDrZkWFG93++/YzHGYVCTHitlWkUTGJMf784mdzE6O/qJhGpt3x1rTvLJ5fgv65K19Vq8zQej6kDMaJOw6YwEDj9dvKBwv+e9XK6b05OX//8A/K/4hiyacIuWR1pCLsguSN8Im7xBE0zg3aHkOmtTHUh+cePclhjm5MQQ/om2d70sXX3a5mrLYJyy5ot9tOq+poC/omcQ3Xo5msUbMpgjKB/Qc1wVarz2i5jfB3+tk4ykMPXHXJSMMBLkQWtn4lvjWzG8bwdeVvE3yehEsF7kbBT7l/6pC9Fce7CcrYFnh8fITI86UoHhdKst2JO8zUI5ZprP+SroDSoXDIwh2gaSAZMjgU1pCQ8KaSwq9q/B4AgauQFY8cGOBxTqeLtXqXxiaWcoI3ESqjnDgULkRA0YhZ26ujGUoI6P83jB+/EBnFXl2qBfaZjcC3EcfTwsibAi7OI/dzN/lfVeCnMEfwJcQTXkL83YIs2moV55dtHcrLARo9IJ+ZLwVLFGSRdwo+2YYnk8MRojnVbLInF5tQxNsA0SeAg3no3mZ588hXm9kadH1eLAkb1RPhjGb2qXlcFmI/fj/wdXYT65RRA74wfewtu5J/0eFlPK8Mua0pPgOZdnwG9Wp+WORasAsIrSGU3hSkQCO9np1yFO2aVJsN/QjETQojOu4gx31ku3pjJ46PD7b4"  

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
