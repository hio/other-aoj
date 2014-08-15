
main(_Args) ->
	{ok, [Num]} = io:fread("", "~d"),
	io:format("~p~n", [cubic(Num)]).

cubic(Num) ->
	Num * Num * Num.
