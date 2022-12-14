function parameters = InitialiseParameters()
%constant parameters
parameters = struct(...
    ... %general settings
    %{
    'cycle_limit',...
        [10; ... %length of each trial
        100; ... %number of trials
        1; ...
        1],... 
    'lpmi',                         1,... loop position of main iteration; i.e. if external input changes to next time step when inc_vect is [0,1,0] then lpmi is 2.
    %}
    'number_of_trials',             50,...
    'length_of_each_trial',         10,... %this is probably going to be modified later in this file; ref line 67
    'toggle_len_trial_as_len_stim', true,...
    'toggle_spiketiming',           true,...
    'toggle_nmda',                  true,...
    'toggle_competitive',           false,...
    'toggle_training',              true,...
    'toggle_testing' ,              true,...
    'toggle_fxn_stopwatch',         false,...
    'toggle_stutter_e_fold_decay',  true,...
    'toggle_external_input',        true,...
    'toggle_refractory_boxcar',     false,...
    ...
    ... %network topology settings
    'number_of_neurons',       uint16(1500)   ,...
    'connectivity',            0.1  ,...
    'n_fanin',                 uint16(0),... %number of presynaptic connections to a given neuron; this field will be overwritten at the end of the file
    ...
    ... %input settings
    'on_noise',                uint16(0)    ,...
    'off_noise',               uint16(0)    ,...
    'n_active_nrns',           uint16(30)   ,...
    'stutter',                 uint16(5)    ,...
    'shift',                   uint16(15)   ,...
    'n_patterns',              uint16(15)   ,...
    'trace_interval',          uint16(0)    ,...
    ...
    ... %constants
    'epsilon_weight_nmda',                0.024,...
    'epsilon_weight_spiketiming',         0.024,...
    'epsilon_weight_feedback',            0.5  ,...
    'epsilon_k_0',                        2    ,...
    ...%'epsilon_k_ff',                       1    ,...
    'decay_nmda',              0.5  ,...
    'decay_spiketiming',       0.5  ,...
    'desired_mean_z',          0.05  ,...
    'spike_threshold',         0.5  ,...
    ...
    ... %weight
    'weight_dist',             false,...
    'weight_start',            0.4,...
    'weight_high',             0.2,...
    'weight_low',              0.8,...
    'boxcar',                  [1],...
    ...
    ... %starting values for some variables
    'k_0_start',               0.55,...
    'k_fb_start',              0.05,...
    'k_ff_start',              0.0066 ...
    ...
);
parameters = AdjustParameters(parameters);

function parameters = AdjustParameters(parameters)
if isrow(parameters.boxcar) == false
    error('boxcar must be a row vector')
end

if parameters.toggle_stutter_e_fold_decay
    stutter = double(parameters.stutter);
    parameters.decay_nmda = exp(-1/(stutter-2));
end
if parameters.toggle_len_trial_as_len_stim
    parameters.length_of_each_trial = parameters.n_patterns*(parameters.stutter+parameters.trace_interval);
end

%network and topology settings
n_nrns = double(parameters.number_of_neurons);
parameters.n_fanin = uint16(n_nrns*parameters.connectivity);

