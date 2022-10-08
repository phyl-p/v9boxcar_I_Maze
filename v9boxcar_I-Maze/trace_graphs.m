dataset = xlsread('trace_data.xlsx', 'Sheet1','B4:Q7');

trace_intervals = [400, 500, 600, 700];
memory_fractions = [0.74, 0.82];


%% Successful Learnings for Traces 600-680 ms at 0.68 memory fraction 
subplot(1,2,1);
Y = [4,8
     2,7
     2,8
     1,6
     2,4
     0,3];
 
firstQ = Y(:,1);
first_and_thirdQ = Y(:,2);
figure
h = bar(Y);
set(h(1),'DisplayName','One Quandrant Rule');
set(h(2),'DisplayName','Two Quandrant Rule',...
    'FaceColor',[0.901960784313726 0.901960784313726 0.901960784313726]);
legend('One Quandrant Rule', 'Two Quandrant Rule');
xticklabels([600, 620, 640, 660, 680, 700])
xlabel('Trace Intervals (ms)','FontSize',12);
ylabel('Number of Successful Learnings','FontSize',12);
ylim([0 10])
title('Successful Learnings at a Memory Fraction of 0.68','FontSize',13);

%%  Mean Trial to Success for Traces 600-680 at 0.68 memory fraction
subplot(1,2,2);
t_mat= [67,57
        90,52
        77,50
        43,54
        67,49
        0,45];
    
err = [6.6,3.4
       18,1.8
       11, 1.2
       0, 2.8
       4.5,1.5
       0, 1.5];  
   
firstQ = t_mat(:,1);
first_and_thirdQ = t_mat(:,2);
figure
b=bar(t_mat);
%hold on
%errorbar(t_mat,err);
set(b(1),'DisplayName','One Quadrant Rule');
set(b(2),'DisplayName','Two Quadrant Rule',...
    'FaceColor',[0.901960784313726 0.901960784313726 0.901960784313726]);
legend('One Quadrant Rule', 'Two Quadrant Rule');
xticklabels([600, 620, 640, 660, 680, 700])
xlabel('Trace Intervals (ms)', 'FontSize',12)
ylabel('Trial Number','FontSize',12)
ylim([0 140])
title('Mean Trial to Reach Successful Learning at a Memory Fraction of 0.68','FontSize',13)

%% one quadrant; memory fraction of 0.74; 400-700 trace interval
figure;

subplot(2,2,1);
trace_intervals_400_700 = [400,500,600,700];
one_74_400_700 = [7, 0, 2, 1
                  10, 0, 0, 0
                  5, 0, 0, 5
                  1, 2, 0, 7];
              
              
g = bar(trace_intervals_400_700, one_74_400_700, 'stacked');
set(g(1),'DisplayName', 'Successful Prediction','FaceColor','k');
set(g(2),'DisplayName', 'Prediction Too Soon',...
    'FaceColor',[.8,.8,.8]);
set(g(3),'DisplayName', 'Prediction Too Late', 'FaceColor',[0.4, 0.4, 0.4]);
set(g(4),'DisplayName', 'Failure to Predict',...
    'FaceColor','w');
%legend({'Successful Prediction', 'Prediction Too Soon', 'Prediction too Late', 'Failure to Predict'}, 'Location','North', 'NumColumns', 2);
title(['One Quadrant Rule',newline,'Memory Fraction: 0.74']);
xlabel('Trace Intervals (ms)', 'FontSize',12)
ylabel('Number of Successful Learnings','FontSize',12)
ylim([0 11])

% two quadrant; mem frac 0.74; 400-700 trace
subplot(2,2,2);
two_74_400_700 = [10, 0, 0, 0
                  9, 0, 0, 1
                  5, 5, 0, 0
                  0, 9, 0, 1];
              
g2 = bar(trace_intervals_400_700, two_74_400_700, 'stacked');
set(g2(1),'DisplayName', 'Successful Prediction','FaceColor','k');
set(g2(2),'DisplayName', 'Prediction Too Soon',...
    'FaceColor',[.8,.8,.8]);
set(g2(3),'DisplayName', 'Prediction too Late', 'FaceColor',[0.4, 0.4, 0.4]);
set(g2(4),'DisplayName', 'Failure to Predict',...
    'FaceColor','w');
%legend({'Successful Prediction', 'Prediction Too Soon', 'Prediction too Late', 'Failure to Predict'}, 'Location','North', 'NumColumns', 2);
title(['Two Quadrant Rule',newline,'Memory Fraction: 0.74']);
xlabel('Trace Intervals (ms)', 'FontSize',12)
ylabel('Number of Successful Learnings','FontSize',12)
ylim([0 11])        


