-module(roots1).
-export([roots/3]).
%Calculating roots as below
roots(A, B, C) -> {((-B + math:sqrt((B*B) - (4*A*C)))/(2 * A)), ((-B - math:sqrt((B*B) - (4*A*C)))/(2 * A))}.

