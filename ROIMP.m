function varargout = ROIMP(varargin)
% ROIMP MATLAB code for ROIMP.fig
%      ROIMP, by itself, creates a new ROIMP or raises the existing
%      singleton*.
%
%      H = ROIMP returns the handle to a new ROIMP or the handle to
%      the existing singleton*.
%
%      ROIMP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROIMP.M with the given input arguments.
%
%      ROIMP('Property','Value',...) creates a new ROIMP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ROIMP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ROIMP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ROIMP

% Last Modified by GUIDE v2.5 18-Apr-2018 17:29:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ROIMP_OpeningFcn, ...
                   'gui_OutputFcn',  @ROIMP_OutputFcn, ...
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


% --- Executes just before ROIMP is made visible.
function ROIMP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ROIMP (see VARARGIN)

% Choose default command line output for ROIMP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load ima3;
axes(handles.imag)
imshow(I4),title 'Mamografía'
hold 
A=[0,0;0,0;0,0;0,0];
axes(handles.iroi)
imshow(A),title 'ROI del músculo pectoral'

% UIWAIT makes ROIMP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ROIMP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in aceptar.
function aceptar_Callback(hObject, eventdata, handles)
% hObject    handle to aceptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima3;
global op;
switch op
    case 1
        figure
        imshow(I4),title 'Clickee una vez delimitada la ROI, luego presione enter'
        [corcv,corfv]=ginput;
        corc=corcv(length(corcv));
        corf=corfv(length(corfv));
        close
    case 2
        f1=I4(1,:);
        c1=I4(:,1);
        for i=1:length(f1)
            corc=i;
            if f1(i) < 0.5*max(f1)
                break
            end
        end
        for i=1:length(c1)
            corf=i;
            if c1(i) < 0.5*max(c1)
                break
            end
        end
    case 3
        f2=double(I4(2,:));
        c2=double(I4(:,2));
        f2=f2(f2~=0);
        c2=c2(c2~=0);
        f2(1:10)=0;
        c2(1:10)=0;
        f2=f2(f2~=0);
        c2=c2(c2~=0);
        gf2=abs(gradient(f2));
        gc2=abs(gradient(c2));
        corc=find(gf2==max(gf2))+10;
        corf=find(gc2==max(gc2))+10;
        corc=corc(length(corc));
        corf=corf(length(corf));
end
Icor=I4(1:corf,1:corc);
axes(handles.iroi)
imshow(Icor),title 'ROI del músculo pectoral'
axes(handles.imag)
cla reset
imshow(I4),title 'ROI en la mamografía'
rectangle('Position',[1 1 corc corf-1],'EdgeColor','r','LineWidth',3)
save Ima4 I4 Icor


% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
if hObject == []
    op=1;
end
if hObject == handles.manual
    op=1;
end
if hObject == handles.fc
    op=2;
end
if hObject == handles.grad
    op=3;
end


% --- Executes on button press in atras.
function atras_Callback(hObject, eventdata, handles)
% hObject    handle to atras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close 
Bordes;


% --- Executes on button press in siguiente.
function siguiente_Callback(hObject, eventdata, handles)
% hObject    handle to siguiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close 
EXTMP;