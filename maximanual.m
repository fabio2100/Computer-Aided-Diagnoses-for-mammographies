function varargout = maximanual(varargin)
% MAXIMANUAL MATLAB code for maximanual.fig
%      MAXIMANUAL, by itself, creates a new MAXIMANUAL or raises the existing
%      singleton*.
%
%      H = MAXIMANUAL returns the handle to a new MAXIMANUAL or the handle to
%      the existing singleton*.
%
%      MAXIMANUAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAXIMANUAL.M with the given input arguments.
%
%      MAXIMANUAL('Property','Value',...) creates a new MAXIMANUAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before maximanual_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to maximanual_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help maximanual

% Last Modified by GUIDE v2.5 23-Jul-2018 18:01:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maximanual_OpeningFcn, ...
                   'gui_OutputFcn',  @maximanual_OutputFcn, ...
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


% --- Executes just before maximanual is made visible.
function maximanual_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to maximanual (see VARARGIN)

% Choose default command line output for maximanual
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes maximanual wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load ima5
load coor
mprecf2=insertShape(mprecf,'Rectangle',[bx by bb bh],'Color','blue','LineWidth',5);
imshow(mprecf2),title 'Imagen'

% --- Outputs from this function are returned to the command line.
function varargout = maximanual_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cuadro.
function cuadro_Callback(hObject, eventdata, handles)
% hObject    handle to cuadro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cuadro
stat=get(hObject,'Value');
load ima5
load coor
if stat == 1
    mprecf2=insertShape(mprecf,'Rectangle',[bx by bb bh],'Color','blue','LineWidth',5);
    imshow(mprecf2),title 'Imagen'
else
    imshow(mprecf),title 'Imagen'
end

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
close maximanual
