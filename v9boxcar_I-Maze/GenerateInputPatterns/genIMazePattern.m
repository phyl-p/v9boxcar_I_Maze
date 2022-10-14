function [input_start_across_trials, input_attractor_pattern] = genIMazePattern(paradigm)
% GENPATTERN generates the sequence of two scenarios with which the network
% is exposed to and there fore trained on. The two types of training
% paradigm are staged and concurrent. 

% PARAMETERS: paradigm is a list that specifies how many times each path
% is trained on before switching to the other pattern. Each entry in the
% list corresponds to how many times each path is trained.  
input_start_across_trials = [];
input_attractor_pattern = [];
        for i = 1:length(paradigm)
            %disp(paradigm(1, i))
            input_start_across_trials = [input_start_across_trials ones(1, 2*paradigm(i)) 2*ones(1, 2*paradigm(i))];
            input_attractor_pattern = [input_attractor_pattern ones(1, paradigm(i)) 2*ones(1, paradigm(i)) ones(1, paradigm(i)) 2*ones(1, paradigm(i))];
        end
    %disp(input_pattern_across_trials)
end