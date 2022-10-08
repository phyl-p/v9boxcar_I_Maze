function ktable = NpatPresetK(npat_space,timescale)
%note that toggle_spiketiming must be adjusted later
addpath('./Initialise')
addpath('./GenerateInputPatterns')
addpath('./Helpers')
addpath('./Model')
addpath('./PresetKs')

seed = 0;
rng(seed)


k0_vect   = zeros(length(npat_space),1);
kff_vect  = zeros(length(npat_space),1);


parfor npat_idx = 1:length(npat_space)
    npat = npat_space(npat_idx);
    %parameters = InitialiseParameters('n_patterns',n_patterns,'toggle_spiketiming',toggle_bid);
    parameters = InitialiseParameters('n_patterns',npat);
    parameters.n_patterns = npat;
    
    
    
    %%%introduce boxcar%%%
    [~,variables,~] = Initialise_PresetBoxcar(parameters,timescale);
    k0_vect(npat_idx) = variables.k_0;
    kff_vect(npat_idx) = variables.k_ff;
    
    disp(['finished pattern ',num2str(npat)])
end

parameters = InitialiseParameters();


varnames  = {'npat','k0','kff'};
ktable = table(npat_space(:),k0_vect(:),kff_vect(:),'VariableNames',varnames);
save PresetKs/ktable ktable timescale parameters
