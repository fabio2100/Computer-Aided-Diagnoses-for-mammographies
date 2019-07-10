function varargout = Mejoramiento(varargin)
% MEJORAMIENTO MATLAB code for Mejoramiento.fig
%      MEJORAMIENTO, by itself, creates a new MEJORAMIENTO or raises the existing
%      singleton*.
%
%      H = MEJORAMIENTO returns the handle to a new MEJORAMIENTO or the handle to
%      the existing singleton*.
%
%      MEJORAMIENTO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEJORAMIENTO.M with the given input arguments.
%
%      MEJORAMIENTO('Property','Value',...) creates a new MEJORAMIENTO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Mejoramiento_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Mejoramiento_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Mejoramiento

% Last Modified by GUIDE v2.5 25-May-2018 19:34:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Mejoramiento_OpeningFcn, ...
                   'gui_OutputFcn',  @Mejoramiento_OutputFcn, ...
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


% --- Executes just before Mejoramiento is made visible.
function Mejoramiento_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Mejoramiento (see VARARGIN)

% Choose default command line output for Mejoramiento
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load ima5;
op=5;
axes(handles.orig)
imshow(mprecf),title 'Original'
A=[0,0;0,0];
axes(handles.cm)
imshow(A),title 'Contraste mejorado'
save img_ori mprecf
save op op

% UIWAIT makes Mejoramiento wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Mejoramiento_OutputFcn(hObject, eventdata, handles) 
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
load op
load img_ori
switch op
    case 1
        max_mprecf=double(max(max(mprecf)));
        min_mprecf=double(min(min(mprecf)));
        immej=imadjust(mprecf,[min_mprecf/max_mprecf 1],[]);
    case 2
        he=histeq(mprecf);
        umb=double(min(min(he)));
        immej=imadjust(he,[umb/256 1],[]);
    case 3
        dmprecf=double(mprecf);
        [nf,nc]=size(dmprecf);
        dmprecf=dmprecf+1;
        ldmprecf=log(dmprecf);
        ff=fft2(ldmprecf);
        lowg=0.95;
        highg=1.05;
        dif=highg-lowg;
        sig=15;
        for i=1:nf
            for j=1:nc
                p=-(((i-(nf/2))^2+(j-(nc/2))^2)/(2*(sig^2)));
                k=(1/2*3.14*(sig^2));
                term(i,j)=(1-k*exp(p));
            end
        end
        for i=1:nf
            for j=1:nc
                h(i,j)=(dif*term(i,j))+lowg; 
            end
        end
        for i=1:nf
            for j=1:nc
                res(i,j)=ff(i,j)*h(i,j); 
            end
        end
        ifim=abs(ifft2(res));
        immej=uint8(exp(ifim));
    case 4
        immej2=mprecf;
        cte=1.5;
        sizemprecf=size(mprecf);
        umb=20;
        for i=2:sizemprecf(1)-1
            for j=2:sizemprecf(2)-1
                dvt=std2(double(mprecf(i-1:i+1,j-1:j+1)));
                if abs(double(mprecf(i,j)) - 100*double(dvt)) > umb
                    immej2(i,j)= double(mprecf(i,j)) * cte;
                end
            end
        end
        immej=uint8(immej2);
    case 5
        se=strel('disk',10);
        th=imtophat(mprecf,se);
        tb=imbothat(mprecf,se);
        immej=mprecf+th-tb;
    case 6
        se=strel('disk',150);
        th=imtophat(mprecf,se);
        tb=imbothat(mprecf,se);
        immej=mprecf+th-tb;
    case 7
        dmprecf=double(mprecf);
        [nf,nc]=size(dmprecf);
        dmprecf=dmprecf+1;
        ldmprecf=log(dmprecf);
        ff=fft2(ldmprecf);
        lowg=0.97;
        highg=1.02;
        dif=highg-lowg;
        sig=15;
        for i=1:nf
            for j=1:nc
                p=-(((i-(nf/2))^2+(j-(nc/2))^2)/(2*(sig^2)));
                k=(1/2*3.14*(sig^2));
                term(i,j)=(1-k*exp(p));
            end
        end
        for i=1:nf
            for j=1:nc
                h(i,j)=(dif*term(i,j))+lowg;
            end
        end
        for i=1:nf
            for j=1:nc
                res(i,j)=ff(i,j)*h(i,j);
            end
        end
        ifim=abs(ifft2(res));
        ffh=uint8(exp(ifim));
        se=strel('disk',15);
        th=imtophat(ffh,se);
        tb=imbothat(ffh,se);
        fthb=ffh+th-tb;
        immej2=fthb;
        cte=1.5;
        sizefthb=size(fthb);
        umb=20;
        for i=2:sizefthb(1)-1
            for j=2:sizefthb(2)-1
                dvt=std2(double(immej2(i-1:i+1,j-1:j+1)));
                if abs(double(immej2(i,j)) - double(dvt)) > umb
                    immej3(i,j)= double(immej2(i,j)) * cte;
                end
            end
        end
        immej=uint8(immej3);
    case 8
        immej=mprecf;
end
mprecf=immej;
save ima5 mprecf
axes(handles.cm)
imshow(immej),title 'Contraste mejorado'


% --- Executes when selected object is changed in metodo.
function metodo_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in metodo 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load op
if hObject == []
    op=5;
end
if hObject == handles.tl
    op=1;
end
if hObject == handles.ecu
    op=2;
end
if hObject == handles.fh
    op=3;
end
if hObject == handles.fa
    op=4;
end
if hObject == handles.th
    op=5;
end
if hObject == handles.th150
    op=6;
end
if hObject == handles.tc
    op=7;
end
if hObject == handles.original
    op=8;
end
save op op

% --- Executes on button press in atras.
function atras_Callback(hObject, eventdata, handles)
% hObject    handle to atras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IL;
close Mejoramiento;


% --- Executes on button press in siguiente.
function siguiente_Callback(hObject, eventdata, handles)
% hObject    handle to siguiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
anamanual;
close Mejoramiento;

% --- Executes on button press in auto.
function auto_Callback(hObject, eventdata, handles)
% hObject    handle to auto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
IL;
close Mejoramiento;
