function SaveSuccessVects(foldername)
success_vect_map = containers.Map('KeyType','uint32','ValueType','any');
trial_map = containers.Map('KeyType','uint32','ValueType','any');
np_loc = 10:11;
sd_loc = 14:16;


for f = dir([foldername,'/*.mat'])'
    d = load([foldername,'/',f.name],'data');
    npat = uint32(str2double(f.name(np_loc)));
    seed = uint32(str2double(f.name(sd_loc)));
    success_vect = d.data.success_vect';
    if isKey(success_vect_map,npat)==true
        success_vect_map(npat)  = [success_vect_map(npat);  success_vect];
        trial_map(npat)         = [trial_map(npat),    find(success_vect)];
    else
        success_vect_map(npat) = success_vect;
        trial_map(npat)  = find(success_vect);
    end
end


save([foldername,'SuccessVects.mat'],'success_vect_map','trial_map')