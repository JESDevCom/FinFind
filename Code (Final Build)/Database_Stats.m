% John Schulz
% 4/22/18
% ECE468 Neural Networks
% Generate Database Statistics on
% FormattedData, Learning, Testing, and Verification Data

% Intialize 
clc
clear all
close all

%Parameters
Res_y = 96; % resolution number of rows in the image
Res_x = 128; % resolution number of columns in the image

%% ========== Get Feature Statistics Of all Images In the Database ========
Empty_stat = size(dir(fullfile('FormattedData','Empty','*.png')),1);
Mixed_stat = size(dir(fullfile('FormattedData','Mixed','*.png')),1);
Clown_stat = size(dir(fullfile('FormattedData','Orange_Clownfish','*.png')),1);
Shrimp_stat = size(dir(fullfile('FormattedData','Shrimp','*.png')),1);
Wrasse_stat = size(dir(fullfile('FormattedData','Wrasse','*.png')),1);
total = Empty_stat+Mixed_stat+Clown_stat+Shrimp_stat+Wrasse_stat;
unique_features = Clown_stat+Shrimp_stat+Wrasse_stat;

fprintf('\n\nEmpty: %i\nMixed: %i\nClown: %i\nShrimp: %i\nWrasse: %i\n',Empty_stat,Mixed_stat,Clown_stat,Shrimp_stat,Wrasse_stat);
fprintf('Total # of Animals: %d\n',unique_features);
fprintf('Total # of Images: %d\n',total);

%% Get Distribution of Features In Learning/Testing/Verification Databases
disp('Distribution Across Learning/Testing/Verifiation')
Empty_stat = size(dir(fullfile('Batches','Learning','Empty','*.png')),1);
Mixed_stat = size(dir(fullfile('Batches','Learning','Mixed','*.png')),1);
Clown_stat = size(dir(fullfile('Batches','Learning','Orange_Clownfish','*.png')),1);
Shrimp_stat = size(dir(fullfile('Batches','Learning','Shrimp','*.png')),1);
Wrasse_stat = size(dir(fullfile('Batches','Learning','Wrasse','*.png')),1);
total = Empty_stat+Mixed_stat+Clown_stat+Shrimp_stat+Wrasse_stat;
unique_features = Clown_stat+Shrimp_stat+Wrasse_stat;

fprintf('\nLearning Database\n')
fprintf('Empty: %i\nMixed: %i\nClown: %i\nShrimp: %i\nWrasse: %i\n',Empty_stat,Mixed_stat,Clown_stat,Shrimp_stat,Wrasse_stat);
fprintf('Total # of Animals: %d\n',unique_features);
fprintf('Total # of Images: %d\n',total);

Empty_stat = size(dir(fullfile('Batches','Testing','Empty','*.png')),1);
Mixed_stat = size(dir(fullfile('Batches','Testing','Mixed','*.png')),1);
Clown_stat = size(dir(fullfile('Batches','Testing','Orange_Clownfish','*.png')),1);
Shrimp_stat = size(dir(fullfile('Batches','Testing','Shrimp','*.png')),1);
Wrasse_stat = size(dir(fullfile('Batches','Testing','Wrasse','*.png')),1);
total = Empty_stat+Mixed_stat+Clown_stat+Shrimp_stat+Wrasse_stat;
unique_features = Clown_stat+Shrimp_stat+Wrasse_stat;

fprintf('\nTesting Database\n')
fprintf('Empty: %i\nMixed: %i\nClown: %i\nShrimp: %i\nWrasse: %i\n',Empty_stat,Mixed_stat,Clown_stat,Shrimp_stat,Wrasse_stat);
fprintf('Total # of Animals: %d\n',unique_features);
fprintf('Total # of Images: %d\n',total);

Empty_stat = size(dir(fullfile('Batches','Verification','Empty','*.png')),1);
Mixed_stat = size(dir(fullfile('Batches','Verification','Mixed','*.png')),1);
Clown_stat = size(dir(fullfile('Batches','Verification','Orange_Clownfish','*.png')),1);
Shrimp_stat = size(dir(fullfile('Batches','Verification','Shrimp','*.png')),1);
Wrasse_stat = size(dir(fullfile('Batches','Verification','Wrasse','*.png')),1);
total = Empty_stat+Mixed_stat+Clown_stat+Shrimp_stat+Wrasse_stat;
unique_features = Clown_stat+Shrimp_stat+Wrasse_stat;

fprintf('\nVerification Database\n')
fprintf('Empty: %i\nMixed: %i\nClown: %i\nShrimp: %i\nWrasse: %i\n',Empty_stat,Mixed_stat,Clown_stat,Shrimp_stat,Wrasse_stat);
fprintf('Total # of Animals: %d\n',unique_features);
fprintf('Total # of Images: %d\n',total);