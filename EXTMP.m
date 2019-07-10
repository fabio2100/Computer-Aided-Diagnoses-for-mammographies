function varargout = EXTMP(varargin)
% EXTMP MATLAB code for EXTMP.fig
%      EXTMP, by itself, creates a new EXTMP or raises the existing
%      singleton*.
%
%      H = EXTMP returns the handle to a new EXTMP or the handle to
%      the existing singleton*.
%
%      EXTMP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTMP.M with the given input arguments.
%
%      EXTMP('Property','Value',...) creates a new EXTMP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EXTMP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EXTMP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EXTMP

% Last Modified by GUIDE v2.5 11-Jul-2018 03:51:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EXTMP_OpeningFcn, ...
                   'gui_OutputFcn',  @EXTMP_OutputFcn, ...
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


% --- Executes just before EXTMP is made visible.
function EXTMP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EXTMP (see VARARGIN)

% Choose default command line output for EXTMP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load Ima4;
axes(handles.roi)
imshow(Icor),title 'ROI'
A=[0,0;0,0;0,0;0,0;0,0];
axes(handles.iroi)
imshow(A),title 'Binarizada'
A1=[0,0;0,0];
axes(handles.smp)
imshow(A1),title 'Sin músculo pectoral'

% UIWAIT makes EXTMP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EXTMP_OutputFcn(hObject, eventdata, handles) 
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
close
ROIMP;


% --- Executes on button press in siguiente.
function siguiente_Callback(hObject, eventdata, handles)
% hObject    handle to siguiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
IL;


% --- Executes on button press in aceptar.
function aceptar_Callback(hObject, eventdata, handles)
% hObject    handle to aceptar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load Ima4;
load estado
if estado == 1
    load ima4p
    I4=I4p;
    Icor=Icorp;
end
global op;
switch op
    case 1
        cont=0;
        I41=imadjust(I4,[],[0 4/256]);
        u11=double(I41(1,1));
        I41b=im2bw(I41,u11/256);
        I41bm=bwareafilt(I41b,1);
%         for i=1:1000
%             if I41bm(1,1) == 0
%                 I41bm=I41b-I41bm;
%                 I41bm=im2bw(I41bm,1/256);
%                 I41bm=bwareafilt(I41bm,1);
%                 continue
%             end
%         end
        while I41bm(1,1)==0
            I41bm=I41b-I41bm;
            I41bm=im2bw(I41bm,1/256);
            I41bm=bwareafilt(I41bm,1);
            cont=cont+1;
            if cont>10000
                break
            end
        end
        if cont > 10000
            nomp;
        end   
        I41bm=uint8(I41bm);
        I41bmi=1-I41bm;
        mprecf=I4 .* I41bmi;
        mprecf2=im2bw(mprecf,1/256);
        mprecf3=bwareafilt(mprecf2,1);
        mprecf3=uint8(mprecf3);
        mprecf4=mprecf3 .* I4;
        axes(handles.smp)
        imshow(mprecf4),title 'Sin el músculo pectoral'
        axes(handles.iroi)
        imshow([0 0;0 0;0 0;0 0]),title 'Binarizada (sin uso)'
        save Ima5 mprecf
    case 2
        cont=0;
        b=imadjust(Icor,[],[0 2/256],4);
        c1=im2bw(b,1/256);
        c=bwareafilt(c1,1);
