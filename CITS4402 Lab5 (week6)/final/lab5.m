%% CITS4402 Lab5 Week6 Submission 
% Student: Damon van der Linde
% Student ID: 21506136
% Due Date: 17th April 2018 @ 4pm
%% Auto generated functions by GUIDE 
% Various functions related to the GUI and its elements 
% that was automaically generated

function varargout = lab5(varargin)
% LAB5 MATLAB code for lab5.fig
%      LAB5, by itself, creates a new LAB5 or raises the existing
%      singleton*.
%
%      H = LAB5 returns the handle to a new LAB5 or the handle to
%      the existing singleton*.
%
%      LAB5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB5.M with the given input arguments.
%
%      LAB5('Property','Value',...) creates a new LAB5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab5

% Last Modified by GUIDE v2.5 06-Mar-2018 14:31:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab5_OpeningFcn, ...
                   'gui_OutputFcn',  @lab5_OutputFcn, ...
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

% --- Executes just before lab5 is made visible.
function lab5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab5 (see VARARGIN)

% Choose default command line output for lab5
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global imloaded;
imloaded = 0;
onStart(handles);

% --- Executes during object creation, after setting all properties.
function upperThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to upperThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Outputs from this function are returned to the command line.
function varargout = lab5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function lowerThreshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lowerThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% onStart is called when the GUI is starting up
% Load default peppers image and display on the left
% Ensure that the right axis does not display a graph
function onStart(handles)
global imloaded im hsv;
im = imread('peppers.png');
axes(handles.axes1);
imshow(im);
imloaded = 1;
createHSV();
%colourBasedSegmentation(-1,-1, handles);

%% Create and store hsv from an rbg imaged 
function createHSV()
global hsv im;
hsv = rgb2hsv(im);

%% Apply colour based segmentation
% Check if the default values have to be loaded
% otherwise assign the min and max to the passed variables 
% Display the colour based segementated image on the right axis
function colourBasedSegmentation(minThresholdP,maxThresholdP, handles)
global hsv;
axes(handles.axes2);

if minThresholdP == -1
    minThreshold = 0.05;
    maxThreshold = 0.85;
else
    minThreshold = minThresholdP;
    maxThreshold = maxThresholdP;
end

sliderBW = (hsv(:,:,1) >= minThreshold ) & (hsv(:,:,1) <= maxThreshold);
set(handles.axes2,'Visible', 'on');
imshow(sliderBW);

%% Called when the upper threshold slider is adjusted
% Update the colour based segmented image based on the 
% new value received from the slider 
function upperThreshold_Callback(hObject, eventdata, handles)
colourBasedSegmentation(get(handles.lowerThreshold,'Value'),get(hObject,'Value'), handles)

%% Called when the lower threshold slider is adjusted
% Update the colour based segmented image based on the 
% new value received from the slider 
function lowerThreshold_Callback(hObject, eventdata, handles)
colourBasedSegmentation(get(hObject,'Value'),get(handles.upperThreshold,'Value'), handles)

%% Function is executed when the load image button is pressed
% Open File dialogue should allow for any file to be selected 
% Open the new image and display it on the left axis 
% Create hsv from the new image 
% Display the colour based segmented image on the right axis with default
% values 
function loadImage_Callback(hObject, eventdata, handles)
global im imloaded;
[FileName,PathName,FilterIndex] = uigetfile({'*.*'}, 'Select an Image'); 
if (FilterIndex ~= 0)
    try
        file = fullfile(PathName,FileName);
        im = imread(file);
        axes(handles.axes1);
        imshow(im);
        imloaded = 1;
        createHSV();
        colourBasedSegmentation(-1,-1, handles);
    catch
        warning('Image loading/processing failed!');
    end
end 
