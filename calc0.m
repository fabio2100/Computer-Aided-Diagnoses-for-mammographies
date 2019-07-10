function varargout = calc0(varargin)
% CALC0 MATLAB code for calc0.fig
%      CALC0, by itself, creates a new CALC0 or raises the existing
%      singleton*.
%
%      H = CALC0 returns the handle to a new CALC0 or the handle to
%      the existing singleton*.
%
%      CALC0('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CALC0.M with the given input arguments.
%
%      CALC0('Property','Value',...) creates a new CALC0 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before calc0_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to calc0_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help calc0

% Last Modified by GUIDE v2.5 20-Jul-2018 18:38:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @calc0_OpeningFcn, ...
                   'gui_OutputFcn',  @calc0_OutputFcn, ...
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


% --- Executes just before calc0 is made visible.
function calc0_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to calc0 (see VARARGIN)

% Choose default command line output for calc0
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes calc0 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = calc0_OutputFcn(hObject, eventdata, handles) 
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
close
IL;