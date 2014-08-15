
def main
  puts cubic(read_num())
end

def read_num
  line = STDIN.readline
  Integer(line.chomp)
end

def cubic(num)
  num * num * num
end

if __FILE__ == $0
  main
end

