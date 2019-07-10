function varargout = detmasas(varargin)
% DETMASAS MATLAB code for detmasas.fig
%      DETMASAS, by itself, creates a new DETMASAS or raises the existing
%      singleton*.
%
%      H = DETMASAS returns the handle to a new DETMASAS or the handle to
%      the existing singleton*.
%
%      DETMASAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DETMASAS.M with the given input arguments.
%
%      DETMASAS('Property','Value',...) creates a new DETMASAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before detmasas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to detmasas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help detmasas

% Last Modified by GUIDE v2.5 28-May-2018 15:19:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @detmasas_OpeningFcn, ...
                   'gui_OutputFcn',  @detmasas_OutputFcn, ...
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


% --- Executes just before detmasas is made visible.
function detmasas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to detmasas (see VARARGIN)

% Choose default command line output for detmasas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load ima5
%load tf1
axes(handles.orig)
imshow(mprecf),title 'Original'

a1=double(mprecf(:));
for j=3:15
    [idx,nn]=kmeans(a1,j);
    %Implementamos una técnica para realizar de manera automática la cantidad
    %de niveles de grises a mostrar analizando las superficies ocupadas por
    %cada nivel de gris.
    cont=[];
    for i=1:j
        cont(i)=numel(idx(idx==i));
    end
    m1=find(cont==max(cont));
    cont(m1)=0;
    m2=max(cont);
    total_pix=sum(cont);
    if m2 < 0.33 * total_pix
        break
    end
end

ima1=uint8(reshape(idx,size(mprecf)));
m=double(max(max(ima1)));
ima=imadjust(ima1,[0 m/256],[]);
axes(handles.masas)
imshow(ima),title 'Masas'
save ima6 ima ima1
set(handles.clus,'String',j);
% e=edge(ima,'Canny');
% sizee=size(e);
% for x=4:sizee(1)-3
%     for y=4:sizee(2)-3
%         v(x,y)=0;
%         if sum(sum(double(e(x-3:x+3,y-3:y+3))))>0
%             v(x,y)=1;
%         end
%     end
% end
% v=logical(v);
% v=imresize(v,[sizee(1) sizee(2)]);
% vi=imcomplement(v);
% save v v
%Entropía
% % en=(entropyfilt(mprecf));
% % maxen=double(max(max(en)));
% % f=double(vi)./double(en);
% % sizeen=size(en);
% % for x=1:sizeen(1)
% %     for y=1:sizeen(2)
% %         if f(x,y)==Inf
% %             f(x,y)=0;
% %         end
% %     end
% % end
% % save en1 en f
%mprecf2=imadjust(mprecf,[78/256 1],[]);
%mprecfbw=im2bw(mprecf2,1/256);
%%%Acá pruebo con las dos sentencias anteriores para eliminar el background
% mprecfbw=im2bw(mprecf,1/256);
% pcf=mprecfbw.*vi;
% lpcf=logical(pcf);
% save pcf pcf lpcf

% lpcf=logical(pcf);
% [r,n]=bwlabel(lpcf);
% c=regionprops(lpcf);
% centroids=cat(1,c.Centroid);




% UIWAIT makes detmasas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = detmasas_OutputFcn(hObject, eventdata, handles) 
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
IL;
close detmasas;


% --- Executes on button press in siguiente.
function siguiente_Callback(hObject, eventdata, handles)
% hObject    handle to siguiente (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
anamasas0;
close detmasas;


% --- Executes on button press in rehacer.
function rehacer_Callback(hObject, eventdata, handles)
% hObject    handle to rehacer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nc=get(handles.clus,'UserData');
nc=round(nc);
load ima5
a1=double(mprecf(:));
[idx,nn]=kmeans(a1,nc);
ima1=uint8(reshape(idx,size(mprecf)));
m=double(max(max(ima1)));
ima=imadjust(ima1,[0 m/256],[]);
axes(handles.masas)
imshow(ima),title 'Masas'
save ima6 ima ima1




function clus_Callback(hObject, eventdata, handles)
% hObject    handle to clus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of clus as text
%        str2double(get(hObject,'String')) returns contents of clus as a double
nc=str2double(get(hObject,'String'));
set(handles.clus,'UserData',nc);

% --- Executes during object creation, after setting all properties.
function clus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to clus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ite.
function ite_Callback(hObject, eventdata, handles)
% hObject    handle to ite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kite;
