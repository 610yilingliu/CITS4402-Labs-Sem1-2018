%% CITS4402 Lab4 Week5 Submission 
% Student: Damon van der Linde
% Student ID: 21506136
% Due Date: 3rd April 2018 @ 4pm
%% Auto generated functions by GUIDE 
% Various functions related to the GUI and its elements 
% that was automaically generated 

function varargout = week5lab(varargin)
% WEEK5LAB MATLAB code for week5lab.fig
%      WEEK5LAB, by itself, creates a new WEEK5LAB or raises the existing
%      singleton*.
%
%      H = WEEK5LAB returns the handle to a new WEEK5LAB or the handle to
%      the existing singleton*.
%
%      WEEK5LAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WEEK5LAB.M with the given input arguments.
%
%      WEEK5LAB('Property','Value',...) creates a new WEEK5LAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before week5lab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to week5lab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help week5lab

% Last Modified by GUIDE v2.5 05-Mar-2018 20:55:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @week5lab_OpeningFcn, ...
                   'gui_OutputFcn',  @week5lab_OutputFcn, ...
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

% --- Executes just before week5lab is made visible.
function week5lab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to week5lab (see VARARGIN)

% Choose default command line output for week5lab
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Define global variable to manage the image loaded status
global imloaded edgeAlgo;
imloaded = 0;

% UIWAIT makes week5lab wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Executes on selection change in edgeAlgorithm.
function edgeAlgorithm_Callback(hObject, eventdata, handles)
% hObject    handle to edgeAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns edgeAlgorithm contents as cell array
%        contents{get(hObject,'Value')} returns selected item from edgeAlgorithm

% --- Executes during object creation, after setting all properties.
function edgeAlgorithm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edgeAlgorithm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Outputs from this function are returned to the command line.
function varargout = week5lab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% --- Executes during object creation, after setting all properties.
function circleRadius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to circleRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

%% Adjust the edge detector threshold
% Function is called on threshold slider adjustment
% Get the new threshold value from the slider
% Generate Image based on this value
% Display the new Image
function circleRadius_Callback(hObject, eventdata, handles)
radii = get(hObject,'Value');
threshold = get(handles.threshold,'Value');
edgeDetector(threshold, handles, radii);

%% Adjust radii range for circle detection.
% Function is called on radii slider adjustment
% Get the new radii value from the slider
% Generate newly found circles if any
% Overlap these found circles on left and right axis
function threshold_Callback(hObject, eventdata, handles)
threshold = get(hObject,'Value');
radii = get(handles.circleRadius,'Value')
edgeDetector(threshold, handles, radii);

%% Load Image
% Code gets executed when loadImgeButton is pressed.
% Open file dialog box, Supported formats Image file types
% Check and set image load status as required
% Load Image into the left axes
function loadImage_Callback(hObject, eventdata, handles)
global im im_gray imloaded;
[FileName,PathName,FilterIndex] = uigetfile({'*.png;*.jpg;*.bmp;*.tif;';'*.*'}, 'Select an Image'); 
if (FilterIndex ~= 0)
    try
        file = fullfile(PathName,FileName);
        im = imread(file);
        try
            im_gray = rgb2gray(im);
        catch
            im_gray = im;
        end
        axes(handles.axes1);
        imshow(im);
        imloaded = 1;
    catch
        
    end
end 

%% Edge detection button is pressed
% Check that an Image has been loaded
% Check which algorithm is selected
% Call the edge detector function with values to
% signify to use the defaults
function detectEdges_Callback(hObject, eventdata, handles)
global imloaded edgeAlgo;
if (imloaded == 1)
    switch get(handles.edgeAlgorithm,'Value')
         case 1
             edgeAlgo = 'Prewitt';
         case 2 
             edgeAlgo = 'Canny';
         case 3
             edgeAlgo = 'Sobel';
         case 4
             edgeAlgo = 'Roberts';
         case 5
             edgeAlgo = 'log';
    end
    edgeDetector(-1, handles, -1);
else
    msgbox('Please ensure image has been loaded before attempting image operations', 'No Loaded Image','error');
end

%% Edge decector function 
% Check the threshold value to determine if 
% default value should be used as well as a default
% radii range
% Display the processed Image on the Second axis 
% Try to find circles in a given radii range 
% Overlap these circles on the Left and right axis 
function edgeDetector(threshold, handles, radii)
global im_gray im edgeAlgo

if (threshold == -1)
    im_processed = edge(im_gray, edgeAlgo);
else
    im_processed = edge(im_gray, edgeAlgo, threshold);
end

axes(handles.axes2);
imshow(im_processed);

if(radii == -1)
    
else
    radii_min = uint8(radii-4);
    radii_max = uint8(radii+4);
    
    [centers, radiiA] = imfindcircles(im_processed,[radii_min,radii_max], 'ObjectPolarity', 'bright','Sensitivity', 0.93);
    viscircles(centers, radiiA, 'Color','b');
    
    axes(handles.axes1);
    imshow(im);
    viscircles(centers, radiiA, 'Color','b');
end