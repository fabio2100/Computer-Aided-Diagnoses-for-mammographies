function varargout = Bordes(varargin)
% BORDES MATLAB code for Bordes.fig
%      BORDES, by itself, creates a new BORDES or raises the existing
%      singleton*.
%
%      H = BORDES returns the handle to a new BORDES or the handle to
%      the existing singleton*.
%
%      BORDES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BORDES.M with the given input arguments.
%
%      BORDES('Property','Value',...) creates a new BORDES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Bordes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Bordes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Bordes

% Last Modified by GUIDE v2.5 11-Apr-2018 11:55:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Bordes_OpeningFcn, ...
                   'gui_OutputFcn',  @Bordes_OutputFcn, ...
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


% --- Executes just before Bordes is made visible.
function Bordes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Bordes (see VARARGIN)

% Choose default command line output for Bordes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load Ima2;
I3=I2;
%if mean(I3(:,1)) ~= 0                          %Esto es para saltar la
%eliminación de bordes si no existen, pero lo voy a dejar asi
%    I4=I3;
%    nc=0;
%    save Ima3 I4 nc
%    handles.siguiente;
%end
siz=size(I3);
axes(handles.ori)
imshow(I3),title 'Mamografía elegida'
 for i=1:siz(1)
    nc=i;                                                                        %Si la orientación es izquierda, 
    if mean(I3(:,i)) ~=0
        sizI4=[siz(1) siz(2)-i];
        break
    end
 end
 for x=1:sizI4(1)%%%%%%
     for y=1:sizI4(2)
         I4(x,y)=I3(x,y+i);
     end
 end
axes(handles.sinbordes)
imshow(I4),title 'Sin bordes'
save Ima3 I4 nc


% UIWAIT makes Bordes wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Bordes_OutputFcn(hObject, eventdata, handles) 
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
close all
B2orientacion1;

% --- Executes on button press in siguiente.
function siguiente_Callback(hObject, eventdata, handles)
% hObject    handle to siguiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
contorno1;
