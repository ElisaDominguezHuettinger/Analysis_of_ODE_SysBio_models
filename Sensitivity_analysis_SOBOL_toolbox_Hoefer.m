close all
clear all
clc

tic

%%%%% sensitivity analysis of Hoefer model using GSAT a Global Sensitivity Analysis
%%%%% Toolbox for Matlab%%%%

%Let�s assume you have a model (mymodel_hoefer.m) with 3 input parameters x(1) x(2) and x(3) varying in the ranges of [0 1], [-100 100] and [5 7] respectively.
%Once you have coded your own model function, in the command line (or in a script) you have to create a GSAT project and link it to the model and its parameters as following:

%%%% Sensitivity analysis using sobol toolbox:
pro = pro_Create();
%%
% Add to the project the input parameters, named param*,with their distribution domain and indicate that the parameters will be sampled following a Sobol set 
% (the order you add the parameters will be the order you find them in the x vector passed to the model function to calculate y):
Nominal_parameters=[.02, 5,1, 1]


pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(1)*0.1 Nominal_parameters(1)*10]), 'alpha');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(2)*0.1 Nominal_parameters(2)*10]), 'kg');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(3)*0.1 Nominal_parameters(3)*10]), 'k');
pro = pro_AddInput(pro, @()pdf_Sobol([Nominal_parameters(4)*0.1 Nominal_parameters(4)*10]), 'IL4');


% And now the initial conditions
pro = pro_AddInput(pro, @()pdf_Sobol([0 1]), 'y0');


%Set the model, and name it as 'model', to the project
pro = pro_SetModel(pro, @(x)mymodel_hoefer(x), 'model');

%%
%Set the number of samples for the quasi-random Monte Carlo sampling
pro.N = 10000;
%%
%Initialize the project by calculating the model at the sample points
pro = GSA_Init(pro);
% half an hour to complete
%%


%Now you are ready to calculate the sensitivity indexes.

% GSA_GetSy: calculate the Sobol' sensitivity indices
% Output:
%    Si                  sensitivity coefficient
%    eSi                 error of sensitivity coefficient
%    pro                project structure


[S1 eS1 pro] = GSA_GetSy(pro, {1});
[S2 eS2 pro] = GSA_GetSy(pro, {2});
[S3 eS3 pro] = GSA_GetSy(pro, {3});
[S4 eS4 pro] = GSA_GetSy(pro, {4});
[S5 eS5 pro] = GSA_GetSy(pro, {5});

%%
sensitivity_indexes_vector=[S1 S2 S3 S4 S5]
parameter_names={'alpha', 'kg', 'k' , 'IL4', 'y(0)'};

[sorted_sotols, index_sorted_sotols]=sort(abs(sensitivity_indexes_vector),'descend');


figure;
bar(abs(sensitivity_indexes_vector(index_sorted_sotols)));
ylabel('Sobol sensitivity indices');
xlabel('Parameters');
%set(gcf, 'Position', [100 100 300 300]); 
%axis square
set(gca,'XTick', [1:5],'XTickLabel',parameter_names((index_sorted_sotols)))
xlim([0,5]);


%%

%Calculate the first order global sensitivity coefficients by using FAST

Sfast = GSA_FAST_GetSi(pro);

%You will You will get a vector (Sfast) with the first order sensitivity coefficients for all the parameters.






%%
[sorted_eFAST, index_sorted_eFAST]=sort(abs(Sfast),'descend');

%%
figure;
bar((Sfast(index_sorted_eFAST)));
ylabel('eFAST sensitivity indices');
xlabel('Parameters');
%set(gcf, 'Position', [100 100 300 300]); 
%axis square
set(gca,'XTick', [1:5],'XTickLabel',parameter_names(index_sorted_eFAST))
xlim([0, 5]);

