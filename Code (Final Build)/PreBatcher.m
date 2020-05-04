%John Schulz
% 4/10/18
% ECE 468 - Neural Networks
% Program: Parse Data Into Batches

% Intialize 
clc
clear all
close all

% Parameters
Train_p = 0.70;
Learn_p = 0.20;
Verif_p = 0.10;

%% Foramatted Feature Type Saved Location
dF1 = dir(fullfile('FormattedData','Empty','*.png'));
dF2 = dir(fullfile('FormattedData','Mixed','*.png'));
dF3 = dir(fullfile('FormattedData','Orange_Clownfish','*.png'));
dF4 = dir(fullfile('FormattedData','Shrimp','*.png'));
dF5 = dir(fullfile('FormattedData','Wrasse','*.png'));

% Number of Images for Each Feature
nF1 = size(dF1, 1);
nF2 = size(dF2, 1);
nF3 = size(dF3, 1);
nF4 = size(dF4, 1);
nF5 = size(dF5, 1);

% Get Number of Images for Learning, Testing, Verification
nF1_lim = [   round(nF1*Train_p)
              round(nF1*Learn_p)
              (nF1-(round(nF1*Train_p)+round(nF1*Learn_p)))
            ];
nF2_lim = [   round(nF2*Train_p)
              round(nF2*Learn_p)
              (nF2-(round(nF2*Train_p)+round(nF2*Learn_p)))
            ]; 
        
nF3_lim = [   round(nF3*Train_p)
              round(nF3*Learn_p)
              (nF3-(round(nF3*Train_p)+round(nF3*Learn_p)))
            ];
nF4_lim = [   round(nF4*Train_p)
              round(nF4*Learn_p)
              (nF4-(round(nF4*Train_p)+round(nF4*Learn_p)))
            ]; 
nF5_lim = [   round(nF5*Train_p)
              round(nF5*Learn_p)
              (nF5-(round(nF5*Train_p)+round(nF5*Learn_p)))
            ];
        
% Create an random Array to Randomly Map Images into Learn/Test/Verification       
nF1_order = [ones(1,nF1_lim(1,1)), 2*ones(1,nF1_lim(2,1)), 3*ones(1,nF1_lim(3,1))];
nF1_rand = nF1_order(:,randperm(size(nF1_order,2)));

nF2_order = [ones(1,nF2_lim(1,1)), 2*ones(1,nF2_lim(2,1)), 3*ones(1,nF2_lim(3,1))];
nF2_rand = nF2_order(:,randperm(size(nF2_order,2)));

nF3_order = [ones(1,nF3_lim(1,1)), 2*ones(1,nF3_lim(2,1)), 3*ones(1,nF3_lim(3,1))];
nF3_rand = nF3_order(:,randperm(size(nF3_order,2)));

nF4_order = [ones(1,nF4_lim(1,1)), 2*ones(1,nF4_lim(2,1)), 3*ones(1,nF4_lim(3,1))];
nF4_rand = nF4_order(:,randperm(size(nF4_order,2)));

nF5_order = [ones(1,nF5_lim(1,1)), 2*ones(1,nF5_lim(2,1)), 3*ones(1,nF5_lim(3,1))];
nF5_rand = nF5_order(:,randperm(size(nF5_order,2)));

%% ==============================================================Empty
disp('Batching Feature 1');
x = 1;
y = 1;
z = 1;
delete(fullfile('Batches','Learning','Empty','/*.png'));
delete(fullfile('Batches','Testing','Empty','/*.png'));
delete(fullfile('Batches','Verification','Empty','/*.png'));
for n = 1:nF1
tempImage = imread([dF1(n).folder,'/',dF1(n).name]);
    if( nF1_rand(1,n) == 1 )      
        Format = fullfile('Batches','Learning','Empty',['Image_',num2str(x),'.png']);
        imwrite(tempImage, Format, 'png');
        x = x + 1;
        clear tempImage
    elseif( nF1_rand(1,n) == 2 )
        Format = fullfile('Batches','Testing','Empty',['Image_',num2str(y),'.png']);
        imwrite(tempImage, Format, 'png');
        y = y + 1;
        clear tempImage
    elseif( nF1_rand(1,n) == 3)
        Format = fullfile('Batches','Verification','Empty',['Image_',num2str(z),'.png']);
        imwrite(tempImage, Format, 'png');
        z = z + 1;
        clear tempImage        
    end 
