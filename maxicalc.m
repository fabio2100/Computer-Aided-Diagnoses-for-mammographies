function varargout = maxicalc(varargin)
% MAXICALC MATLAB code for maxicalc.fig
%      MAXICALC, by itself, creates a new MAXICALC or raises the existing
%      singleton*.
%
%      H = MAXICALC returns the handle to a new MAXICALC or the handle to
%      the existing singleton*.
%
%      MAXICALC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAXICALC.M with the given input arguments.
%
%      MAXICALC('Property','Value',...) creates a new MAXICALC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before maxicalc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to maxicalc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help maxicalc

% Last Modified by GUIDE v2.5 23-Jul-2018 02:15:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maxicalc_OpeningFcn, ...
                   'gui_OutputFcn',  @maxicalc_OutputFcn, ...
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


% --- Executes just before maxicalc is made visible.
function maxicalc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to maxicalc (see VARARGIN)

% Choose default command line output for maxicalc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes maxicalc wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load ima5
load info2

sizeinfo2=size(info2);
for i=1:sizeinfo2(1)
    mprecf=insertShape(mprecf,'Line',[info2(i,1)-10,info2(i,2)-10,info2(i,1)+10,info2(i,2)+10],'Color','g','LineWidth',5);
    mprecf=insertShape(mprecf,'Line',[info2(i,1)-10,info2(i,2)+10,info2(i,1)+10,info2(i,2)-10],'Color','g','LineWidth',5);
end
imshow(mprecf),title 'Ubicación de las calcificaciones'


% --- Outputs from this function are returned to the command line.
function varargout = maxicalc_OutputFcn(hObject, eventdata, handles) 
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
status=get(hObject,'Value');
load ima5
load coor
load vp
load info2
sizeinfo2=size(info2);
if status == 1
    load ima5
    for j=1:sizeinfo2(1)
        for i=1:sizeinfo2(1)
            if i==vp
                continue
            end
            mprecf=insertShape(mprecf,'Line',[info2(i,1)-10,info2(i,2)-10,info2(i,1)+10,info2(i,2)+10],'Color','g','LineWidth',5);
            mprecf=insertShape(mprecf,'Line',[info2(i,1)-10,info2(i,2)+10,info2(i,1)+10,info2(i,2)-10],'Color','g','LineWidth',5);
        end
    end
    mprecf=insertShape(mprecf,'Rectangle',[bx by bb bh],'Color','g','LineWidth',5);
    imshow(mprecf),title 'Ubicación de las calcificaciones'
else
    load ima5
    for i=1:sizeinfo2(1)
        mprecf=insertShape(mprecf,'Line',[info2(i,1)-10,info2(i,2)-10,info2(i,1)+10,info2(i,2)+10],'Color','g','LineWidth',5);
        mprecf=insertShape(mprecf,'Line',[info2(i,1)-10,info2(i,2)+10,info2(i,1)+10,info2(i,2)-10],'Color','g','LineWidth',5);
    end
    imshow(mprecf),title 'Ubicación de las calcificaciones'
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
close maxicalc
