
%% CITS4402 Lab3 Week4 Submission 
% Student: Damon van der Linde
% Student ID: 21506136
% Due Date: 27th March 2018 @ 4pm
%% Auto generated functions by GUIDE 
% Various functions related to the GUI and its elements 
% that was automaically generated 

function varargout = week4lab(varargin)
% week4lab MATLAB code for week4lab.fig
%      week4lab, by itself, creates a new week4lab or raises the existing
%      singleton*.
%
%      H = week4lab returns the handle to a new week4lab or the handle to
%      the existing singleton*.
%
%      week4lab('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in week4lab.M with the given input arguments.
%
%      week4lab('Property','Value',...) creates a new week4lab or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before week4lab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to week4lab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help week4lab

% Last Modified by GUIDE v2.5 05-Mar-2018 14:40:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @week4lab_OpeningFcn, ...
                   'gui_OutputFcn',  @week4lab_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before week4lab is made visible.
function week4lab_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for week4lab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Clear variables as wll as Console Log
clear;
clc;

%Define global variable to manage the image loaded status
global imloaded;
imloaded = 0;

% --- Outputs from this function are returned to the command line.
function varargout = week4lab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function filterSize_Callback(hObject, eventdata, handles)
% hObject    handle to filterSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function filterSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filterSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function sigma_Callback(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function boostFactorVal_Callback(hObject, eventdata, handles)
% hObject    handle to boostFactorVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function boostFactorVal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to boostFactorVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%% Load Image Button 
% Code gets executed when loadImgeButton is pressed.
% Open file dialog box, Supported formats Image file types
% Check and set image load status as required
% Load Image into the left axes
function loadImageButton_Callback(hObject, eventdata, handles)
global im imloaded;
[FileName,PathName,FilterIndex] = uigetfile({'*.png;*.jpg;*.bmp;*.tif;';'*.*'}, 'Select an Image'); 
if (FilterIndex ~= 0)
    try
        file = fullfile(PathName,FileName);
        im = imread(file);
        axes(handles.axes1);
        imshow(im);
        imloaded = 1;
        cla(handles.axes2);
    catch
        warning('Image loading failed!');
    end
end

%% Histogram Equalizer
% Code gets executed when histogramEqualize button is pressed.
% Check image load status 
% Apply histogram Equilizer and output image to the right axes
function histogramEqualize_Callback(hObject, eventdata, handles)
global im imloaded;
if (imloaded == 1)
    im_hist = histeq(im);
    axes(handles.axes2);
    imshow(im_hist);  
else
    msgbox('Please ensure image has been loaded before attempting image operations', 'No Loaded Image','error');
end

%% High Boost Button
% Code gets executed when highBoost button is pressed
% Boost the high frequency components of image
% HighBoost = (b-1) * Original + HighPass
% b refers the boosting factor
function highBoost_Callback(hObject, eventdata, handles)
global im imloaded;
if (imloaded == 1)
   boostFactor =  str2double(get(handles.boostFactorVal,'String'));
   im_lowFilter = imgaussfilt(im,6);
   im_highFilter = im - im_lowFilter;
   im_highBoost =  (boostFactor - 1) * im + im_highFilter;
   axes(handles.axes2);
   imshow(im_highBoost);
else
    msgbox('Please ensure image has been loaded before attempting image operations', 'No Loaded Image','error');
end

%% Low Pass Button
% Code gets executed when lowPass button is pressed.
% Check image load status 
% Get Sigma and filter size paramters valus from the text boxes
% Apply Gussian filter and disply the image on the right axes
function lowPass_Callback(hObject, eventdata, handles)
global im imloaded;
if (imloaded == 1)
    filterSize =  str2double(get(handles.filterSize,'String'));
    sigma =  str2double(get(handles.sigma,'String'));
    im_lowFilter = imgaussfilt(im,sigma,'Filtersize',filterSize);
    axes(handles.axes2);
    imshow(im_lowFilter);
else
    msgbox('Please ensure image has been loaded before attempting image operations', 'No Loaded Image','error');
end

%% High Pass Button
% Code gets executed when highPass button is pressed.
% HighPass = Orginal - LowPass
function highPass_Callback(hObject, eventdata, handles)
global im imloaded;
if (imloaded == 1)
     im_lowFilter = imgaussfilt(im,6);
     im_highFilter = im - im_lowFilter;
     axes(handles.axes2);
     imshow(im_highFilter);
else
     msgbox('Please ensure image has been loaded before attempting image operations', 'No Loaded Image','error');
end