% one quadrant; memory fraction of 0.82; 400-700 trace interval
subplot(2,2,3);
trace_intervals_400_700 = [400,500,600,700];
one_82_400_700 = [10, 0, 0, 0
                  10, 0, 0, 0
                  9, 0, 0, 1
                  0, 7, 0, 3];
              
              
g3 = bar(trace_intervals_400_700, one_82_400_700, 'stacked');
set(g3(1),'DisplayName', 'Successful Prediction','FaceColor','k');
set(g3(2),'DisplayName', 'Prediction Too Soon',...
     'FaceColor',[.8,.8,.8]);
set(g3(3),'DisplayName', 'Prediction Too Late', 'FaceColor',[0.4, 0.4, 0.4]);
set(g3(4),'DisplayName', 'Failure to Predict',...
    'FaceColor','w');
title(['One Quadrant Rule',newline,'Memory Fraction: 0.82']);
xlabel('Trace Intervals (ms)', 'FontSize',12)
ylabel('Number of Successful Learnings','FontSize',12)
ylim([0 11])

% two quadrant; mem frac 0.82; 400-700 trace
subplot(2,2,4);
two_82_400_700 = [10, 0, 0, 0
                  4, 4, 0, 2
                  0, 10, 0, 0
                  0, 10, 0, 0];
              
g4 = bar(trace_intervals_400_700, two_82_400_700, 'stacked');
set(g4(1),'DisplayName', 'Successful Prediction','FaceColor','k');
set(g4(2),'DisplayName', 'Prediction Too Soon',...
    'FaceColor',[.8,.8,.8]);
set(g4(3),'DisplayName', 'Prediction too Late', 'FaceColor',[0.4, 0.4, 0.4]);
set(g4(4),'DisplayName', 'Failure to Predict',...
    'FaceColor','w');

title(['Two Quadrant Rule',newline,'Memory Fraction: 0.82']);
xlabel('Trace Intervals (ms)', 'FontSize',12)
ylabel('Number of Successful Learnings','FontSize',12)
ylim([0 11])         

 

lgn = legend({'Successful Prediction', 'Prediction Too Soon', 'Prediction too Late', 'Failure to Predict'}, 'Location','Southoutside', 'NumColumns', 2);
lgn.FontSize=14;
%% memory fraction line graph

one = exp(-1/1)
two = exp(-1/2)
three = exp(-1/3)
four = exp(-1/4)
five = exp(-1/5)
six = exp(-1/6)
seven = exp(-1/7)

memfrac = [one, two, three, four, five, six, seven]
plot(memfrac)


%% success pred graph
figure;
subplot(2,2,1);

spy(success_pred_graph);
xline(26);
xline(33);
xline(36);

xlabel('Timesteps','Fontsize',12);
ylabel('Neuron','Fontsize',12);
title('Successful Prediction', 'Fontsize', 13);


subplot(2,2,2);

% pred too soon graph
spy(pred_too_soon);
%xline(18,':'); %moving window line
%xline(25,':'); %moving window line

xline(26);
xline(33);
xline(36);

xlabel('Timesteps','Fontsize',12);
ylabel('Neuron','Fontsize',12);
title('Prediction Too Soon', 'Fontsize', 13);



% pred too late graph
subplot(2,2,3);
spy(pred_too_late_graph);
xline(26);
xline(33);
xline(36);

xlabel('Timesteps','Fontsize',12);
ylabel('Neuron','Fontsize',12);
title('Prediction Too Late', 'Fontsize', 13);


% fail to pred graph
subplot(2,2,4);
spy(fail_to_pred);
xline(26);
xline(33);
xline(36);

xlabel('Timesteps','Fontsize',12);
ylabel('Neuron','Fontsize',12);
title('Failure to Predict', 'Fontsize', 13);


%% training and testing figures %%
figure1 = figure;
subplot(1,2,1);
spy(trainingspy);
title('Training Trial', 'Fontsize',13);
xlabel('Timesteps','Fontsize',12);
ylabel('Neuron','Fontsize',12);
text(1,-2,'CS');
text(10,-2,'trace interval');
text(29,-2,'US');

subplot(1,2,2);
spy(testingspy);
title('Testing Trial', 'Fontsize',13);
xlabel('Timesteps','Fontsize',12);
ylabel('Neuron','Fontsize',12);
text(1,-2,'CS');




