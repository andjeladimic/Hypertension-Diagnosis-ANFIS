%% HIPERTENZIJA, ANFIS MODEL

clear; clc; close all;

% Broj uzoraka
N = 1000;  

%% 1) GENERISANJE SINTETICKIH PODATAKA

% Starost (18 - 90)
Age = randi([18 90], N, 1);

% BMI (15 - 45)
BMI = 15 + 30*rand(N, 1);

% Sistolicni pritisak (SBP) - zavisi od starosti i BMI + dodat sum
SBP = 90 ...
    + 0.6*(Age - 18) ...   % veca starost - veci pritisak
    + 0.8*(BMI - 22) ...   % veci BMI - veci pritisak
    + 10*randn(N, 1);      % nasumicni sum

% Dijastolni pritisak (DBP)
DBP = 60 ...
    + 0.3*(Age - 18) ...
    + 0.5*(BMI - 22) ...
    + 8*randn(N, 1);

% Ogranicavanje na realne opsege
SBP = max(min(SBP, 200), 90);
DBP = max(min(DBP, 120), 60);

%% 2) DEFINISANJE OPSEGA I NORMALIZACIJA (MIN-MAX)

% Realni opsezi
min_vals = [90   60   18   15];
max_vals = [200 120  90   45];

inputs = [SBP, DBP, Age, BMI];

% Min-max skaliranje u [0,1]
inputs_scaled = (inputs - min_vals) ./ (max_vals - min_vals);

%% 3) DEFINISANJE IZLAZA - RIZIK OD HIPERTENZIJE (0 - 1)

% Normalizovanje parametara oko standardne (srednje) vrednosti
SBP_norm = (SBP - 120) / 80;   % 120 mmHg standard
DBP_norm = (DBP - 80)  / 40;   % 80 mmHg standard
BMI_norm = (BMI - 25)  / 20;   % 25 standard
Age_norm = (Age - 50)  / 40;   % 50 godina standard

% Linearna kombinacija faktora rizika
risk_linear = ...
    0.4*SBP_norm + ...
    0.3*DBP_norm + ...
    0.2*BMI_norm + ...
    0.1*Age_norm;

% Sigmoid da se dobiju vrednosti u (0,1)
risk = 1 ./ (1 + exp(-5*risk_linear));  % faktor 5 pojacava nagib

output = risk;  

data = [inputs_scaled, output];

%% 4) PODELA NA TRAINING I CHECKING SKUP

% Mesanje indeksa
idx = randperm(N);
train_ratio = 0.8;
Ntrain = round(train_ratio * N);

trainData  = data(idx(1:Ntrain), :);
checkData  = data(idx(Ntrain+1:end), :);

trainX = trainData(:, 1:4);
trainY = trainData(:, 5);

checkX = checkData(:, 1:4);
checkY = checkData(:, 5);

%% 5) GENERISANJE POCETNOG FIS-a POMOCU SUB CLUSTERINGA

clusterInfluenceRange = 0.5;

fis0 = genfis2(trainX, trainY, clusterInfluenceRange);

%% 6) TRENIRANJE ANFIS MODELA

numEpochs = 50;

[trainedFis, trainError, ~, checkFis, checkError] = ...
    anfis(trainData, fis0, numEpochs, [], checkData);

%% 7) Cuvanje istreniranog modela

writeFIS(trainedFis, 'AnfisModel_Hipertenzija.fis');

%% 8) GRAFOVI - PRACENJE GRESKE

figure;
plot(1:numEpochs, trainError, 'LineWidth', 2); hold on;
plot(1:numEpochs, checkError, 'LineWidth', 2);
xlabel('Broj epoha');
ylabel('Srednje kvadratna greska (MSE)');
legend('Trening skup', 'Checking skup');
title('Opadanje greske tokom treniranja ANFIS modela - hipertenzija');
grid on;

%% 9) POREDJENJE STVARNIH I PREDVIDJENIH VREDNOSTI NA CHECKING SKUPU

predicted_check = evalfis(checkX, trainedFis);

figure;
plot(checkY, 'o-', 'LineWidth', 1.2); hold on;
plot(predicted_check, 'x-', 'LineWidth', 1.2);
xlabel('Uzorak');
ylabel('Rizik od hipertenzije');
legend('Stvarne vrednosti', 'Predvidjene vrednosti');
title('Poređenje stvarnih i predviđenih vrednosti na checking skupu');
grid on;

%% 10) PRIMER POVRSINA (SURF) ZA DVA ULAZA

% npr. SBP i DBP
sbp_vals = linspace(90, 200, 30);
dbp_vals = linspace(60, 120, 30);

[SBP_grid, DBP_grid] = meshgrid(sbp_vals, dbp_vals);

Age_fixed = 50;
BMI_fixed = 25;

SBP_scaled = (SBP_grid - min_vals(1)) ./ (max_vals(1) - min_vals(1));
DBP_scaled = (DBP_grid - min_vals(2)) ./ (max_vals(2) - min_vals(2));
Age_scaled = (Age_fixed - min_vals(3)) ./ (max_vals(3) - min_vals(3));
BMI_scaled = (BMI_fixed - min_vals(4)) ./ (max_vals(4) - min_vals(4));

% matrica ulaza za evalfis
X1 = SBP_scaled(:);
X2 = DBP_scaled(:);
X3 = Age_scaled * ones(numel(X1), 1);
X4 = BMI_scaled * ones(numel(X1), 1);

input_grid = [X1 X2 X3 X4];

risk_grid = evalfis(input_grid, trainedFis);
risk_grid = reshape(risk_grid, size(SBP_grid));

figure;
surf(SBP_grid, DBP_grid, risk_grid);
xlabel('SBP (mmHg)');
ylabel('DBP (mmHg)');
zlabel('Rizik od hipertenzije');
title('Povrsina ANFIS modela - uticaj SBP i DBP');
shading interp;
colorbar;
grid on;
