function varargout = Kite(varargin)
% KITE MATLAB code for Kite.fig
%      KITE, by itself, creates a new KITE or raises the existing
%      singleton*.
%
%      H = KITE returns the handle to a new KITE or the handle to
%      the existing singleton*.
%
%      KITE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KITE.M with the given input arguments.
%
%      KITE('Property','Value',...) creates a new KITE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Kite_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Kite_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Kite

% Last Modified by GUIDE v2.5 28-May-2018 15:19:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Kite_OpeningFcn, ...
                   'gui_OutputFcn',  @Kite_OutputFcn, ...
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


% --- Executes just before Kite is made visible.
function Kite_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Kite (see VARARGIN)

% Choose default command line output for Kite
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load ima5
nc11=4;
for i=2:nc11
    a1=double(mprecf(:));
    [idx,nn]=kmeans(a1,i);
    ima=uint8(reshape(idx,size(mprecf)));
    ima2=imadjust(ima,[0 i/256],[]);
    axes(handles.iterar)
    imshow(ima2),title 'Agrupada'
    pause(0.1)
end
    

% UIWAIT makes Kite wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Kite_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function nc1_Callback(hObject, eventdata, handles)
% hObject    handle to nc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nc1 as text
%        str2double(get(hObject,'String')) returns contents of nc1 as a double
nc11=str2double(get(hObject,'String'));
save nc11 nc11


% --- Executes during object creation, after setting all properties.
function nc1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nc1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reha.
function reha_Callback(hObject, eventdata, handles)
% hObject    handle to reha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nc11=4;
load nc11
load ima5
for i=2:nc11
    a1=double(mprecf(:));
    [idx,nn]=kmeans(a1,i);
    ima=uint8(reshape(idx,size(mprecf)));
    ima2=imadjust(ima,[0 i/256],[]);
    axes(handles.iterar)
    imshow(ima2),title 'Agrupada'
    pause(0.1)
end


% --- Executes on button press in cerrar.
function cerrar_Callback(hObject, eventdata, handles)
% hObject    handle to cerrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
detmasas;
close Kite;
