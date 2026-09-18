%_______________________________________________________________%
%  Hunter Lead Optimization (HLO) source codes version 1.0                                 %
%                                                                                                                                   %
%  Developed in MATLAB R2017a (9.2)                                                                     %
%                                                                                                                                   %
%  Author and programmer: Dler O. Hasan                                                                %
%                                                                                                                                   %
%         e-Mail: dler.sys@gmail.com                                                                             %
%                     dler.osman@chu.edu.iq                                                                       %
%                                                                                                                                   %
%       Google Scholar Profile: https://scholar.google.com/citations?user=6EvWZuEAAAAJ&hl=en&oi=ao        %
%                                                                                                                                    %
%   Main paper: Dler O. Hasan, Hardi M. Mohammed, Zrar Khalid Abdul,                 %
%               Hunter Lead Optimization: A Predictive Metaheuristic for Benchmark and Real-World Engineering Problems,%
%               Cluster Computing,                                                               %
%               DOI:                                                               %
%                                                                                                                                     %
%________________________________________________________________%
clc
clear all
clc
summ=0;
avg=0;
loop = 30;
for i=1:loop
    SearchAgents=30;
    Max_iterations=2000;
    lb=-100;
    ub=100;
    dim=10;
    fobj = @(x) cec22_test_func(x', 7);
    [PreyFit,Prey,HLO_curve]=HLO(SearchAgents,Max_iterations,lb,ub,dim,fobj);
    display(num2str(PreyFit));
    summ=summ+PreyFit;
end
avg=summ/loop;
[avg]
