def string_to_md5(text)
  require 'digest'
  Digest::MD5.hexdigest(text)
rescue StandardError => e
  nil
end