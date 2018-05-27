%% CITS4402 Lab2 week3 Submission (test1.m uses provided example images) 
% Student: Damon van der Linde
% Student ID: 21506136
% Due Date: 20th March 2018 @ 4pm
%% Clearing Environment 
clear;
clc;
%% Tunable Parameters

    % Images settings
    file1 = 'cat.jpg';
    file2 = 'mouse.jpg';
    
    % Lowpass filter settings
    c_lowpass = 0.038;
    n_lowpass = 2;
    
    % Highpass filter settings
    c_highpass = 0.25;
    n_highpass = 2;

%% Perform Operations 

% Read in the images
im1 = imread(file1);
im2 = imread(file2); 

% Convert Images to Greyscale
im1_grey = rgb2gray(im1);
im2_grey = rgb2gray(im2);

% Get size of the images (used in setting filter size)
im1_size = size(im1_grey);
im2_size = size(im2_grey);

% Apply Fourier transform to both images
im1_grey_fft2 = fft2(im1_grey);
im2_grey_fft2 = fft2(im2_grey);

% Create the low pass and high pass filters 
lowpassFilter = lowpassfilter(im1_size,c_lowpass,n_lowpass);
highpassFilter = highpassfilter(im2_size,c_highpass,n_highpass);

% Manipulate the frequency domain by performing matrix multiplication using
% the filters created above
im2_grey_fft2_hp = im2_grey_fft2.*highpassFilter;
im1_grey_ftt2_lp = im1_grey_fft2.*lowpassFilter;

% Perform Inverse Fourier Transform on both images
im1_final = ifft2(im1_grey_ftt2_lp);
im2_final = ifft2(im2_grey_fft2_hp);

% Produce the hybrid image through adding the freuqency domains of the two
% manipulated images, afterwards performing inverse Fourier transform
im3_hybrid = ifft2(fft2(im1_final) + fft2(im2_final));


%% Present the results through the use of figures

figure('rend','painters','pos',[10 10 1400 600])

% Show the original image for the low pass filtered image
subplot(2,4,1);
imshow(im1), title('Original Image 1');
axis on;
xlabel("pixel", 'FontSize', 8);
ylabel("pixel", 'FontSize', 8);

% Show the original image for the high pass filtered image
subplot(2,4,5);
imshow(im2), title('Original Image 2');
axis on;
xlabel("pixel", 'FontSize', 8);
ylabel("pixel", 'FontSize', 8);

% Show the greyscale image for the low pass filtered image
subplot(2,4,2);
imshow(im1_grey), title('Greyscale Image 1');
axis on;
xlabel("pixel", 'FontSize', 8);
ylabel("pixel", 'FontSize', 8);

% Show the greyscale image for the high pass filtered image
subplot(2,4,6);
imshow(im2_grey), title('Greyscale Image 2');
axis on;
xlabel("pixel", 'FontSize', 8);
ylabel("pixel", 'FontSize', 8);

% Show the low pass filtered image
subplot(2,4,3);
ifftshow(im1_final), title('Lowpass filtered Image');
axis on;
xlabel("pixel", 'FontSize', 8);
ylabel("pixel", 'FontSize', 8);

% Show the high pass filtered image
subplot(2,4,7);
ifftshow(im2_final), title('Highpass filtered Image');
axis on;
xlabel("pixel", 'FontSize', 8);
ylabel("pixel", 'FontSize', 8);

% Show the hybrid image
h = subplot(2,4,4);
ifftshow(im3_hybrid), title('Hybrid Image');
axis on;
xlabel("pixel", 'FontSize', 8);
ylabel("pixel", 'FontSize', 8);

% Offset the hybrid image
current_Pos = get(h, 'Position'); 
new_Pos = current_Pos; 
new_Pos(1) = new_Pos(1) + 0.04; 
new_Pos(2) = new_Pos(2) - 0.2; 
set(h, 'Position', new_Pos);

