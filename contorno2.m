function varargout = contorno2(varargin)
% CONTORNO2 MATLAB code for contorno2.fig
%      CONTORNO2, by itself, creates a new CONTORNO2 or raises the existing
%      singleton*.
%
%      H = CONTORNO2 returns the handle to a new CONTORNO2 or the handle to
%      the existing singleton*.
%
%      CONTORNO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTORNO2.M with the given input arguments.
%
%      CONTORNO2('Property','Value',...) creates a new CONTORNO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before contorno2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to contorno2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help contorno2

% Last Modified by GUIDE v2.5 13-Apr-2018 13:22:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @contorno2_OpeningFcn, ...
                   'gui_OutputFcn',  @contorno2_OutputFcn, ...
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


% --- Executes just before contorno2 is made visible.
function contorno2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to contorno2 (see VARARGIN)

% Choose default command line output for contorno2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load Ima3;
load Imao;

siz=size(I);
axes(handles.scor)
imshow(I4),title 'Mamografía sin contorno recuperado'
for x=1:siz(1)
        for y=1:siz(2)-nc
                Ior(x,y)=I(x,y+nc);
        end
end

I4bw=im2bw(I4,1/256);
se=strel('disk',20);
I5bw=imdilate(I4bw,se);
I5=uint8(I5bw) .* Ior;
axes(handles.ccor)
imshow(I5),title 'Contorno recuperado'
set(handles.aceptar,'UserData',I4);
set(handles.siguiente,'UserData',Ior);
I4=I5;
save Ima3 I4;

% UIWAIT makes contorno2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = contorno2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in atras.
function atras_Callback(hObject, eventdata, handles)
% hObject    handle to atras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
B2orientacion1;


% --- Executes on button press in siguiente.
function siguiente_Callback(hObject, eventdata, handles)
% hObject    handle to siguiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
aexmp;



function tse_Callback(hObject, eventdata, handles)
% hObject    handle to tse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tse as text
%        str2double(get(hObject,'String')) returns contents of tse as a double
tse=str2double(get(hObject,'String'));
set(handles.tse, 'UserData',tse);


% --- Executes during object creation, after setting all properties.
function tse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in aceptar.
function aceptar_Callback(hObject, eventdata, handles)
% hObject    handle to aceptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I4=get(handles.aceptar,'UserData');
Ior=get(handles.siguiente,'UserData');
tse=get(handles.tse,'UserData');
I4bw=im2bw(I4,1/256);
se=strel('disk',tse);
I5bw=imdilate(I4bw,se);
I5=uint8(I5bw) .* Ior;
axes(handles.ccor)
imshow(I5),title 'Contorno recuperado'
I4=I5;
save Ima3 I4;
