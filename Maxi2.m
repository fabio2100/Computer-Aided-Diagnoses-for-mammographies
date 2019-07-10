function varargout = Maxi2(varargin)
% MAXI2 MATLAB code for Maxi2.fig
%      MAXI2, by itself, creates a new MAXI2 or raises the existing
%      singleton*.
%
%      H = MAXI2 returns the handle to a new MAXI2 or the handle to
%      the existing singleton*.
%
%      MAXI2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAXI2.M with the given input arguments.
%
%      MAXI2('Property','Value',...) creates a new MAXI2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Maxi2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Maxi2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Maxi2

% Last Modified by GUIDE v2.5 04-Jun-2018 13:22:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Maxi2_OpeningFcn, ...
                   'gui_OutputFcn',  @Maxi2_OutputFcn, ...
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


% --- Executes just before Maxi2 is made visible.
function Maxi2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Maxi2 (see VARARGIN)

% Choose default command line output for Maxi2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Maxi2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load lpcf
load ima6
load stats
load k
load vp
j=k(vp);
Boundingbox=cat(1,stats.BoundingBox');
bh=Boundingbox(4,j);                    %Afecta a y
bb=Boundingbox(3,j);                    %Afecta a x
bx=Boundingbox(1,j);
by=Boundingbox(2,j);
img=insertShape(ima,'Rectangle',[bx by bb bh],'Color','r','LineWidth',5);
axes(handles.axes1)
imshow(img),title 'Imagen'
est=[0 1];
save est est
save img img






% --- Outputs from this function are returned to the command line.
function varargout = Maxi2_OutputFcn(hObject, eventdata, handles) 
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
close Maxi2;

% --- Executes on button press in guardar.
function guardar_Callback(hObject, eventdata, handles)
% hObject    handle to guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guardar=getimage(handles.axes1);
if guardar==0
    return
end
if isempty(guardar)
    return
end
% guardar en formatos
formatos={'*.jpg','JPEG (*.jpg)';'*.png','PNG (*.png)';...
    '*.tif','TIFF (*.tif)';'*.gif','GIF (*.gif)';'*.pgm','PGM (*.pgm)'};
[nombre,ruta]=uiputfile(formatos,'GUARDAR IMAGEN');
if nombre==0
    return
end
fname=fullfile(ruta,nombre);
imwrite(guardar,fname)

% --- Executes on button press in recuadro.
function recuadro_Callback(hObject, eventdata, handles)
% hObject    handle to recuadro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of recuadro
load ima6
load lpcf
load k
load vp
load est
load stats
j=k(vp);
Boundingbox=cat(1,stats.BoundingBox');
bh=Boundingbox(4,j);                    %Afecta a y
bb=Boundingbox(3,j);                    %Afecta a x
bx=Boundingbox(1,j);
by=Boundingbox(2,j);
est(2)=get(hObject,'Value');
if (est(1)==1 && est(2)==1)
    lpcf1=uint8(lpcf);
    lpcf1=imadjust(lpcf1,[0 1/256],[]);
    img=insertShape(lpcf1,'Rectangle',[bx by bb bh],'Color','r','LineWidth',5);
    axes(handles.axes1)
    imshow(img),title 'Imagen'
end
if (est(1)==0 && est(2)==1)
    img=insertShape(ima,'Rectangle',[bx by bb bh],'Color','r','LineWidth',5);
    axes(handles.axes1)
    imshow(img),title 'Imagen'
end
if (est(1)==1 && est(2)==0)
    img=lpcf;
    axes(handles.axes1)
    imshow(img),title 'Imagen'
end
if (est(1)==0 && est(2)==0)
    img=ima;
    axes(handles.axes1)
    imshow(img),title 'Imagen'
end
save img img
save est est

% --- Executes on button press in aceptar.
function aceptar_Callback(hObject, eventdata, handles)
% hObject    handle to aceptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load lpcf
load est
load ima6
load lpcf
load k
load vp
load stats
j=k(vp);
Boundingbox=cat(1,stats.BoundingBox');
bh=Boundingbox(4,j);                    %Afecta a y
bb=Boundingbox(3,j);                    %Afecta a x
bx=Boundingbox(1,j);
by=Boundingbox(2,j);
if (est(1)==1 && est(2)==1)
    lpcf1=uint8(lpcf);
    lpcf1=imadjust(lpcf1,[0 1/256],[]);
    img=insertShape(lpcf1,'Rectangle',[bx by bb bh],'Color','r','LineWidth',5);
    axes(handles.axes1)
    imshow(img),title 'Imagen'
end
if (est(1)==0 && est(2)==1)
    img=insertShape(ima,'Rectangle',[bx by bb bh],'Color','r','LineWidth',5);
    axes(handles.axes1)
    imshow(img),title 'Imagen'
end
if (est(1)==1 && est(2)==0)
    img=lpcf;
    axes(handles.axes1)
    imshow(img),title 'Imagen'
end
if (est(1)==0 && est(2)==0)
    img=ima;
    axes(handles.axes1)
    imshow(img),title 'Imagen'
end
save img img
save est est

        

% --- Executes when selected object is changed in tipo.
function tipo_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in tipo 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load est
if hObject == []
    est(1)=0;
end
if hObject == handles.grises
    est(1)=0;
end
if hObject == handles.byn
    est(1)=1;
end
save est est
