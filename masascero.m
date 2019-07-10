function varargout = masascero(varargin)
% MASASCERO MATLAB code for masascero.fig
%      MASASCERO, by itself, creates a new MASASCERO or raises the existing
%      singleton*.
%
%      H = MASASCERO returns the handle to a new MASASCERO or the handle to
%      the existing singleton*.
%
%      MASASCERO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASASCERO.M with the given input arguments.
%
%      MASASCERO('Property','Value',...) creates a new MASASCERO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before masascero_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to masascero_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help masascero

% Last Modified by GUIDE v2.5 02-Jun-2018 17:39:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @masascero_OpeningFcn, ...
                   'gui_OutputFcn',  @masascero_OutputFcn, ...
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


% --- Executes just before masascero is made visible.
function masascero_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to masascero (see VARARGIN)

% Choose default command line output for masascero
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes masascero wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = masascero_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cont.
function cont_Callback(hObject, eventdata, handles)
% hObject    handle to cont (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close masascero;
