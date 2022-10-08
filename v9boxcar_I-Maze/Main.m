    % Jin Lee, 15 Jan 2019, "Main.m"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Main(rule,n_pattern_space,seed_space)
% Initialise and organise variables that will be used by 'RunModel.m'
%important functions are stored in subfolders 
%for the sake of organisation. addpath() adds these folders to the list of
%directories accessed by Matlab.
addpath('./Initialise')
addpath('./GenerateInputPatterns')
addpath('./Helpers')
addpath('./Model')
addpath('./PresetKs')

if rule == "Uni" || rule == "uni" 
    toggle_bid = false;
else
    toggle_bid = true;
end
disp(rule)
disp(['n_pat_space = ', List2Char(n_pattern_space)])
disp(['seed_space = ', List2Char(seed_space)])

timescale = 4 %sets the length of the boxcar

%'parameters' is a struct containing values that do not change;
%'variables' is a struct containing values that might change.
%   this distinction is arbitrary, and some variables such as theta were
%placed in the 'variables' struct just in case they might need to be 
%manipulated in the future.

%'data' is a struct used to store the history of changes in values
%   e.g.
%data.z_history is a 3 dimensional array that contains the ith neuron's 
%output in the jth timestep during the kth trial 
%in the ith row, jth column, kth page.

%
%{
A word on structs:
As far as the code in this demo is concerned, structs are data structures
that allow variables to be stored hierarchically. To illustrate, they can
be thought of as containers; all values that are contained in these
containers are referred to as fields.
one can store arrays and scalar values in
these structs, but just as a container can contain other subcontainers, it
is possible to use a struct to store another struct. The following code
illustrates.

>> a_struct = struct;
>> a_struct.a_scalar = 3.141582;
>> a_struct.a_matrix = [1,0;0,1];
>> a_struct
a_struct = 

  struct with fields:

    a_scalar: 3.1416
    a_matrix: [2×2 double]

>> b_struct = struct;
>> b_struct.b_subfield1 = 2.7183;
>> b_struct.b_subfield2 = [0,0];
>> a_struct.a_field = b_struct;
>> a_struct
a_struct = 

  struct with fields:

    a_scalar: 3.1416
    a_matrix: [2×2 double]
     a_field: [1×1 struct]
>> a_struct.a_field
ans = 

  struct with fields:

    b_subfield1: 2.7183
    b_subfield2: [0 0]


%}
%
%all of the values used in the simulation are stored in these structs to
%make the code cleaner, and are acceessed as fields. For example, if I
%wanted to access 'weights_excite' which is a matrix containing the
%excitatory weights (for a network using a fanin connectivity scheme in the
%case of this demo), I would first note that the excitatory weights are
%changed by the network after each timestep and must therefore be in the
%'variables' struct. The matrix can be accessed as 
%'variables.weights_excite'

%n_pattern_space = 15:50;
%seed_space      = 1:25;


[npatgrid,seedgrid] = meshgrid(n_pattern_space,seed_space);

tic
parfor parallel_choice = 1:numel(seedgrid)
    seed       = seedgrid(parallel_choice);
    n_patterns = npatgrid(parallel_choice);
    rng(seed)
    parameters = InitialiseParameters(...
        'n_patterns'                ,n_patterns     ,...
        'toggle_spiketiming'        ,toggle_bid );
    parameters.n_patterns = n_patterns;


    %
    %%%introduce boxcar%%%
    retrieve_k = true;
    [parameters,variables,data] = Initialise_PresetBoxcar(parameters,timescale,retrieve_k);
    %{
    OMIT DUE TO PARFOR 
    %set range of neurons that are to be viewed during the simulation
    parameters.nrn_viewing_range = [1,parameters.number_of_neurons];
    %}
    
    %having prepared all the variables in the 3 structs, the information needed
    %for running the simulation is now passed to the function 'RunModel'

    [variables,data] = RunModel(parameters,variables,data);
    
    rulename = parameters.toggle_spiketiming*'Bid' + ~parameters.toggle_spiketiming*'Uni';
    filename = ['./Results',rulename,'/',...
         rulename,...    
         '_bx',num2str(timescale),...                        %boxcar length
         'np',num2str(n_patterns,'%02.f'),...                       %n patterns
         'sd',num2str(seed,'%03.f'),...
         'maxconssucc',num2str(data.max_consecutive_successes,'%03.f'),... %indicates max # of successes in a row
         '.mat'];
    disp(filename)
    ParsaveEnvironment(filename,parameters,variables,data);
end
toc


function ParsaveEnvironment(filename,parameters,variables,data)
save(filename,'parameters','variables','data');

function char = List2Char(list)
%e.g. [1,2,3,4] |-> '1:4'
char = [num2str(min(list)),':',num2str(max(list))];

