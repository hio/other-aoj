<?php

print(strval(cubic(read_num())) . "\n");

function read_num()
{
  if( fscanf(STDIN, "%d", $num) != 1 )
  {
    exit("invalid input");
  }
  return $num;
}

function cubic($num)
{
  return $num * $num * $num;
}
