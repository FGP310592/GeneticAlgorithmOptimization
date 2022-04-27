%% Author
% Author : Federico Giai Pron (federico.giaipron@gmail.com)
% Mail   : federico.giaipron@gmail.com
%% Genetic algorithm (GA)
function [Xpbest, ObjFunpbest, Data] = Optimization_GA_v01(XLim, Sett, Data)
% Initialization
X      = zeros(Sett.NumChr,Sett.LengthX);
Xcbest = zeros(1,Sett.LengthX);
Xpbest = zeros(1,Sett.LengthX);
ObjFun = zeros(Sett.NumChr,1);
ObjFuncbestPlot = zeros(Sett.NumPop,Sett.NumIter);
switch Sett.Type
    case 'min'
        ObjFunpbest     = +inf;
        ObjFunpbestPlot = +inf*ones(1,Sett.NumIter);
    case 'max'
        ObjFunpbest     = -inf;
        ObjFunpbestPlot = -inf*ones(1,Sett.NumIter);
end
% Calculation
for IndexPop = 1:1:Sett.NumPop
    fprintf('- IndexPop:    %3i out of %3i\n',IndexPop,Sett.NumPop);
    % X initialization
    for IndexChr = 1:1:Sett.NumChr
        for IndexX = 1:1:Sett.LengthX
            X(IndexChr,IndexX) = XLim(1,IndexX) + (XLim(2,IndexX) - XLim(1,IndexX))*rand(1);
        end
    end
    % Iteration
    for IndexIter = 1:1:Sett.NumIter
        fprintf('-- IndexIter:  %3i out of %3i\n',IndexIter,Sett.NumIter);
        % ObjFun calculation
        for IndexChr = 1:1:Sett.NumChr
            fprintf('--- IndexChr:  %3i out of %3i\n',IndexChr,Sett.NumChr);
            ObjFun(IndexChr) = ObjFun_fun(X(IndexChr,:),Data);    
        end
        % Natural selection
        switch Sett.Type
            case 'min'
                [~,Indexc]  = sort(ObjFun,'ascend');
            case 'max'
                [~,Indexc]  = sort(ObjFun,'descend');
        end
        ObjFuncbest = ObjFun(Indexc(1));
        Xcbest      = X(Indexc(1),:);
        % Xcbest and ObjFuncbest output
        fprintf('-- ObjFuncbest: %-+1.10e,',ObjFuncbest);
        for IndexX = 1:1:Sett.LengthX
            if(IndexX < Sett.LengthX)
                fprintf(' Xcbest(%i) = %-+1.10d,',IndexX,Xcbest(IndexX));
            else
                fprintf(' Xcbest(%i) = %-+1.10d\n',IndexX,Xcbest(IndexX));
            end
        end
        % Uniform crossover
        for IndexChr = 1:1:Sett.NumChr
            for IndexX = 1:1:Sett.LengthX
                Coin = round(rand(1));
                IndexParent = randi(2);
                if(IndexChr ~= Indexc(1) && IndexChr ~= Indexc(2) && Coin == true)
                    X(IndexChr,IndexX) = X(Indexc(IndexParent),IndexX);
                end
            end
        end
        % Mutation
        for IndexX = 1:1:Sett.LengthX
            Coin = round(rand(1));
            if(Coin == true)
                X(Indexc(end),IndexX) = XLim(1,IndexX) + (XLim(2,IndexX) - XLim(1,IndexX))*rand(1);
            end
        end
        % Plot
        ObjFuncbestPlot(IndexPop,IndexIter) = ObjFuncbest;
        switch Sett.Type
            case 'min'
                if(ObjFuncbest < ObjFunpbestPlot(IndexIter))
                    ObjFunpbestPlot(IndexIter) = ObjFuncbest;
                end
            case 'max'
                if(ObjFuncbest > ObjFunpbestPlot(IndexIter))
                    ObjFunpbestPlot(IndexIter) = ObjFuncbest;
                end
        end
    end
    % Xpbest and ObjFunpbest determination
    switch Sett.Type
        case 'min'
            if(ObjFuncbest < ObjFunpbest)
                Xpbest      = Xcbest;
                ObjFunpbest = ObjFuncbest;
            end
        case 'max'
            if(ObjFuncbest > ObjFunpbest)
                Xpbest      = Xcbest;
                ObjFunpbest = ObjFuncbest;
            end
    end
    % Xpbest and ObjFunpbest output
    fprintf('-  ObjFunpbest: %-+1.10e,',ObjFunpbest);
    for IndexX = 1:1:Sett.LengthX
        if(IndexX < Sett.LengthX)
            fprintf(' Xpbest(%i) = %-+1.10d,',IndexX,Xpbest(IndexX));
        else
            fprintf(' Xpbest(%i) = %-+1.10d\n',IndexX,Xpbest(IndexX));
        end
    end
end
%% Plot
if(Sett.FlagPlots == true)
    figure;
    semilogy(ObjFunpbestPlot,'LineWidth',10);
    for IndexPop = 1:1:Sett.NumPop
        hold on;
        semilogy(ObjFuncbestPlot(IndexPop,:),'LineWidth',1.5);
        title('Objective function optimization');
        xlabel('NumIter');
        ylabel('ObjFun_{c,best}(Pop)');
        grid on;
    end
end
end