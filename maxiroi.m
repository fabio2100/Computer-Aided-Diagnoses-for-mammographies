function varargout = maxiroi(varargin)
% MAXIROI MATLAB code for maxiroi.fig
%      MAXIROI, by itself, creates a new MAXIROI or raises the existing
%      singleton*.
%
%      H = MAXIROI returns the handle to a new MAXIROI or the handle to
%      the existing singleton*.
%
%      MAXIROI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAXIROI.M with the given input arguments.
%
%      MAXIROI('Property','Value',...) creates a new MAXIROI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before maxiroi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to maxiroi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help maxiroi

% Last Modified by GUIDE v2.5 23-Jul-2018 15:02:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @maxiroi_OpeningFcn, ...
                   'gui_OutputFcn',  @maxiroi_OutputFcn, ...
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


% --- Executes just before maxiroi is made visible.
function maxiroi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to maxiroi (see VARARGIN)

% Choose default command line output for maxiroi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load roi 
imshow(roi),title 'Región de interés'
mej_stat=0;
aj_stat=0;
save aj aj_stat
save mej mej_stat

% UIWAIT makes maxiroi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = maxiroi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ajus.
function ajus_Callback(hObject, eventdata, handles)
% hObject    handle to ajus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ajus
aj_stat=get(hObject,'Value');
load roi
load mej
if aj_stat == 1 && mej_stat == 0
    min_roi=double(min(min(roi)));
    max_roi=double(max(max(roi)));
    img=imadjust(roi,[min_roi/max_roi 1],[]);
    imshow(img),title 'ROI ajustada'
end
if aj_stat == 0 && mej_stat == 0
    img=roi;
    imshow(img),title 'Región de interés'
end
if aj_stat == 0 && mej_stat == 1
    th=imtophat(roi,strel('disk',10));
    tb=imbothat(roi,strel('disk',10));
    img=roi+th-tb;
    imshow(img),title 'ROI mejorada'
end
if aj_stat == 1 && mej_stat == 1
    min_roi=double(min(min(roi)));
    max_roi=double(max(max(roi)));
    img=imadjust(roi,[min_roi/max_roi 1],[]);
    th=imtophat(img,strel('disk',10));
    tb=imbothat(img,strel('disk',10));
    img2=img+th-tb;
    imshow(img2), title 'ROI ajustada y mejorada'
end
save aj aj_stat


% --- Executes on button press in mej.
function mej_Callback(hObject, eventdata, handles)
% hObject    handle to mej (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mej
mej_stat=get(hObject,'Value');
load roi
load aj
if aj_stat == 1 && mej_stat == 0
    min_roi=double(min(min(roi)));
    max_roi=double(max(max(roi)));
    img=imadjust(roi,[min_roi/max_roi 1],[]);
    imshow(img),title 'ROI ajustada'
end
if aj_stat == 0 && mej_stat == 0
    img=roi;
    imshow(img),title 'Región de interés'
end
if aj_stat == 0 && mej_stat == 1
    th=imtophat(roi,strel('disk',10));
    tb=imbothat(roi,strel('disk',10));
    img=roi+th-tb;
    imshow(img),title 'ROI mejorada'
end
if aj_stat == 1 && mej_stat == 1
    min_roi=double(min(min(roi)));
    max_roi=double(max(max(roi)));
    img=imadjust(roi,[min_roi/max_roi 1],[]);
    th=imtophat(img,strel('disk',10));
    tb=imbothat(img,strel('disk',10));
    img2=img+th-tb;
    imshow(img2), title 'ROI ajustada y mejorada'
end
save mej mej_stat

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
close
