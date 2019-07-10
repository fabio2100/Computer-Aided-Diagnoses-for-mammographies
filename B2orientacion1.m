
function varargout = B2orientacion1(varargin)
% B2ORIENTACION1 MATLAB code for B2orientacion1.fig
%      B2ORIENTACION1, by itself, creates a new B2ORIENTACION1 or raises the existing
%      singleton*.
%
%      H = B2ORIENTACION1 returns the handle to a new B2ORIENTACION1 or the handle to
%      the existing singleton*.
%
%      B2ORIENTACION1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in B2ORIENTACION1.M with the given input arguments.
%
%      B2ORIENTACION1('Property','Value',...) creates a new B2ORIENTACION1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before B2orientacion1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to B2orientacion1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help B2orientacion1

% Last Modified by GUIDE v2.5 12-Apr-2018 10:28:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @B2orientacion1_OpeningFcn, ...
                   'gui_OutputFcn',  @B2orientacion1_OutputFcn, ...
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


% --- Executes just before B2orientacion1 is made visible.
function B2orientacion1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to B2orientacion1 (see VARARGIN)

% Choose default command line output for B2orientacion1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load Ima;
I2=Ibgbfg;
axes(handles.orig);
imshow(I2),title 'Mamografía elegida'
siz=size(I2);
izq=[];                                                                     %Para determinar la orientación: Se crea un lazo FOR IF donde se busca columna a columna hasta encontrar un valor distinto de 0
for i=2:siz(1)                                                              %Dicho proceso se realiza desde el lado derecho e izquierdo
    if mean(I2(:,i)) ~=0                                                    %Una vez encontrada las primeras columnas, tanto del lado derecho como izquierdo cuya media sea distinta de 0:
        izq = i + 5;                                                                  %A ambas se las 'interioriza' 5 (arbitrario) columnas más y se compara las medias de esas columnas
        break                                                               %La mayor de las dos determina la orientación de la mama
    end
end

der=[];
for i=siz(1)-1:-1:1
    if mean(I2(:,i)) ~=0
        der = i - 5;
        break
    end
end
%Determinación de la proyección
ci=I2(1:3,izq);
cd=I2(1:3,der);
if ci == 0
    cic=1;
else
    cic=0;
end

if cd == 0
    cdc=1;
else
    cdc=0;
end

if (cic && cdc) == 1
    P=sprintf('CC');
    PR=0;
    set(handles.proy,'String',P);
else
    P=sprintf('MLO');
    PR=1;
    set(handles.proy,'String',P);
end
save P PR;
%Determinación de orientación y colocación hacia la izquierda si
%corresponde
pizq=mean(I2(:,izq));
pder=mean(I2(:,der));

if pizq > pder
    O=0;
    A=sprintf('Izquierda');
    set(handles.ori,'String',A);
else
    O=1;
    A=sprintf('Derecha');
    set(handles.ori,'String',A);
end
if O==1
    I2=fliplr(I2);
    load Imao;
    I=fliplr(I);
    save Imao I;
    O=0;
end
axes(handles.hizq)
imshow(I2),title 'Orientada hacia izquieda'
save Ima2 I2;
set(handles.siguiente,'UserData',I2);



% UIWAIT makes B2orientacion1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = B2orientacion1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function ori_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ori (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called




% --- Executes on button press in siguiente.
function siguiente_Callback(hObject, eventdata, handles)
% hObject    handle to siguiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
Bordes;


% --- Executes on button press in atras.
function atras_Callback(hObject, eventdata, handles)
% hObject    handle to atras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all
IOrySAr;


% --- Executes during object creation, after setting all properties.
function proy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to proy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
