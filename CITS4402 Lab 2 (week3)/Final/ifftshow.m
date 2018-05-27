%% Helper Function 
% Description: Helps display images that have been inverse Fourier transformed
% Author: Rashi Agrawal

%% Function
function [] = ifftshow(f)
f1 = abs(f);
fm = max(f1(:));
imshow(f1/fm);
end

%% Full reference
% Agrawal, R. (2014). Low Pass Filter in Fourier Domain Using MATLAB. 
% [video] Available at: https://www.youtube.com/watch?v=0lTSERUFuQQ 
% [Accessed 3 Mar. 2018].