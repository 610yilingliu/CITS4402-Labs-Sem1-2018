%% CITS4402 Lab1 Week2 Submission 
% Student: Damon van der Linde
% Student ID: 21506136
% Due Date: 13th March 2018 @ 4pm
%% Clear Environment
clear;
clc;
%% Tunable parameters

    % Image settings
    image = 'lego1.png';
    threshold = 170;
    
    % Morphological structuring element settings
    structuring_type = 'disk';
    structuring_size = 3;
    
    % Output Settings
    show_Figure = 0;
    
%% Perform Operations

% Read in the particular image
im = imread(image);

% Convert image to greyscale
im_grey = rgb2gray(im);

% Convert greyscale image to binary using the specified threshold
im_binary = im_grey > threshold;

% Setup structuring element
se = strel(structuring_type,structuring_size);

% Perform morphological oprations (closed and erode) 
im_closed = imclose(im_binary,se);
im_cc = imerode(im_closed,se);

% Count number of connected regions
connCompStruct = bwconncomp(~im_cc);

%% Present results 

% Print Figure if required
if (show_Figure ~= 0)
    imshow(~im_cc),title('Close + Erode operation');
    xlabel("Number of objects found = " + connCompStruct.NumObjects, 'FontSize', 12);
end

% Print number of objects found
connCompStruct.NumObjects