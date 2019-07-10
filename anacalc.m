function varargout = anacalc(varargin)
% ANACALC MATLAB code for anacalc.fig
%      ANACALC, by itself, creates a new ANACALC or raises the existing
%      singleton*.
%
%      H = ANACALC returns the handle to a new ANACALC or the handle to
%      the existing singleton*.
%
%      ANACALC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ANACALC.M with the given input arguments.
%
%      ANACALC('Property','Value',...) creates a new ANACALC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before anacalc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to anacalc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help anacalc

% Last Modified by GUIDE v2.5 23-Jul-2018 15:02:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @anacalc_OpeningFcn, ...
                   'gui_OutputFcn',  @anacalc_OutputFcn, ...
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


% --- Executes just before anacalc is made visible.
function anacalc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to anacalc (see VARARGIN)

% Choose default command line output for anacalc
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes anacalc wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load ima5
load info2
sizeinfo2=size(info2);
sizemprecf=size(mprecf);
%Usamos el cuadro con la cantidad de ucs encontradas
tot=sizeinfo2(1);
set(handles.numcalc,'String',tot);
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=2:sizeinfo2(1)
    plot(info2(i,1),info2(i,2),'xg')
end
vp=1;
bx=info2(1,1)-20;
if bx < 1
    bx=1;
end
by=info2(1,2)-20;
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
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi
    

% --- Outputs from this function are returned to the command line.
function varargout = anacalc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ant.
function ant_Callback(hObject, eventdata, handles)
% hObject    handle to ant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vp
load info2
sizemprecf=size(mprecf);
sizeinfo2=size(info2);
vp=vp-1;
if vp < 1
    vp=1;
end
bx=info2(vp,1)-20;
if bx < 1
    bx=1;
end
by=info2(vp,2)-20;
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
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi


% --- Executes on button press in sig.
function sig_Callback(hObject, eventdata, handles)
% hObject    handle to sig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vp
load info2
sizemprecf=size(mprecf);
sizeinfo2=size(info2);
vp=vp+1;
if vp > sizeinfo2(1)
    vp=sizeinfo2(1);
end
bx=info2(vp,1)-20;
if bx < 1
    bx=1;
end
by=info2(vp,2)-20;
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
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi



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
load vp
load info2
load coor
sizeinfo2=size(info2);
bx=bx-20;
bb=bb+20;
if bx < 1
    bx=1;
    bb=bb-20;
end
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi


% --- Executes on button press in left_ac.
function left_ac_Callback(hObject, eventdata, handles)
% hObject    handle to left_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vp
load info2
load coor
sizeinfo2=size(info2);
bx=bx+20;
bb=bb-20;
if bx > info2(vp,1)
    bx=info2(vp,1);
    bb=bb+20;
end
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi


% --- Executes on button press in rigth_ac.
function rigth_ac_Callback(hObject, eventdata, handles)
% hObject    handle to rigth_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vp
load info2
load coor
sizeinfo2=size(info2);
bb=bb-20;
if bb + bx < info2(vp,1)
    bb=20;
end
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi

% --- Executes on button press in rigth_ag.
function rigth_ag_Callback(hObject, eventdata, handles)
% hObject    handle to rigth_ag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vp
load info2
load coor
sizeinfo2=size(info2);
sizemprecf=size(mprecf);
bb=bb+20;
if bb > sizemprecf(2)
    bb=sizeinfo2(2)-info2(vp,1);
end
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi

% --- Executes on button press in inf_ac.
function inf_ac_Callback(hObject, eventdata, handles)
% hObject    handle to inf_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vp
load info2
load coor
sizeinfo2=size(info2);
bh=bh-20;
if bh + by < info2(vp,2)
    bh=20;
end
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi

% --- Executes on button press in inf_ag.
function inf_ag_Callback(hObject, eventdata, handles)
% hObject    handle to inf_ag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vp
load info2
load coor
sizeinfo2=size(info2);
sizemprecf=size(mprecf);
bh=bh+20;
if bh > sizemprecf(1)
    bb=sizeinfo2(1)-info2(vp,2);
end
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi

% --- Executes on button press in sup_ag.
function sup_ag_Callback(hObject, eventdata, handles)
% hObject    handle to sup_ag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vp
load info2
load coor
sizeinfo2=size(info2);
by=by-20;
bh=bh+20;
if by < 1
    by=1;
    bh=bh-20;
end
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi

% --- Executes on button press in sup_ac.
function sup_ac_Callback(hObject, eventdata, handles)
% hObject    handle to sup_ac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load ima5
load vp
load info2
load coor
sizeinfo2=size(info2);
by=by+20;
bh=bh-20;
if by > info2(vp,2)
    by=info2(vp,2);
    bh=bh+20;
end
axes(handles.ori)
imshow(mprecf),title 'Ubicación de las calcificaciones'
hold on
for i=1:sizeinfo2(1)
    if i==vp
        continue
    end
    plot(info2(i,1),info2(i,2),'xg')
end
rectangle('Position',[bx by bb bh],'EdgeColor','g','LineWidth',2)
roi=mprecf(by:by+bh,bx:bx+bb);
axes(handles.roi)
imshow(roi)
save vp vp
save coor bx by bb bh
save roi roi


% --- Executes on button press in maxi1.
function maxi1_Callback(hObject, eventdata, handles)
% hObject    handle to maxi1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
maxicalc;

% --- Executes on button press in maxi2.
function maxi2_Callback(hObject, eventdata, handles)
% hObject    handle to maxi2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
maxiroi;
