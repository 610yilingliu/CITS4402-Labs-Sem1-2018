clear;
clc;
% CITS4402 Computer Vision
% Week 2 Lab (Morphological image processing operations) 
% Student: Damon van der Linde
% Student ID: 21506136

% Tunable parameters
image = 'lego1.png';
threshold = 170;
structuring_type = 'disk';
structuring_size = 3; %3 was found to be sufficient
invertImage = true;

% Morphological Operations
performErode = true;
performDilate = true;
performOpen = true;
performClose = true;
performcloseWithErode = true;
% End of Tunable parameters

im = imread(image);
im_grey = rgb2gray(im);
im_hist = imhist(im_grey);
im_binary = im_grey > threshold;
se = strel(structuring_type,structuring_size);
 
ax5 = subplot(2,3,1);
imshow(im), title('Original');
xlabel("Number of objects expected = 20", 'FontSize', 12);

if(performErode == true)
    im_erode = imerode(im_binary,se);
    ax1 = subplot(2,3,2);
    imshow(~im_erode), title('Erode operation');
    temp = bwconncomp(~im_erode);
    xlabel("Number of objects found = " + temp.NumObjects, 'FontSize', 12);   
end

if(performDilate == true)
    im_dilate = imdilate(im_binary,se);
    ax2 = subplot(2,3,3);
    imshow(~im_dilate), title('Dilate operation');
    temp = bwconncomp(~im_dilate);
    xlabel("Number of objects found = " + temp.NumObjects, 'FontSize', 12);
    
end

if(performOpen == true)
    im_open = imopen(im_binary,se);
    ax3 = subplot(2,3,4);
    imshow(~im_open), title('Open operation');
    temp = bwconncomp(~im_open);
    xlabel("Number of objects found = " + temp.NumObjects, 'FontSize', 12);
end

if(performClose == true)
    im_closed = imclose(im_binary,se);
    ax4 = subplot(2,3,5);
    imshow(~im_closed),title('Close operation');
    temp = bwconncomp(~im_closed);
    xlabel("Number of objects found = " + temp.NumObjects, 'FontSize', 12);
end  

if(performcloseWithErode == true)
    im_cc = imerode(im_closed,se);
    ax4 = subplot(2,3,6);
    imshow(~im_cc),title('Close + Erode operation');
    temp = bwconncomp(~im_cc);
    xlabel("Number of objects found = " + temp.NumObjects, 'FontSize', 12);
end  

