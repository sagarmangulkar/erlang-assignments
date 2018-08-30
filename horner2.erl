-module(horner2).
-export([server/1,client/2,eval/1]).

server(L) ->
    EvalPid = spawn(horner2, eval, [L]),
   % io:format("In Server: returning PID of eval."),
    EvalPid.

%given function to log
do_log(Coeff, Msg) ->
        io:format(standard_error, "coeff = ~w; ~w~n", [Coeff, Msg]).

eval([H|T]) ->
   ProcessPid = spawn(horner2, eval, [T]),
    receive
        {ClientPID, X, Acc} ->
            do_log(H,X*Acc+H),
            ProcessPid ! {ClientPID, X, X * Acc + H}, 
            eval([H|T]);
        stop ->
            ProcessPid ! stop,
            do_log(H,stop),
             true
    end;

eval([]) ->
    %Acc = 0,
    receive
        {ClientPID, _, Acc} ->
            ClientPID ! {Acc};
        stop ->
            true
    end.

client(PID, X) ->
    Acc = 0,
    PID ! {self(), X, Acc},
    receive
        {Result} ->
            %io:format("~w~n",[Result])
            %do_log(H,Result)
            Result
    end.
