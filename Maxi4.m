function varargout = Maxi4(varargin)
% MAXI4 MATLAB code for Maxi4.fig
%      MAXI4, by itself, creates a new MAXI4 or raises the existing
%      singleton*.
%
%      H = MAXI4 returns the handle to a new MAXI4 or the handle to
%      the existing singleton*.
%
%      MAXI4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAXI4.M with the given input arguments.
%
%      MAXI4('Property','Value',...) creates a new MAXI4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Maxi4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Maxi4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Maxi4

% Last Modified by GUIDE v2.5 09-Jun-2018 18:49:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Maxi4_OpeningFcn, ...
                   'gui_OutputFcn',  @Maxi4_OutputFcn, ...
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


% --- Executes just before Maxi4 is made visible.
function Maxi4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Maxi4 (see VARARGIN)

% Choose default command line output for Maxi4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Maxi4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load vp
load lpcf
load stats
load k 

j=k(vp);
Boundingbox=cat(1,stats.BoundingBox');
regbw=lpcf(Boundingbox(2,j):(Boundingbox(2,j)+Boundingbox(4,j)),(Boundingbox(1,j):(Boundingbox(1,j)+Boundingbox(3,j))));
regbw1=bwareafilt(regbw,1);
regbw1=imfill(regbw1,'holes');
axes(handles.axes1)
imshow(regbw1),title 'Región de interés'

% --- Outputs from this function are returned to the command line.
function varargout = Maxi4_OutputFcn(hObject, eventdata, handles) 
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
close Maxi4;

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

% --- Executes on button press in aceptar.
function aceptar_Callback(hObject, eventdata, handles)
% hObject    handle to aceptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load op
load vp
load lpcf
load stats
load k 
load ima5
switch op
    case 1
        j=k(vp);
        Boundingbox=cat(1,stats.BoundingBox');
        regbw=lpcf(Boundingbox(2,j):(Boundingbox(2,j)+Boundingbox(4,j)),(Boundingbox(1,j):(Boundingbox(1,j)+Boundingbox(3,j))));
        regbw1=bwareafilt(regbw,1);
        regbw1=imfill(regbw1,'holes');
        axes(handles.axes1)
        imshow(regbw1),title 'Región de interés'
%     case 2
%         mprecf2=double(mprecf);
%         j=k(vp);
%         centroid=cat(1,stats.Centroid);
%         Boundingbox=cat(1,stats.BoundingBox');
%         cx=round(centroid(j,1));
%         cy=round(centroid(j,2));
%         reg1=mprecf(round(Boundingbox(2,j)):round((Boundingbox(2,j))+round(Boundingbox(4,j))),round((Boundingbox(1,j)):round((Boundingbox(1,j))+round(Boundingbox(3,j)))));
%         regbw=lpcf(round(Boundingbox(2,j)):round((Boundingbox(2,j))+round(Boundingbox(4,j))),round((Boundingbox(1,j)):round((Boundingbox(1,j))+round(Boundingbox(3,j)))));
%         regbw1=(bwareafilt(regbw,1));
%         cxr=round(cx-Boundingbox(1,j));
%         cyr=round(cy-Boundingbox(2,j));
%         if regbw1(cyr,cxr)==0
%             [cxr,cyr,regbw1]=NuevoCentroide(regbw1,cxr,cyr);
%              cx=round(cxr+Boundingbox(1,j));
%              cy=round(cyr+Boundingbox(2,j));
%         end
%         regbw1=uint8(regbw1);
%         sreg=regbw1.*reg1;
%         sreg1=sreg(sreg~=0);
%         minreg=double(min(min(sreg1)));
%         max_reg=double(max(max(sreg1)));
%         dif_reg=max_reg-minreg;
%         rg=regiongrowing(mprecf2,cy,cx,dif_reg);
%         axes(handles.axes1)
%         imshow(rg),title 'Crecimiento de regiones'
    case 3
        j=k(vp);
        Boundingbox=cat(1,stats.BoundingBox');
        reg1=mprecf(round(Boundingbox(2,j)):round((Boundingbox(2,j))+round(Boundingbox(4,j))),round((Boundingbox(1,j)):round((Boundingbox(1,j))+round(Boundingbox(3,j)))));
        regbw=lpcf(round(Boundingbox(2,j)):round((Boundingbox(2,j))+round(Boundingbox(4,j))),round((Boundingbox(1,j)):round((Boundingbox(1,j))+round(Boundingbox(3,j)))));
        regbw1=uint8(bwareafilt(regbw,1));
        regbw1=imfill(regbw1,'holes');
        sreg=regbw1.*reg1;
        axes(handles.axes1)
        imshow(sreg),title 'ROI grises'
end

% --- Executes when selected object is changed in tipo.
function tipo_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in tipo 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if hObject == []
    op=1;
end
if hObject == handles.bin
    op=1;
end
% if hObject == handles.cr
%     op=2;
% end
if hObject == handles.gris
    op=3;
end
save op op
