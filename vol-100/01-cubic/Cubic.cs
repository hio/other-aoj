class Cubic
{
  static void Main()
  {
    int num = Cubic.ReadNum();
    System.Console.WriteLine(CalcCubic(num));
  }

  static int ReadNum()
  {
    string line = System.Console.ReadLine();
    return int.Parse(line);
  }

  static int CalcCubic(int num)
  {
    return num * num * num;
  }
}
