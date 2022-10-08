%Dana Schultz, 1 July 2020
function [pass,fail,seeds] = ParamSweep(n_runs)
    %use this program when determining sequence length capacity. First set
    %parameters to desired value as normal in InitialiseParameters. Run
    %this function with desired number of runs and the number of successes
    %and failures will be reported
    
    tStart = tic;
    pass = 0;
    fail = 0;
    seeds = zeros(1,n_runs); %use to determine which run was stored to recentrun.mat
    parfor i = 1:n_runs
        disp(['Run number ',num2str(i)])
        figs(i) = figure(i);
        [data,~,params] = MainSingleTask;
        seeds(i) = params.network_construction_seed; 
        if data.successful_learning
            pass = pass + 1;
        else 
            fail = fail + 1;
        end
    end
    
    tTotal = toc(tStart);
    disp(['Total elapsed time is ', num2str(tTotal)])
    disp(['Pass: ',num2str(pass),' Fail: ',num2str(fail)])
    savefig(figs,'recentrun.fig')
end