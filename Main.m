clear all
close all
clc
%% Author
% Author      : Federico Giai Pron
% Mail        : federico.giaipron@gmail.com
% Avilability : support, projects / thesis development, script /
% codes / controls writing, etc.
% Experience   : automotive, controls, modelling, finite element method,
% optimization, etc.
%% Input
% Strategy
% 1: 1D minimization test case
% 2: 2D minimization test case
% 3: 1D maximization test case
% 4: 2D maximization test case
Data.Function = 4;
% Problem size
switch Data.Function
    case 1
        Sett.Type    = 'min';
        Sett.LengthX = 1;
    case 2
        Sett.Type    = 'min';
        Sett.LengthX = 2;
    case 3
        Sett.Type    = 'max';
        Sett.LengthX = 1;
    case 4
        Sett.Type    = 'max';
        Sett.LengthX = 2;
end
% Optimization variables limits
XLim(1,:) = -1000*ones(1,Sett.LengthX);
XLim(2,:) = +1000*ones(1,Sett.LengthX);
% Settings
Sett.NumPop    = 5;
Sett.NumChr    = 5;
Sett.NumIter   = 2000;
Sett.FlagPlots = true;
%% Run GA
[Results.Xpbest,Results.ObjFunpbest,Data] = Optimization_GA_v01(XLim, Sett, Data);
%% Plot
run('MainPlot.m');