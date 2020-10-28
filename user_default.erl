-module(user_default).
-export([clear/0]).

clear() -> io:format("\ec").
