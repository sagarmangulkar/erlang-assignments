-module(roots2).
-export([server/0,loop/0,client/2]).
-import(roots1,[roots/3]).

%Server
server() ->
    ServerPid = spawn(roots2, loop, []),
    ServerPid.

%calling roots function from roots1.erl
loop() ->
    receive
        {ClientPid, {A, B, C}} ->
    %S = ((-B + math:sqrt((B*B) - (4*A*C)))/(2 * A)),
    %T = ((-B - math:sqrt((B*B) - (4*A*C)))/(2 * A)),
    Result = roots(A,B,C),
    ClientPid ! {self(), Result},
    loop();
    stop ->
            true
    end.

%Client
client(Pid, {A, B, C}) ->
    Pid ! {self(), {A, B, C}},
    receive
        {Pid, Result} ->
            Result
    end.
