function varargout = IOrySAr(varargin)
% IORYSAR MATLAB code for IOrySAr.fig
%      IORYSAR, by itself, creates a new IORYSAR or raises the existing
%      singleton*.
%
%      H = IORYSAR returns the handle to a new IORYSAR or the handle to
%      the existing singleton*.
%
%      IORYSAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IORYSAR.M with the given input arguments.
%
%      IORYSAR('Property','Value',...) creates a new IORYSAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before IOrySAr_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to IOrySAr_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help IOrySAr

% Last Modified by GUIDE v2.5 09-Apr-2018 15:28:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @IOrySAr_OpeningFcn, ...
                   'gui_OutputFcn',  @IOrySAr_OutputFcn, ...
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


% --- Executes just before IOrySAr is made visible.
function IOrySAr_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to IOrySAr (see VARARGIN)

% Choose default command line output for IOrySAr
handles.output = hObject;
A=[0,0;0,0];
axes(handles.mamori)
imshow(A),title 'Mamografía original'
axes(handles.mamsa)
imshow(A),title 'Mamografía sin artefactos'
axes(handles.mambg1)
imshow(A),title 'Todos los píxeles con información alguna'
axes(handles.mambgu)
imshow(A),title 'Eliminación del ruido'
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes IOrySAr wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = IOrySAr_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function g_Callback(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g as text
%        str2double(get(hObject,'String')) returns contents of g as a double
g=str2double(get(hObject,'String'));
set(handles.g, 'UserData',g);

% --- Executes during object creation, after setting all properties.
function g_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in examinar.
function examinar_Callback(hObject, eventdata, handles)
% hObject    handle to examinar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[im1,direc]=uigetfile({'*.pgm'});
examinar=strcat(direc,im1);
I=imread(examinar);
sizI=size(I);
sizI1=size(sizI);
if sizI1(2) ~= 2
    I=rgb2gray(I);                                                          %Si está en color
end
siz=size(I);   
if siz(1) > 1024                                                           
    I=imresize(I,[1024 siz(2)]); 
    siz(1)=1024;
end
if siz(2) > 1024
    I=imresize(I,[siz(1) 1024]);
    siz(2)=1024;
end
axes(handles.mamori);
imshow(I),title 'Mamografía original'
Ib1=im2bw(I,1/256);
axes(handles.mambg1);
imshow(Ib1),title 'Todos los píxeles con información alguna'
sizeI=size(I);
I=I(2:sizeI(1)-1,2:sizeI(2)-1);                                             %acá cambia a 1022*1022
save Imao I;
Ihist=imhist(I);
Ibg=imadjust(I,[],[],2);
Ibghist=imhist(Ibg);
for i=1:length(Ihist)
    if 0.003*max(Ihist) > Ibghist(i)
        umb=i;
        break
    end
end
Ibgb=im2bw(I,umb/256);
Ibgbf=bwareafilt(Ibgb,1);
axes(handles.mambgu)
imshow(Ibgbf),title 'Eliminación del ruido'
Ibgbfg=I.*uint8(Ibgbf);
axes(handles.mamsa)
imshow(Ibgbfg),title 'Mamografía sin artefactos'
save Ima Ibgbfg;
set(handles.mamori,'UserData',I);

% --- Executes on button press in Aceptar.
function Aceptar_Callback(hObject, eventdata, handles)
% hObject    handle to Aceptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g=get(handles.g,'UserData');
I=get(handles.mamori,'UserData');
sizeI=size(I);
Ihist=imhist(I);
Ibg=imadjust(I,[],[],g);
Ibghist=imhist(Ibg);
for i=1:length(Ihist)
    if 0.003*max(Ihist) > Ibghist(i)
        umb=i;
        break
    end
end
if umb < 3
    umb = 3;
end
Ibgb=im2bw(I,umb/256);
Ibgbf=bwareafilt(Ibgb,1);
axes(handles.mambgu)
imshow(Ibgbf),title 'Eliminación del ruido'
Ibgbfg=I.*uint8(Ibgbf);
axes(handles.mamsa)
imshow(Ibgbfg),title 'Mamografía sin artefactos'
save Ima Ibgbfg;


% --- Executes on button press in Siguiente.
function Siguiente_Callback(hObject, eventdata, handles)
% hObject    handle to Siguiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
B2orientacion1;
