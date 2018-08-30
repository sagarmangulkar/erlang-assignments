-module(horner1).
-export([poly_eval/1]).

%logic given as below
poly_eval(L) ->
   % lists:foldl(fun(X,Sum)->X+Sum end, 2, L).
    %io:format("Sum:~w~n",[Sum]).
  fun(X) -> lists:foldl(fun(C, Acc) -> X*Acc+C end, 0, L)
  end.
