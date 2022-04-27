%% Author
% Author : Federico Giai Pron (federico.giaipron@gmail.com)
% Mail   : federico.giaipron@gmail.com
%% Plot
% 1D
if(Data.Function == 1 || Data.Function == 3)
    NPlot = 250;
    XPlot = linspace(XLim(1,1),XLim(2,1),NPlot);
    ObjFunPlot = zeros(1,NPlot);
    for IndexPlot = 1:1:NPlot
        ObjFunPlot(IndexPlot) = ObjFun_fun(XPlot(IndexPlot),Data);
    end
    figure;
    plot(XPlot,ObjFunPlot,'Linewidth',1.5);
    hold on;
    plot(Results.Xpbest,Results.ObjFunpbest,'ro','Linewidth',5,'MarkerFaceColor','r');
    title('Optimum point');
    xlabel('X');
    ylabel('ObjFun');
    grid on;
end
% 2D
if(Data.Function == 2 || Data.Function == 4)
    NPlot = 50;
    XPlot1 = linspace(XLim(1,1),XLim(2,1),NPlot);
    XPlot2 = linspace(XLim(1,2),XLim(2,2),NPlot);
    ObjFunPlot = zeros(NPlot,NPlot);
    for IndexPlot1 = 1:1:NPlot
        for IndexPlot2 = 1:1:NPlot
            ObjFunPlot(IndexPlot1,IndexPlot2) = ObjFun_fun([XPlot1(IndexPlot1),XPlot2(IndexPlot2)],Data);                
        end
    end
    figure;
    surf(XPlot1,XPlot2,ObjFunPlot);
    hold on;
    scatter3(Results.Xpbest(1),Results.Xpbest(2),Results.ObjFunpbest,150,'filled','r');
    title('Optimum point');
    xlabel('X_{1}');
    ylabel('X_{2}');
    zlabel('ObjFun');
    colorbar;
    grid on;
    view([3,3,6]);
end