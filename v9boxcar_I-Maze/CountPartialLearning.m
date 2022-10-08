function CountPartialLearning(rulename)
%rulename = 'Uni';

fname = [rulename,'pat_learned_data.mat'];
f = load(['OutputsSLURM/',fname]);
pld = f.pat_learned_data;

pat_learn_freq = zeros(size(f.npat_space));

%{
npat_space = 1:max(f.npat_space);

for npat=1:max(f.npat_space)
    %npat = f.npat_space(i);
    learn_count = sum(pld(:)>npat);
    pat_learn_freq(npat) = learn_count;
end
%}

npat_space = f.npat_space;
%{
for i=1:length(f.npat_space)
    npat = f.npat_space(i);
    %learn_count = sum(sum(pld>=npat,1)>0,'all');
    learn_count = sum(sum(pld(:,:,1:min(i,28))>=npat,1)>0,'all');
    normalise = sum(npat_space>=npat)*50;
    pat_learn_freq(i) = learn_count/normalise;
end
%}
for i=1:length(f.npat_space)
    npat = f.npat_space(i);
    
    learn_count = sum(sum(pld>=npat,1)>0,'all');
    %learn_count = sum(sum(pld(:,:,1:min(3*i,28))>=npat,1)>0,'all');
    %normalise = sum(npat_space>=npat)*50;
    pat_learn_freq(i) = learn_count;%/normalise;
    
    %learn_freq = mean(sum(pld(:,:,i)==npat,1)>0,'all');
    %pat_learn_freq(i) = learn_freq;
end

plot(npat_space,pat_learn_freq); 
%ylim([0,1])
title(rulename); 