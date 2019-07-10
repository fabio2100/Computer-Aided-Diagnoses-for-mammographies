
function varargout = anamanual(varargin)
% ANAMANUAL MATLAB code for anamanual.fig
%      ANAMANUAL, by itself, creates a new ANAMANUAL or raises the existing
%      singleton*.
%
%      H = ANAMANUAL returns the handle to a new ANAMANUAL or the handle to
%      the existing singleton*.
%
%      ANAMANUAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANAMANUAL.M with the given input arguments.
%
%      ANAMANUAL('Property','Value',...) creates a new ANAMANUAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before anamanual_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to anamanual_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help anamanual

% Last Modified by GUIDE v2.5 23-Jul-2018 16:01:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anamanual_OpeningFcn, ...
                   'gui_OutputFcn',  @anamanual_OutputFcn, ...
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


% --- Executes just before anamanual is made visible.
function anamanual_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to anamanual (see VARARGIN)

% Choose default command line output for anamanual
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes anamanual wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load ima5
sizemprecf=size(mprecf);
figure
imshow(mprecf),title 'Clickee en la región a analizar, luego presione enter'
[xv,yv]=ginput;
y=round(yv(length(yv)));
x=round(xv(length(xv)));
close
axes(handles.ori)
imshow(mprecf),title 'Original'
hold on
bx=x-20;
if bx < 1
    bx=1;
end
by=y-20;
if by < 1
    by=1;
end
bb=40;
if bb > sizemprecf(2)
    bb = sizemprecf(2);
end
bh=40;
if bh > sizemprecf(1)
    bh = sizemprecf(1);
end
rectangle('Position',[bx by bb bh],'EdgeColor','b','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save coor bx by bb bh
save vec y x 

    

% --- Outputs from this function are returned to the command line.
function varargout = anamanual_OutputFcn(hObject, eventdata, handles) 
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
close;
IL;


% --- Executes on button press in left_ag.
function left_ag_Callback(hObject, eventdata, handles)
% hObject    handle to left_ag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load coor
bx=bx-20;
bb=bb+20;
if bx < 1
    bx=1;
    bb=bb-20;
end
axes(handles.ori)
imshow(mprecf),title 'Original'
hold on
rectangle('Position',[bx by bb bh],'EdgeColor','b','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save coor bx by bb bh
save roi roi


% --- Executes on button press in left_ac.
function left_ac_Callback(hObject, eventdata, handles)
% hObject    handle to left_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load coor
load vec
bx=bx+20;
bb=bb-20;
if bx > x
    bx=x;
    bb=bb+20;
end
axes(handles.ori)
imshow(mprecf),title 'Original'
hold on
rectangle('Position',[bx by bb bh],'EdgeColor','b','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save coor bx by bb bh
save roi roi


% --- Executes on button press in rigth_ac.
function rigth_ac_Callback(hObject, eventdata, handles)
% hObject    handle to rigth_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load coor
load vec
bb=bb-20;
if bb + bx < x
    bb=20;
end
axes(handles.ori)
imshow(mprecf),title 'Original'
hold on
rectangle('Position',[bx by bb bh],'EdgeColor','b','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save coor bx by bb bh
save roi roi

% --- Executes on button press in rigth_ag.
function rigth_ag_Callback(hObject, eventdata, handles)
% hObject    handle to rigth_ag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vec
load coor
sizemprecf=size(mprecf);
bb=bb+20;
if bb > sizemprecf(2)
    bb=sizeinfo2(2)-x;
end
axes(handles.ori)
imshow(mprecf),title 'Original'
hold on
rectangle('Position',[bx by bb bh],'EdgeColor','b','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save coor bx by bb bh
save roi roi

% --- Executes on button press in inf_ac.
function inf_ac_Callback(hObject, eventdata, handles)
% hObject    handle to inf_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load coor
load vec
bh=bh-20;
if bh + by < y
    bh=20;
end
axes(handles.ori)
imshow(mprecf),title 'Original'
hold on
rectangle('Position',[bx by bb bh],'EdgeColor','b','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save coor bx by bb bh
save roi roi

% --- Executes on button press in inf_ag.
function inf_ag_Callback(hObject, eventdata, handles)
% hObject    handle to inf_ag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load coor
load vec
sizemprecf=size(mprecf);
bh=bh+20;
if bh > sizemprecf(1)
    bb=sizemprecf(1)-y;
end
axes(handles.ori)
imshow(mprecf),title 'Original'
hold on
rectangle('Position',[bx by bb bh],'EdgeColor','b','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save coor bx by bb bh
save roi roi

% --- Executes on button press in sup_ag.
function sup_ag_Callback(hObject, eventdata, handles)
% hObject    handle to sup_ag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vec
load coor
by=by-20;
bh=bh+20;
if by < 1
    by=1;
    bh=bh-20;
end
axes(handles.ori)
imshow(mprecf),title 'Original'
hold on
rectangle('Position',[bx by bb bh],'EdgeColor','b','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save coor bx by bb bh
save roi roi

% --- Executes on button press in sup_ac.
function sup_ac_Callback(hObject, eventdata, handles)
% hObject    handle to sup_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vec
load coor
by=by+20;
bh=bh-20;
if by > y
    by=y;
    bh=bh+20;
end
axes(handles.ori)
imshow(mprecf),title 'Original'
hold on
rectangle('Position',[bx by bb bh],'EdgeColor','b','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save coor bx by bb bh
save roi roi


% --- Executes on button press in maxi1.
function maxi1_Callback(hObject, eventdata, handles)
% hObject    handle to maxi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
maximanual;

% --- Executes on button press in maxi2.
function maxi2_Callback(hObject, eventdata, handles)
% hObject    handle to maxi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
maxiroi;
