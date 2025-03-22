def string_to_md5(text)
  require 'digest'
  return nil if text.empty?
  Digest::MD5.hexdigest(text)
end