%         for i=1:1000
%             if c(1,1)==0
%                 c=c1-c;
%                 c=im2bw(c,1/256);
%                 c=bwareafilt(c,1);
%                 continue
%             end
%         end
        while c(1,1)==0
            c=c1-c;
            c=im2bw(c,1/256);
            c=bwareafilt(c1,1);
            cont=cont+1;
            if cont>10000
                break
            end
        end
        axes(handles.iroi)
        imshow(c),title 'Binarizada'
        sizI4=size(I4);
        sizIcor=size(Icor);
        corc=sizIcor(2);
        corf=sizIcor(1);
        grand=zeros(sizI4(1),sizI4(2)-corc);
        chic=zeros(sizI4(1)-corf,corc);
        mprec=[c;chic];
        mprec2=[mprec,grand];
        mprec2i=1-mprec2;
        mprec2i=uint8(mprec2i);
        mprecf=mprec2i .* I4;
        mprecf=im2bw(mprecf,1/256);
        mprecf=bwareafilt(mprecf,1);
        mprecf= uint8(mprecf);
        mprecf= mprecf .* I4;
        axes(handles.smp)
        imshow(mprecf),title 'Sin el músculo pectoral'
        save Ima5 mprecf
    case 3
        cont=0;
        [c,s]=wavedec2(Icor,1,'db2');
        med=mean(c(1:length(c)/4))*1.12;
        for i=1:length(c)
            if c(i) < med
                c(i) = 0;
            end 
        end
        mp=waverec2(c,s,'db2');
        mp2=im2bw(mp,1/256);
        mp3=bwareafilt(mp2,1);
        while mp3(1,1) == 0
            mp3=mp2-mp3;
            mp3=im2bw(mp3,1/256);
            mp3=bwareafilt(mp3,1);
            cont=cont+1;
            if cont > 10000
                break
            end
        end
        if cont>10000
            nomp;
        end
        sizI4=size(I4);
        sizIcor=size(Icor);
        corc=sizIcor(2);
        corf=sizIcor(1);
        grand=zeros(sizI4(1),sizI4(2)-corc);
        chic=zeros(sizI4(1)-corf,corc);
        mprec=[mp3;chic];
        mprec2=[mprec,grand];
        mprec2=uint8(mprec2);
        mprec2i=1-mprec2;
        mprecf= mprec2i .* I4;
        mprecf=im2bw(mprecf,1/256);
        mprecf=bwareafilt(mprecf,1);
        mprecf=uint8(mprecf);
        mprecf= mprecf .* I4;
        axes(handles.smp)
        imshow(mprecf),title 'Sin el músculo pectoral'
        axes(handles.iroi)
        imshow(mp2),title 'Binarizada'
        save Ima5 mprecf
    case 4
        a1=reshape(Icor,[],1);
        a1=double(a1);
        [idx,nn]=kmeans(a1,2);
        ima = reshape(idx,size(Icor));
        if ima(1,1) == 1
            mp3=2-ima;
        else
            mp3=ima-1;
        end
        mp3=im2bw(mp3,1/256);
        mp3=bwareafilt(mp3,1);
        sizI4=size(I4);
        sizIcor=size(Icor);
        corc=sizIcor(2);
        corf=sizIcor(1);
        grand=zeros(sizI4(1),sizI4(2)-corc);
        chic=zeros(sizI4(1)-corf,corc);
        mprec=[mp3;chic];
        mprec2=[mprec,grand];
        mprec2=uint8(mprec2);
        mprec2i=1-mprec2;
        mprecf= mprec2i .* I4;
        mprecf=im2bw(mprecf,1/256);
        mprecf=bwareafilt(mprecf,1);
        mprecf=uint8(mprecf);
        mprecf= mprecf .* I4;
        axes(handles.smp)
        imshow(mprecf),title 'Sin el músculo pectoral'
        axes(handles.iroi)
        imshow(mp3),title 'Binarizada'
        save Ima5 mprecf
    case 5
        cont=0;
        a1=reshape(Icor,[],1);
        med=double(median(a1));
        b=imadjust(Icor,[med/256 1],[]);
        c=im2bw(b,1/256);
        mp3=bwareafilt(c,1);
        while mp3(1,1) == 0
            mp3=c-mp3;
            mp3=im2bw(mp3,1/256);
            mp3=bwareafilt(mp3,1);
            cont=cont+1;
            if cont > 10000
                break
            end
        end
        if cont>10000
            nomp;
        end
        sizI4=size(I4);
        sizIcor=size(Icor);
        corc=sizIcor(2);
        corf=sizIcor(1);
        grand=zeros(sizI4(1),sizI4(2)-corc);
        chic=zeros(sizI4(1)-corf,corc);
        mprec=[mp3;chic];
        mprec2=[mprec,grand];
        mprec2=uint8(mprec2);
        mprec2i=1-mprec2;
        mprecf= mprec2i .* I4;
        mprecf=im2bw(mprecf,1/256);
        mprecf=bwareafilt(mprecf,1);
        mprecf=uint8(mprecf);
        mprecf= mprecf .* I4;
        axes(handles.smp)
        imshow(mprecf),title 'Sin el músculo pectoral'
        axes(handles.iroi)
        imshow(mp3),title 'Binarizada'
        save Ima5 mprecf
    case 6
        lmpreci=regiongrowing(double(I4),1,1,20);
        mpreclog=im2bw(I4,1/256);
        mprecbw=mpreclog-lmpreci;
        mprecbw=bwareafilt(logical(mprecbw),1);
        mprecf=uint8(mprecbw).*I4;
        axes(handles.smp)
        imshow(mprecf),title 'Sin el músculo pectoral'
        axes(handles.iroi)
        imshow([0 0;0 0;0 0;0 0]),title 'Binarizada(sin uso)'
        save Ima5 mprecf
end


% --- Executes when selected object is changed in metodo.
function metodo_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in metodo 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global op;
if hObject == []
    op=1;
end
if hObject == handles.umba
    op=1;
end
if hObject == handles.umbr
    op=2;
end
if hObject == handles.tw
    op=3;
end
if hObject == handles.km
    op=4;
end
if hObject == handles.mediana
    op=5;
end
if hObject == handles.cr1
    op=6;
end


% --- Executes on button press in pond.
function pond_Callback(hObject, eventdata, handles)
% hObject    handle to pond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pond
estado=get(hObject,'Value');
load ima4
if estado == 1 
   sizeIcor=size(Icor);
   sizeI4=size(I4);
   I4p=zeros(sizeI4);
   Icorp=zeros(sizeIcor);
   for y=1:sizeIcor(1)
       for x=1:sizeIcor(2)
          Icorp(y,x)=Icor(y,x)/((log(x+y-1))+1);
       end
   end
   for y=1:sizeI4(1)
       for x=1:sizeI4(2)
           I4p(y,x)=I4(y,x)/((log(x+y-1))+1);
       end
   end
   Icorp=uint8(Icorp);
   I4p=uint8(I4p);
   save Ima4p Icorp I4p
end
if estado == 0
    I4=I4;
    Icor=Icor;
end

save Ima4 Icor I4
save estado estado