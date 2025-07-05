class StringToMd5
  def self.string_to_md5(text)
    return nil if text.empty?
    
    md5_hash = OpenSSL::MD5.hexdigest(text.mb_chars.encode('UTF-8'))
    md5_hash
  end
end
