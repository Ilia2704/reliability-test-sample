% Редакция ВЮЛ
function varargout = programma_201(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @programma_201_OpeningFcn, ...
                   'gui_OutputFcn',  @programma_201_OutputFcn, ...
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
function programma_201_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
function varargout = programma_201_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
function n10_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function n10_Callback(hObject, eventdata, handles)
function m10_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function m10_Callback(hObject, eventdata, handles)
function n11_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function n11_Callback(hObject, eventdata, handles)
function m11_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function m11_Callback(hObject, eventdata, handles)
function n12_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function n12_Callback(hObject, eventdata, handles)
function start_Callback(hObject, eventdata, handles)
nn=get(handles.n10,'String');
mm=get(handles.m10,'String');
n11=[get(handles.n11,'String')];
n22=[get(handles.n12,'String')];
m11=[get(handles.m11,'String')];
m22=[get(handles.m22,'String')];
gm=[get(handles.g10,'String')];
n=str2num(nn);
m=str2num(mm);
n1=str2num(n11);
m1=str2num(m11);
n2=str2num(n22);
m2=str2num(m22);
gamma=str2num(gm);
Pio=1-m1./n1
if m2==0
    P1=1-1/(2*(n+2));
    Pe=1-m1./(n1+n2);
    P2i=1-1./(2.*(n2+2));
    Pi=P2i+(1-P2i).*Pe;
    P=P1*prod(Pi);
    T=-1/log(P);
else
    P1=1-m2/n;
    Pe=1-m1./(n1+n2);
    P2i=1-1./(2.*(n2+2));
    Pi=P2i+(1-P2i).*Pe;
    P=P1*prod(Pi);
    T=-1/log(P);
end
z=max(size(n1));
for j=1:z
for i=1:3
    if i==1
        pg1(j,i)=0
        ng1(j,i)=0
    end
    if i==2
        pg1(j,i)=Pio(j)
        ng1(j,i)=n1(j)
    end
    if i==3
        pg1(j,i)=Pi(j)
        ng1(j,i)=n1(j)+n2(j)
    end
end
end
grid on; hold on;
xlabel('Число испытаний n','fontname','Arial Unicode MS');
ylabel('Значение ВБР (P)','fontname','Arial Unicode MS');
title('График ВБР (P) по причине отказов i-го типа','fontname','Arial Unicode MS');
jj=1;
while jj<=z
            AddOpts.Resize='on';
            AddOpts.WindowStyle='normal';
            AddOpts.Interpreter='tex';
            prompt={'тип отказов i='};
            dlgTitle='Вывод графиков';
            lineNo=[1 35];
            an=inputdlg(prompt,dlgTitle,lineNo,{''},AddOpts);
            k=str2num(an{1});
            if k==0 || k>z
                h = msgbox('Не рисовать!','','warn');
                break
            end
for j=1:z
    if j==k
        for i=1:3
            pv(i)=pg1(j,i)
            nv(i)=ng1(j,i)
        end
    end
end
plot(nv,pv,'k',nv,pv,'o');
ButtonName=questdlg('Продолжить', ...
                       'Диалог', ...
                       'Да','Нет','Да');
 switch ButtonName,
     case 'Да', 
      jj=jj+1
       continue
     case 'Нет',
      break
   end 
end
num=get(handles.popupmenu1,'value');
switch num
    case 1 
        ne=n;
        me=(1-P)*ne;
    case 2
        mt(1)=m1(1)+m1(2);
        nt(1)=n1(1)+n1(2);
        m_1(1)=min(mt(1),n1(1));
        C1(1)=nchoosek(nt(1),mt(1));
        for r=m1(1):m_1(1)
            x_1(r)=nchoosek(n1(1),r)*nchoosek(n1(2),m_1(1)-r);
        end
        C2(1)=sum(x_1);
        W(1)=C2(1)/C1(1)
        ntd(1)=round(n1(1)*W(1)+n1(2))
        mtd(1)=round(n1(1)*(1-P))
        z=max(size(n1));        
        for i=2:z-1
            mt(i)=mtd(i-1)+m1(i+1);
            nt(i)=ntd(i-1)+n1(i+1);
            m_1(i)=min(mt(i),ntd(i-1));
            C1(i)=nchoosek(nt(i),mt(i)); tc=0;
            for r=mtd(i-1):m_1(i)
                x_1(r)=nchoosek(ntd(i-1),r)*nchoosek(n1(i+1),mt(i)-r);
                tc=tc+x_1(r);
            end
            C2(i)=tc;
            W(i)=C2(i)/C1(i);
            ntd(i)=round(n1(i)*W(i)+n1(i+1))
            mtd(i)=round(n1(i)*(1-P));
        end
        ne=sum(ntd)/z;
        me=ne*(1-P);
    case 3 
        mt(1)=m1(1)+m1(2);
        nt(1)=n1(1)+n1(2);
        m_1(1)=min(mt(1),n1(1));
        C1(1)=nchoosek(nt(1),mt(1));
        for r=m1(1):m_1(1)
            x_1(r)=nchoosek(n1(1),r)*nchoosek(n1(2),m_1(1)-r);
        end
        C2(1)=sum(x_1);
        W(1)=C2(1)/C1(1)
        ntd(1)=round(n1(1)*W(1)+n1(2))
        mtd(1)=round(n1(1)*(1-P))
        z=max(size(n1));        
        for i=2:z-1
            mt(i)=mtd(i-1)+m1(i+1);
            nt(i)=ntd(i-1)+n1(i+1);
            m_1(i)=min(mt(i),ntd(i-1));
            C1(i)=nchoosek(nt(i),mt(i)); tc=0;
            for r=mtd(i-1):m_1(i)
                x_1(r)=nchoosek(ntd(i-1),r)*nchoosek(n1(i+1),mt(i)-r);
                tc=tc+x_1(r);
            end
            C2(i)=tc;
            W(i)=C2(i)/C1(i);
            ntd(i)=round(n1(i)*W(i)+n1(i+1))
            mtd(i)=round(n1(i)*(1-P));
        end
            ne=min(ntd);
            me=ne*(1-P);
    end
Pn=betainv(1-gamma,ne-me,me+1);
Tn=-1/log(Pn);
set(handles.VBRN,'String',num2str(Pn));
set(handles.VBR,'String',num2str(P));
set(handles.Tn,'String',num2str(Tn));
set(handles.T,'String',num2str(T));
function VBR_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function VBR_Callback(hObject, eventdata, handles)
function VBRN_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function VBRN_Callback(hObject, eventdata, handles);
function T_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function T_Callback(hObject, eventdata, handles)
function Tn_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function Tn_Callback(hObject, eventdata, handles)
function xoadothi_Callback(hObject, eventdata, handles)
if get(handles.xoadothi,'value')
cla;
set(handles.n10,'String',' ');
set(handles.m10,'String',' ');
set(handles.n11,'String',' ');
set(handles.m11,'String',' ');
set(handles.m22,'String',' ');
set(handles.n12,'String',' ');
set(handles.g10,'String',' ');
set(handles.VBR,'String',' ');
set(handles.VBRN,'String',' ');
set(handles.T,'String',' ');
set(handles.Tn,'String',' ');
set(gca,'Xgrid','off');
set(gca,'Ygrid','off');
legend('off');
title('');
xlabel('');
ylabel('');
end
function m22_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function m22_Callback(hObject, eventdata, handles)
function vidu_Callback(hObject, eventdata, handles)
n=110; m=12; m2=3;gamma=0.9;
n1=[30 40 50 60 70 80];
n2=[85 80 70 75 60 65];
m1=[1 2 3 2 2 2];
set(handles.n10,'String',num2str(n));
set(handles.m10,'String',num2str(m));
set(handles.n11,'String',num2str(n1));
set(handles.m11,'String',num2str(m1));
set(handles.m22,'String',num2str(m2));
set(handles.n12,'String',num2str(n2));
set(handles.g10,'String',num2str(gamma));
function edit12_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function edit12_Callback(hObject, eventdata, handles)
function g10_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function g10_Callback(hObject, eventdata, handles)
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end
function popupmenu1_Callback(hObject, eventdata, handles)



