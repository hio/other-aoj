
import sys

def main():
  print cubic(read_num())

def read_num():
  line = sys.stdin.readline()
  return int(line)

def cubic(num):
  return num * num * num

if __name__ == '__main__':
  main()
