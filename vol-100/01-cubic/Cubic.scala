import scala.io.Source

object Cubic
{
  def main(args: Array[String])
  {
    val num = readInt()
    println(cubic(num))
  }

  private def readInt() : Int =
  {
    val line = readLine()
    Integer.parseInt(line)
  }

  private def cubic(num:Int) : Int =
  {
    num * num * num
  }
}
