% John Schulz
% 4/4/18
% ECE 468 - Neural Networks
% Program: Read Video Data, Break Frames, Save As PNG

%Initialize
clc
clear all
close all

%Parameters
Res_x = 240;        % resolution of rows in the image
Res_y = 320;        % resolution of columns in the image
f_split = 3;       % divisor of each frame

%% Clear the images based on current directory in UNIX 
delete(fullfile('RawData','Photos','*.png'));

% Find number of movies in folder
num_of_mov = dir(fullfile('RawData','Movies','*.m4v'));
num_of_mov = size(num_of_mov,1);

% Preallocation
frame_down = zeros(Res_x, Res_y, 3);

% Print Video Info
% info = mmfileinfo(fullfile('RawData','Movies',['MVI_',num2str(2),'.m4v']));
% info.Video

%% ================= Start Conversion of .m4v to .png =====================
n = 0;
z = 0;
x = 5;
% for x = 1:num_of_mov
    
    % Import Videos and Print Stats
    v = VideoReader(fullfile('RawData','Movies',['MVI_',num2str(x),'.m4v']));
    disp(['Filename: MVI_',num2str(x),'.m4v']);
    disp(['Duration = ',num2str(v.Duration),'[s]']);
    disp(['Frame Rate per [sec] = ', num2str(round(v.FrameRate))]);
    disp(['Frame Rate Saved per [sec] = ',num2str(round(v.FrameRate/f_split))]);
    disp(['Total Frames = ', num2str(round(v.Duration)*round(v.FrameRate))]);
    disp(['Total Frames to Save = ',num2str(round((v.Duration*v.FrameRate)/f_split))])
    clear frame
    disp('Press Enter To Start');
    pause;
    
    while hasFrame(v)
        frame = readFrame(v);
        if mod(n, f_split) == 0 %save @ x fps 
            
            %FrameSavedNumber counter
            z = z + 1;
            
            %Downscale
            frame_down = imresize(frame, [Res_x, Res_y]);
            
            % Format: "Image_FrameSavedNumber_VideoNumber_FrameNumber_Date
            Format = fullfile('RawData','Photos',['Image_',num2str(z),'_',num2str(x),'_',num2str(n),'_',datestr(datetime('today')),'.png']);
            imwrite(frame_down,Format,'png');
        end 
        n = n + 1;     
    end
    disp(['Number of Images Successfully Saved = ',num2str(size(dir(fullfile('RawData','Photos','*.png')),1)), ' PNGs'])
    fprintf('\nPress Enter to Load next set of Images\n'); 
    pause; % pause at each video file to edit or move images
% end


%% =================== Get Feature Statistics ========================
Empty_stat = size(dir(fullfile('SortedData','Empty','*.png')),1);
Mixed_stat = size(dir(fullfile('SortedData','Mixed','*.png')),1);
Clown_stat = size(dir(fullfile('SortedData','Orange_Clownfish','*.png')),1);
Shrimp_stat = size(dir(fullfile('SortedData','Shrimp','*.png')),1);
Wrasse_stat = size(dir(fullfile('SortedData','Wrasse','*.png')),1);
total = Empty_stat+Mixed_stat+Clown_stat+Shrimp_stat+Wrasse_stat;
unique_features = Clown_stat+Shrimp_stat+Wrasse_stat;

fprintf('\n\nEmpty: %i\nMixed: %i\nClown: %i\nShrimp: %i\nWrasse: %i\n',Empty_stat,Mixed_stat,Clown_stat,Shrimp_stat,Wrasse_stat);
fprintf('Total # of Animals: %d\n',unique_features);
fprintf('Total # of Images: %d\n',total);