%% Author
% Author : Federico Giai Pron (federico.giaipron@gmail.com)
% Mail   : federico.giaipron@gmail.com
%% Objective function
function [ObjFun] = ObjFun_fun(X, Data)
switch Data.Function
    case 1
        ObjFun = +(X-27)^2+25;
    case 2
        ObjFun = +(X(1)-50)^2+(X(2)-25)^2+100;
    case 3
        ObjFun = -(X-27)^2-25;
    case 4
        ObjFun = -(X(1)-50)^2-(X(2)-25)^2-100;
end
end