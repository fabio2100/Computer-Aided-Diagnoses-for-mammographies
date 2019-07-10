function varargout = aexmp(varargin)
% AEXMP MATLAB code for aexmp.fig
%      AEXMP, by itself, creates a new AEXMP or raises the existing
%      singleton*.
%
%      H = AEXMP returns the handle to a new AEXMP or the handle to
%      the existing singleton*.
%
%      AEXMP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AEXMP.M with the given input arguments.
%
%      AEXMP('Property','Value',...) creates a new AEXMP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before aexmp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to aexmp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help aexmp

% Last Modified by GUIDE v2.5 16-Apr-2018 17:01:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @aexmp_OpeningFcn, ...
                   'gui_OutputFcn',  @aexmp_OutputFcn, ...
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


% --- Executes just before aexmp is made visible.
function aexmp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to aexmp (see VARARGIN)

% Choose default command line output for aexmp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load P
load Ima3
if PR == 0
    pr=sprintf('CC');
    set(handles.pro,'String',pr);
    spr=sprintf('Por lo tanto, el músculo pectoral no existe en la imagen');
    set(handles.ana,'String',spr);
    emp=0;
    emp1=0;
end
if PR == 1
    pr=sprintf('MLO');
    set(handles.pro,'String',pr);
    spr=sprintf('Métodos de análisis');
    set(handles.metodos,'String',spr);
    spr1=sprintf('Umbralización');
    set(handles.umbt,'String',spr1);
    spr2=sprintf('Por media');
    set(handles.medt,'String',spr2);
    %Eliminación de píxeles en negro en caso que la imagen esté algo rotada
    sizeI4=size(I4);
    for i=1:sizeI4(2)
        I4=I4(:,i:sizeI4(2));
        if I4(1,i) ~= 0
            break
        end
    end
    %Análisis por umbralización
    min25=double(min(min(I4(1:5,1:5))));
    I4b=imadjust(I4,[min25/256 1],[]);
    I4bbw=im2bw(I4b,1/256);
    se=strel('disk',10);
    I4bd=imdilate(I4bbw,se);
    I4bw=im2bw(I4,1/256);
    npI4bd=double(nnz(I4bd));
    npI4bw=double(nnz(I4bw));
    coef=npI4bd/npI4bw;
    emp=0;
    if coef > 0.55
        emp=1;
        mps=sprintf('El músculo pectoral no está visible');
        set(handles.umb,'String',mps);
    else
        mps=sprintf('El músculo pectoral está visible');
        set(handles.umb,'String',mps);
    end
    %Análisis por media
    I41=double(I4);
    min251=I41(1:5,1:5);
    min251m=mean2(min251);
    medtm=I41(I41~=0);
    medtm2=mean(medtm);
    coef1=min251m/medtm2;
    if coef1 < 1.1
        set(handles.med,'String','El músculo pectoral no está visible');
        emp1=0;
    else
        set(handles.med,'String','El músculo pectoral está visible');
        emp1=1;
    end
end
save em emp emp1



% UIWAIT makes aexmp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = aexmp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function pro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function ana_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ana (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in continuar.
function continuar_Callback(hObject, eventdata, handles)
% hObject    handle to continuar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load em
load ima3
compor=emp || emp1;
if compor == 1
    close 
    pext;
end
if compor == 0
    close all
    mprecf=I4;
    save Ima5 mprecf
    IL;
end

% --- Executes during object creation, after setting all properties.
function umb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function med_CreateFcn(hObject, eventdata, handles)
% hObject    handle to med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function metodos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metodos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function umbt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to umbt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function medt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to medt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
