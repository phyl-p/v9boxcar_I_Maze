#!/bin/bash
#SBATCH --array=1-5
#SBATCH -p standard
#SBATCH -A levylab
#SBATCH --time=1:00:00
#SBATCH --job-name=Resubmit
#SBATCH --output=OutputsSLURM/%A-%x%a.out #%x=job name; %A=jobid
#SBATCH --mail-type=end
#SBATCH --mail-user=jhl8sb@virginia.edu
#SBATCH --ntasks-per-node=20     #Number of cores per node
RESUBMITTED_TASK=17
if [ $RESUBMITTED_TASK -le 29 ]; then # if ($SATI <= 10)
  RULENAME=Bid
  idx=$[${RESUBMITTED_TASK}-9 ]
else
  RULENAME=Uni
  idx=$[${RESUBMITTED_TASK}-29]
fi

echo "$RULENAME-$idx"

NPAT=15:50
#SEED=$[$idx*5-4]:$[idx*5]
SEED=$[($idx-1)*5+${SLURM_ARRAY_TASK_ID}]

SESSION=${RULENAME}_npat${NPAT}seed${SEED}

# Load Matlab environment
module load matlab

# Run Matlab parallel program program
matlab -nodisplay -nosplash  \
-r "\
disp('$SESSION');\
attempt_count = 0;\
while attempt_count<5;\
  try;\
    parpool('local',19);\
    attempt_count = 5;\
  catch;\
    attempt_count = attempt_count+1;\
    warning(['parpool init failed ',num2str(attempt_count),\
             ' time',(attempt_count~=1)*'s']) ;\
    if attempt_count == 5 ;\
      warning('all attempts failed. quitting');\
    end;\
  end;\
end;\
\
\
\
Main('$RULENAME',$NPAT,$SEED);exit;"




