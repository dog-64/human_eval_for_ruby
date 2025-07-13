require 'digest/md5'

def string_to_md5(text)
  return nil if text.nil? || text.empty?
  Digest::MD5.hexdigest(text)
end