end

%% ===============================================================Mixed
disp('Batching Feature 2');
x = 1;
y = 1;
z = 1;
delete(fullfile('Batches','Learning','Mixed','/*.png'));
delete(fullfile('Batches','Testing','Mixed','/*.png'));
delete(fullfile('Batches','Verification','Mixed','/*.png'));
for n = 1:nF2
tempImage = imread([dF2(n).folder,'/',dF2(n).name]);
    if( nF2_rand(1,n) == 1 )      
        Format = fullfile('Batches','Learning','Mixed',['Image_',num2str(x),'.png']);
        imwrite(tempImage, Format, 'png');
        x = x + 1;
        clear tempImage
    elseif( nF2_rand(1,n) == 2 )
        Format = fullfile('Batches','Testing','Mixed',['Image_',num2str(y),'.png']);
        imwrite(tempImage, Format, 'png');
        y = y + 1;
        clear tempImage
    elseif( nF2_rand(1,n) == 3)
        Format = fullfile('Batches','Verification','Mixed',['Image_',num2str(z),'.png']);
        imwrite(tempImage, Format, 'png');
        z = z + 1;
        clear tempImage        
    end 
end

%% ===============================================================Orange_Clownfish
disp('Batching Feature 3');
x = 1;
y = 1;
z = 1;
delete(fullfile('Batches','Learning','Orange_Clownfish','/*.png'));
delete(fullfile('Batches','Testing','Orange_Clownfish','/*.png'));
delete(fullfile('Batches','Verification','Orange_Clownfish','/*.png'));
for n = 1:nF3
tempImage = imread([dF3(n).folder,'/',dF3(n).name]);
    if( nF3_rand(1,n) == 1 )      
        Format = fullfile('Batches','Learning','Orange_Clownfish',['Image_',num2str(x),'.png']);
        imwrite(tempImage, Format, 'png');
        x = x + 1;
        clear tempImage
    elseif( nF3_rand(1,n) == 2 )
        Format = fullfile('Batches','Testing','Orange_Clownfish',['Image_',num2str(y),'.png']);
        imwrite(tempImage, Format, 'png');
        y = y + 1;
        clear tempImage
    elseif( nF3_rand(1,n) == 3)
        Format = fullfile('Batches','Verification','Orange_Clownfish',['Image_',num2str(z),'.png']);
        imwrite(tempImage, Format, 'png');
        z = z + 1;
        clear tempImage        
    end 
end

%% ===============================================================Shrimp
disp('Batching Feature 4');
x = 1;
y = 1;
z = 1;
delete(fullfile('Batches','Learning','Shrimp','/*.png'));
delete(fullfile('Batches','Testing','Shrimp','/*.png'));
delete(fullfile('Batches','Verification','Shrimp','/*.png'));
for n = 1:nF4
tempImage = imread([dF4(n).folder,'/',dF4(n).name]);
    if( nF4_rand(1,n) == 1 )      
        Format = fullfile('Batches','Learning','Shrimp',['Image_',num2str(x),'.png']);
        imwrite(tempImage, Format, 'png');
        x = x + 1;
        clear tempImage
    elseif( nF4_rand(1,n) == 2 )
        Format = fullfile('Batches','Testing','Shrimp',['Image_',num2str(y),'.png']);
        imwrite(tempImage, Format, 'png');
        y = y + 1;
        clear tempImage
    elseif( nF4_rand(1,n) == 3)
        Format = fullfile('Batches','Verification','Shrimp',['Image_',num2str(z),'.png']);
        imwrite(tempImage, Format, 'png');
        z = z + 1;
        clear tempImage        
    end 
end

