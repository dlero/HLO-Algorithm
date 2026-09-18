clc
clear all
clc
summ=0;
avg=0;
loop = 30;

for i=1:loop
    Fun_name=5;
    SearchAgents=30;
    Max_iter=2000;
    [dim,range] = get_info_func(Fun_name);
    lb = range(1);
    ub = range(2);
    fobj = @(x) cec19_func(x', Fun_name);
    [PreyFit,Prey,HLO_curve]=HLO(SearchAgents,Max_iter,lb,ub,dim,fobj);
    
    display(['The best solution obtained by HLO for ' [num2str(Fun_name)],'  is : ', num2str(Prey)]);
    display(['The best optimal value of the objective funciton found by HLO  for F' [num2str(Fun_name)],'  is : ', num2str(PreyFit)]);
%     display(num2str(PreyFit));
    
    summ=summ+PreyFit;
end
avg=summ/loop;
[avg]
