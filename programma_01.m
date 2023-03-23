function varargout = programma_01(varargin)
% PROGRAM_01 M-file for program_01.fig
% Last Modified by GUIDE v2.5 22-Mar-2007 10:59:26
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @programma_01_OpeningFcn, ...
                   'gui_OutputFcn',  @programma_01_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% Executes just before program_01 is made visible.
function programma_01_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for program_01
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% Outputs from this function are returned to the command line.
function varargout = programma_01_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;
% --------------------------------------------------------------------
function metod10_Callback(hObject, eventdata, handles)
% hObject    handle to phoihop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
programma_1001;
%----------------------------------------------------------------------
function metod11_Callback(hObject, eventdata, handles)
% hObject    handle to phoihop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
programma_100;
% --------------------------------------------------------------------
function metod2_Callback(hObject, eventdata, handles)
% hObject    handle to Phuongan2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%-----------------------------------------------------------------------
function metod3_Callback(hObject, eventdata, handles)
% hObject    handle to Phuongan2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
programma_300;
%-----------------------------------------------------------------------
function output_Callback(hObject, eventdata, handles)
close
% --------------------------------------------------------------------
function BPI_Callback(hObject, eventdata, handles)
% hObject    handle to БПИ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function metod2_01_Callback(hObject, eventdata, handles)
% hObject    handle to Без_названия_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
programma_200;
% --------------------------------------------------------------------
function metod2_02_Callback(hObject, eventdata, handles)
% hObject    handle to Без_названия_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
programma_201;
%-----------------------------------------------------------------------
function metod4_Callback(hObject, eventdata, handles)
% hObject    handle to Phuongan2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
programma_400;