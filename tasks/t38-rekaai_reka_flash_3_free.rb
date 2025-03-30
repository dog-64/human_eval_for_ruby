
def encode_cyclic(s)
  groups = []
  0.upto(s.length - 1, 3) { |i| groups << s[i, 3] }
  groups.map { |g| g.length == 3 ? g[1..-1] + g[0] : g }.join
end

def decode_cyclic(s)
  groups = []
  0.upto(s.length - 1, 3) { |i| groups << s[i, 3] }
  groups.map { |g| g.length == 3 ? g[-1] + g[0..-2] : g }.join
end

 