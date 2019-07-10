function varargout = Maxi3(varargin)
% MAXI3 MATLAB code for Maxi3.fig
%      MAXI3, by itself, creates a new MAXI3 or raises the existing
%      singleton*.
%
%      H = MAXI3 returns the handle to a new MAXI3 or the handle to
%      the existing singleton*.
%
%      MAXI3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAXI3.M with the given input arguments.
%
%      MAXI3('Property','Value',...) creates a new MAXI3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Maxi3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Maxi3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Maxi3

% Last Modified by GUIDE v2.5 01-Jun-2018 17:53:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Maxi3_OpeningFcn, ...
                   'gui_OutputFcn',  @Maxi3_OutputFcn, ...
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


% --- Executes just before Maxi3 is made visible.
function Maxi3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Maxi3 (see VARARGIN)

% Choose default command line output for Maxi3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load ima5
load vp
load Boundingbox
load n
load k
load totk
global mprecf mprecf2
c=k(vp);
bh=Boundingbox(4,c);                    %Afecta a y
bb=Boundingbox(3,c);                    %Afecta a x
bx=Boundingbox(1,c);
by=Boundingbox(2,c);
mprecf2=insertShape(mprecf,'Rectangle',[bx by bb bh],'Color','r','LineWidth',5);
axes(handles.axes1)
imshow(mprecf2),title 'Ubicación de la masa'
% imshow(mprecf),title 'Ubicación de la masa'
% hold on
% rectangle('Position',[bx by bb bh],'EdgeColor','r','LineWidth',3)
% hold on



% UIWAIT makes Maxi3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Maxi3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in guardar.
function guardar_Callback(hObject, eventdata, handles)
% hObject    handle to guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guardar=getimage(handles.axes1);
%guardar=guardar.cdata;
if guardar==0
    return
end
if isempty(guardar)
    return
end
% guardar en formatos
formatos={'*.jpg','JPEG (*.jpg)';'*.png','PNG (*.png)';...
    '*.tif','TIFF (*.tif)';'*.gif','GIF (*.gif)'};
[nombre,ruta]=uiputfile(formatos,'GUARDAR IMAGEN');
if nombre==0
    return
end
fname=fullfile(ruta,nombre);
imwrite(guardar,fname)


% --- Executes on button press in atras.
function atras_Callback(hObject, eventdata, handles)
% hObject    handle to atras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close Maxi1;


% --- Executes on button press in rec.
function rec_Callback(hObject, eventdata, handles)
% hObject    handle to rec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rec
sta=get(hObject,'Value');
global mprecf mprecf2
if sta == 1
    axes(handles.axes1)
    imshow(mprecf2),title 'Original'
else
    axes(handles.axes1)
    imshow(mprecf),title 'Original'
end
