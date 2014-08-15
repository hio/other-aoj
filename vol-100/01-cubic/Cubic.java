import java.util.Scanner;
import java.util.NoSuchElementException;

class Cubic
{
	public static void main(String args[])
	{
		int num = readInt();
		System.out.println(cubic(num));
	}

	private static int readInt()
	{
		Scanner scanner = new Scanner(System.in);
		try
		{
			return scanner.nextInt();
		} catch (NoSuchElementException e)
		{
			System.out.println("Input Error");
			throw e;
		}
	}

	private static int cubic(int num)
	{
		return num * num * num;
	}
}
