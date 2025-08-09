require 'digest'

def string_to_md5(text)
  return nil if text == ''
  Digest::MD5.hexdigest(text)
end