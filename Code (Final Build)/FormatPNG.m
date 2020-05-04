%John Schulz
% 4/9/18
% ECE 468 - Neural Networks
% Program: Read PNG Images, Downscale, Then Save As PNG 24 bit color

% Intialize 
clc
clear all
close all

%Parameters
Res_y = 96; % resolution number of rows in the image
Res_x = 128; % resolution number of columns in the image
temp_x = 0;
temp_y = 0;
Num_of_Features = 5;

%% Foramatted Feature Type Saved Location
F1 = fullfile('FormattedData','Empty','*.png');
F2 = fullfile('FormattedData','Mixed','*.png');
F3 = fullfile('FormattedData','Orange_Clownfish','*.png');
F4 = fullfile('FormattedData','Shrimp','*.png');
F5 = fullfile('FormattedData','Wrasse','*.png');

% Unformated Feature Type Saved Location
duF1 = dir(fullfile('SortedData','Empty','*png'));
duF2 = dir(fullfile('SortedData','Mixed','*.png'));
duF3 = dir(fullfile('SortedData','Orange_Clownfish','*.png'));
duF4 = dir(fullfile('SortedData','Shrimp','*.png'));
duF5 = dir(fullfile('SortedData','Wrasse','*.png'));

% Number of Images for Each Feature
nF1 = size(duF1, 1);
nF2 = size(duF2, 1);
nF3 = size(duF3, 1);
nF4 = size(duF4, 1);
nF5 = size(duF5, 1);

disp('Starting Formating Process');
disp('Formatting Feature 1')

%% ====================== Format Feature 1 ===========================
% Clear All Images from the Directory Being Saved To
% Read from unformated file location
% Get Resolution Info on Unformated Images
% If Image does not have the right resolution or File Format as PNG
%       Resize for 128 x 96
%       Save Image to Formated Feature Folder
%       Clear temporary
% --------------------------------------------------------------------
delete(F1);

for n = 1:nF1
tempImage = imread([duF1(n).folder,'/',duF1(n).name]);
info = imfinfo([duF1(n).folder,'/',duF1(n).name]);
temp_x = info.Width;
temp_y = info.Height;
Img_format = info.Format;

% Save Fromatted Images as
FormatF1 = fullfile('FormattedData','Empty',['Image_',num2str(n),'.png']);

    if( (temp_x ~= Res_x) || (temp_y ~= Res_y) || strcmp(Img_format, 'png') == 0)
        tempImage = imresize(tempImage, [Res_y, Res_x]);
        imwrite(tempImage, FormatF1, 'png');
        clear tempImage
    else
        imwrite(tempImage, FormatF1, 'png');
        clear tempImage
    end 
end

disp('Formatting Feature 2')
pause(2);

%% ====================== Format Feature 2 ===========================
% Clear All Images from the Directory Being Saved To
% Read from unformated file location
% Get Resolution Info on Unformated Images
% If Image does not have the right resolution or File Format as PNG
%       Resize for 128 x 96
%       Save Image to Formated Feature Folder
%       Clear temporary
% --------------------------------------------------------------------
delete(F2);

for n = 1:nF2
tempImage = imread([duF2(n).folder,'/',duF2(n).name]);
info = imfinfo([duF2(n).folder,'/',duF2(n).name]);
temp_x = info.Width;
temp_y = info.Height;
Img_format = info.Format;

% Save Fromatted Images as
FormatF2 = fullfile('FormattedData','Mixed',['Image_',num2str(n),'.png']);

    if( (temp_x ~= Res_x) || (temp_y ~= Res_y) || strcmp(Img_format, 'png') == 0)
        tempImage = imresize(tempImage, [Res_y, Res_x]);
        imwrite(tempImage, FormatF2, 'png');
        clear tempImage
    else
        imwrite(tempImage, FormatF2, 'png');
        clear tempImage
    end 
end

disp('Formatting Feature 3')
pause(2);

%% ====================== Format Feature 3 ===========================
% Clear All Images from the Directory Being Saved To
% Read from unformated file location
% Get Resolution Info on Unformated Images
% If Image does not have the right resolution or File Format as PNG
%       Resize for 128 x 96
%       Save Image to Formated Feature Folder
%       Clear temporary
% --------------------------------------------------------------------
delete(F3);

for n = 1:nF3
tempImage = imread([duF3(n).folder,'/',duF3(n).name]);
info = imfinfo([duF3(n).folder,'/',duF3(n).name]);
temp_x = info.Width;
temp_y = info.Height;
Img_format = info.Format;

% Save Fromatted Images as
FormatF3 = fullfile('FormattedData','Orange_Clownfish',['Image_',num2str(n),'.png']);

    if( (temp_x ~= Res_x) || (temp_y ~= Res_y) || strcmp(Img_format, 'png') == 0)
        tempImage = imresize(tempImage, [Res_y, Res_x]);
        imwrite(tempImage, FormatF3, 'png');
        clear tempImage
    else
        imwrite(tempImage, FormatF3, 'png');
        clear tempImage
    end 
end

disp('Formatting Feature 4')
pause(2);

%% ====================== Format Feature 4 ===========================
% Clear All Images from the Directory Being Saved To
% Read from unformated file location
% Get Resolution Info on Unformated Images
% If Image does not have the right resolution or File Format as PNG
%       Resize for 128 x 96
%       Save Image to Formated Feature Folder
%       Clear temporary
% --------------------------------------------------------------------
delete(F4);

for n = 1:nF4
tempImage = imread([duF4(n).folder,'/',duF4(n).name]);
info = imfinfo([duF4(n).folder,'/',duF4(n).name]);
temp_x = info.Width;
temp_y = info.Height;
Img_format = info.Format;

% Save Fromatted Images as
FormatF4 = fullfile('FormattedData','Shrimp',['Image_',num2str(n),'.png']);

    if( (temp_x ~= Res_x) || (temp_y ~= Res_y) || strcmp(Img_format, 'png') == 0)
        tempImage = imresize(tempImage, [Res_y, Res_x]);
        imwrite(tempImage, FormatF4, 'png');
        clear tempImage
    else
        imwrite(tempImage, FormatF4, 'png');
        clear tempImage
    end 
end

disp('Formatting Feature 5')
pause(2);

%% ====================== Format Feature 5 ===========================
% Clear All Images from the Directory Being Saved To
% Read from unformated file location
% Get Resolution Info on Unformated Images
% If Image does not have the right resolution or File Format as PNG
%       Resize for 128 x 96
%       Save Image to Formated Feature Folder
%       Clear temporary
% --------------------------------------------------------------------
delete(F5);

for n = 1:nF5
tempImage = imread([duF5(n).folder,'/',duF5(n).name]);
info = imfinfo([duF5(n).folder,'/',duF5(n).name]);
temp_x = info.Width;
temp_y = info.Height;
Img_format = info.Format;

% Save Fromatted Images as
FormatF5 = fullfile('FormattedData','Wrasse',['Image_',num2str(n),'.png']);

    if( (temp_x ~= Res_x) || (temp_y ~= Res_y) || strcmp(Img_format, 'png') == 0)
        tempImage = imresize(tempImage, [Res_y, Res_x]);
        imwrite(tempImage, FormatF5, 'png');
        clear tempImage
    else
        imwrite(tempImage, FormatF5, 'png');
        clear tempImage
    end 
end

disp('Done Formatting All Features')
disp(' ');

%% =================== Get Feature Statistics ========================
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