%% ===============================================================Wrasse
disp('Batching Feature 5');
x = 1;
y = 1;
z = 1;
delete(fullfile('Batches','Learning','Wrasse','/*.png'));
delete(fullfile('Batches','Testing','Wrasse','/*.png'));
delete(fullfile('Batches','Verification','Wrasse','/*.png'));
for n = 1:nF5
tempImage = imread([dF5(n).folder,'/',dF5(n).name]);
    if( nF5_rand(1,n) == 1 )      
        Format = fullfile('Batches','Learning','Wrasse',['Image_',num2str(x),'.png']);
        imwrite(tempImage, Format, 'png');
        x = x + 1;
        clear tempImage
    elseif( nF5_rand(1,n) == 2 )
        Format = fullfile('Batches','Testing','Wrasse',['Image_',num2str(y),'.png']);
        imwrite(tempImage, Format, 'png');
        y = y + 1;
        clear tempImage
    elseif( nF5_rand(1,n) == 3)
        Format = fullfile('Batches','Verification','Wrasse',['Image_',num2str(z),'.png']);
        imwrite(tempImage, Format, 'png');
        z = z + 1;
        clear tempImage        
    end 
end

disp('Done Batching');

%% =========== Get Learning/Testing/Verification Batch Sizes ============== 
disp('Learning')
Empty_stat = size(dir(fullfile('Batches','Learning','Empty','*.png')),1);
Mixed_stat = size(dir(fullfile('Batches','Learning','Mixed','*.png')),1);
Clown_stat = size(dir(fullfile('Batches','Learning','Orange_Clownfish','*.png')),1);
Shrimp_stat = size(dir(fullfile('Batches','Learning','Shrimp','*.png')),1);
Wrasse_stat = size(dir(fullfile('Batches','Learning','Wrasse','*.png')),1);
learn_total = Empty_stat+Mixed_stat+Clown_stat+Shrimp_stat+Wrasse_stat;
fprintf('Empty: %i\nMixed: %i\nClown: %i\nShrimp: %i\nWrasse: %i\n',Empty_stat,Mixed_stat,Clown_stat,Shrimp_stat,Wrasse_stat);
fprintf('Total # of Images: %d\n\n',learn_total);

disp('Testing')
Empty_stat = size(dir(fullfile('Batches','Testing','Empty','*.png')),1);
Mixed_stat = size(dir(fullfile('Batches','Testing','Mixed','*.png')),1);
Clown_stat = size(dir(fullfile('Batches','Testing','Orange_Clownfish','*.png')),1);
Shrimp_stat = size(dir(fullfile('Batches','Testing','Shrimp','*.png')),1);
Wrasse_stat = size(dir(fullfile('Batches','Testing','Wrasse','*.png')),1);
test_total = Empty_stat+Mixed_stat+Clown_stat+Shrimp_stat+Wrasse_stat;
fprintf('Empty: %i\nMixed: %i\nClown: %i\nShrimp: %i\nWrasse: %i\n',Empty_stat,Mixed_stat,Clown_stat,Shrimp_stat,Wrasse_stat);
fprintf('Total # of Images: %d\n\n',test_total);

disp('Verification')
Empty_stat = size(dir(fullfile('Batches','Verification','Empty','*.png')),1);
Mixed_stat = size(dir(fullfile('Batches','Verification','Mixed','*.png')),1);
Clown_stat = size(dir(fullfile('Batches','Verification','Orange_Clownfish','*.png')),1);
Shrimp_stat = size(dir(fullfile('Batches','Verification','Shrimp','*.png')),1);
Wrasse_stat = size(dir(fullfile('Batches','Verification','Wrasse','*.png')),1);
veri_total = Empty_stat+Mixed_stat+Clown_stat+Shrimp_stat+Wrasse_stat;
fprintf('Empty: %i\nMixed: %i\nClown: %i\nShrimp: %i\nWrasse: %i\n',Empty_stat,Mixed_stat,Clown_stat,Shrimp_stat,Wrasse_stat);
fprintf('Total # of Images: %d\n\n',veri_total);