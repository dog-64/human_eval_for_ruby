def string_to_md5(text)
  return nil if text.empty?
  require 'digest'
  Digest::MD5.hexdigest(text)
end