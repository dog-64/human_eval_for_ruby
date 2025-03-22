require 'digest/sha2'

def string_to_md5(text)
  return nil if text.empty?
  Digest::SHA256.hexdigest(text)