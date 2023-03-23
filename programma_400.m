% Программа расчета по аппроксимационной модели Волкова
% Вариант приближенного решения (по схеме Волкова)
% dk==1  - ручной ввод исходных данных
% dk==2  - автоматический ввод исходных данных из программы
clear all;
clc;
AddOpts.Resize='on';
AddOpts.WindowStyle='normal';
AddOpts.Interpreter='tex';
prompt={'dk=1,2'};
dlgTitle='Ввод данных';
lineNo=[1 9];
an=inputdlg(prompt,dlgTitle,lineNo,{''},AddOpts);
dk=str2num(an{1});
if dk==0 || dk>2
   h = msgbox('Расчета нет!','','warn');
   break
end
if dk==1
AddOpts.Resize='on';
AddOpts.WindowStyle='normal';
AddOpts.Interpreter='tex';
prompt={'\nu=','mc1=','mc2=','\gamma'};  
% nu-число доработок, mc1-число первых сечений (2\4), mc2-число последных сечений (2\3)
dlgTitle='Ввод данных';
lineNo=[1 9];
an=inputdlg(prompt,dlgTitle,lineNo,{'','','',''},AddOpts);
nu=str2num(an{1});
mc1=str2num(an{2});
mc2=str2num(an{3});
gamma=str2num(an{4});
i=[1:1:nu+1]';
jj=1;
while jj<=nu+1
    AddOpts.Resize='on';
    AddOpts.WindowStyle='normal';
    AddOpts.Interpreter='tex';
    prompt={'ni=','mi=','ci='};
    dlgTitle='Ввод данных';
    lineNo=[1 9];
    an=inputdlg(prompt,dlgTitle,lineNo,{'','',''},AddOpts);
    ni(jj)=str2num(an{1});
    mi(jj)=str2num(an{2});
    ci(jj)=str2num(an{3});
    jj=jj+1;
end
end    
if dk==2
    % ВВОД ИСХОДНЫХ ДАННЫХ В ВИДЕ МАТРИЦ
%--------Данные примераов Волкова-------
    %ni=[2 1 1 1 1 1 1 2 1 6]';  % '-знак траспонирования матрицы
    %mi=[2 0 1 1 0 0 0 0 0 2]';
    %ci=[0 1 5 2 2 2 1 2 1 1]';
    %mc1=4;  % число первых сечений для расчета числа испытаний е
    %mc2=2;  % число последных сечений для расчета числа испытаний z
    
    %ni=[2 1 1 1 1 1 1 1 1 1 1 1 1 2 1 6]';
    %mi=[2 0 1 1 0 1 0 1 1 1 0 0 0 0 0 2]';
    %ci=[0 1 5 2 1 2 4 1 1 6 2 2 1 2 1 1]';
    %mc1=4;  % число первых сечений для расчета числа испытаний е
    %mc2=2;  % число последных сечений для расчета числа испытаний z
    
    %---ПРИМЕР РАСЧЕТА для произвольных данных ---
    % (размерность строки матриц должна быть >=4, nu=3)
    ni=[8 20 40 60 20]';
    mi=[3  2  3  1  0]';
    ci=[2  3  2  2  0]';
    mc1=2;  % число первых сечений (2\4) для расчета числа испытаний е
    mc2=2;  % число последных сечений (2\3)для расчета числа испытаний z
    
   i=[1:1:max(size(ni))]';
   gamma=0.8;
end
   nu=max(size(i))-1;
%-------РАСЧЕТ-----------
n=sum(ni);  % общее число испытаний
m=sum(mi);  % общее число отказов
ch=sum(ci)/nu;  % среднее число устраняемых причин отказов в одной доработке - c*=ch
                % k=nu-1 общее число доработок
cm=max(ci);
me=0;ne=0;e=0;
for j0=1:mc1
    e=e+ni(j0);  %число испытаний е
end
j1=1;
while j1<=mc1
    ne=ne+ni(j1);
    if ne==e
        kk1=j1;
        for ii=1:kk1
            me=me+mi(ii);   % расчет суммы отказов по первым испытаниям
        end
    end
    j1=j1+1;
end
p0=1-(me/e);    % оценка приближения по первым испытаниям
mz=0;nz=0;z=0;
for j2=((nu+1-mc2)+1):nu+1
    z=z+ni(j2);  % число последних испытаний z
end
jj=nu+1;
while jj>=1
    nz=nz+ni(jj);
    if nz==z
        ii=jj;
        for j3=ii:nu+1
            mz=mz+mi(j3);    % расчет суммы отказов по последним испытаниям
        end
    end
    jj=jj-1;
end
Pnn=1-(mz/z);   % оценка приближения по последним испытаниям
ah=(1-((1-Pnn)/(1-p0))^(1/nu))/ch;  % оценка параметра a (см. 5.192-5.193)
% --- Определение значения MIN фунции L (по формуле 5.127) ---
p0t=[0:p0/20:p0];                     % матрица квадратная (одинаковые столбцы)
if ah<1/cm
a0t=[ah:(1/cm-ah)/20:1/cm];           % матрица квадратная (одинаковые строки)
end
if ah>=1/cm
    a0t=[0.5*ah:ah/20:ah+0.5*ah];     % матрица квадратная (одинаковые строки)
end
h=waitbar(0);
w=max(size(p0t));
ww=max(size(a0t));
for  k=1:w
    kk=round(k*100/w);         % округление до целого
    s=int2str(kk)              % преобразование целого в строку
    s=strcat(s,'%')            % горизонтальное объединение строк
    waitbar(k/w,h,s);          % стандартная панель ожидания 
    for r=1:ww;
        t1=0;
        t2=0;
        for j=1:nu+1
            t1=t1+i(j)*mi(j);
            t2=t2+(ni(j)-mi(j))*log(Pnn-(Pnn-p0t(k))*(1-a0t(r)*ch/Pnn)^j);
        end
           L(k,r)=-m*log(1-p0t(k))-log(1-a0t(r)*ch/Pnn)*t1-t2;     % (формула 5.127)
    end
end
close(h);
hFig1=figure('Position',[100,100,600,450]);
[p0t,a0t]=meshgrid(0:p0/20:p0, 0.5*ah:ah/20:ah+0.5*ah); % линии уровня;
surfc(p0t,a0t,L);           % графический объект дескриптоной графики 3D: варианты:
                            % surfc(p0t,a0t,L)- с линиями уровня;
                            % surface(p0t,a0t,L,L); surf(p0t,a0t,L);
                            % mesh(p0t,a0t,L);
colormap(hsv); %(hsv)-вариант цветовой гаммы-плавное измннение(как цвета радуги)[см. стр.113]
colorbar;                   % цветовая шкала
view(-25,15);               % задание точки зрения   
set(gca,'LineWidth',2);
set(gca,'ZTickMode','manual');  % разметка оси z
xlabel('P0');
ylabel('a0');
zlabel('Отрицательная L-функция правдоподобия (-lnL)','fontname','Arial Unicode MS');
title('Поверхность отрицательной L-функции правдоподобия (-lnL)','fontname','Arial Unicode MS')
grid on; hold on; axis square;          % axis square - оси квадрат
% --- Определение минимума функции L ---
mn1=min(L);
[m1,j4]=min(mn1);
L01=m1;
ak=a0t(j4,1);
mn2=min(L,[],2);
[m2,j5]=min(mn2);
L02=m2;                    
pk=p0t(j5,j5);
L0=[L01 L02];
Lmin=min(L0);
%--- определение координат графика по наработке ---
tt=0;
tt1=0;
j7=1;
while j7<=nu+1
    for v=1:j7
        tt=tt+ci(v);
        tt1=tt1+ni(v);
    end
    cii(j7)=tt;
    nii(j7)=tt1;
    j7=j7+1;
     tt=0;   
    tt1=0;   
end
%--- определение координат графика по показателям 'Pi','P_',
pin=1;
for j8=1:nu+1
    for jj=1:j8
        pin=pin*(1-ak*ci(jj)/Pnn);
    end
    pi(j8)=Pnn-(Pnn-pk)*pin;
    T(j8)=-1/log(pi(j8));
end
%-----------------
for j9=1:max(size(cii))
    xpi(j9)=0.85*sqrt(pi(j9)*(1-pi(j9))/(nii(j9)-1));   % среднее квадратическое отклонение
    pi_(j9)=pi(j9)-norminv((1+gamma)/2)*xpi(j9);    % нижняя доверительная граница
    T_(j9)=-1/log(pi_(j9));
end
s1=max(size(pi));
zz=max(size(n));
k1=1;
k2=1;
while k1<=s1
    pv(k2)=pi(k1);
    pd(k2)=pi_(k1);
    nv(k2)=nii(k1);
    k2=k2+1;

    pv(k2)=pv(k2-1);
    pd(k2)=pd(k2-1);
    nv(k2)=nv(k2-1);
    k1=k1+1;
    k2=k2+1;

end
s2=max(size(nv));
for k1=1:s2-1
    nv(k1)=nv(k1+1);
end
nv(s2)=n(zz);
%--- определение координат графика по показателям 'Pex' ---
n=sum(ni);
js=[0:1:n+n];
Pex=1-(1-p0)*exp(-nu*(ch)*ak*(js)/n);

hFig2=figure('Position',[100,100,600,450]);
plot(nv,pv,'k',nv,pd,'r','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5); grid on; hold on;
plot(js,Pex,'blu','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5); grid on; hold on;         
set(gca,'XLim',[0 n+n]);
legend('Pi','P_','Pex',4);
set(gca,'LineWidth',2);
set(gca,'YLim',[pk 1]);
xlabel('Число испытаний n','fontname','Arial Unicode MS')
ylabel('Pi, P_, Pex','fontname','Arial Unicode MS')
title('Pi, P_  и аппроксимация экспоненциальной формой (Pex)','fontname','Arial Unicode MS')
%------------ табличгное представление результатов ----------------
hFig=figure('Position',[130,130,50*nu+115,300]);
kq=uicontrol('Style','text','String','РЕЗУЛЬТАТЫ',...
    'Position',[(50*nu/2)-20,275,120,19],'BackgroundColor',[1,0,1]);

h_Txti=uicontrol('Style','text','String','i=',...
    'Position',[20,250,35,19],'BackgroundColor',[1,1,1]);
h_Txtn=uicontrol('Style','text','String','n=',...
    'Position',[20,225,35,19],'BackgroundColor',[1,1,1]);
h_Txtd=uicontrol('Style','text','String','m=',...
    'Position',[20,200,35,19],'BackgroundColor',[1,1,1]);
h_Txtd=uicontrol('Style','text','String','k=',...
    'Position',[20,175,35,19],'BackgroundColor',[1,1,1]);

hPnn=uicontrol('Style','text','String','Pnn=',...
    'Position',[20,150,30,19],'BackgroundColor',[1,1,1]);
hp0=uicontrol('Style','text','String','P0=',...
    'Position',[115,150,30,19],'BackgroundColor',[1,1,1]);
ha0=uicontrol('Style','text','String','a0=',...
    'Position',[210,150,30,19],'BackgroundColor',[1,1,1]);

hpk=uicontrol('Style','text','String','Popt=',...
    'Position',[20,125,30,19],'BackgroundColor',[1,1,1]);
hak=uicontrol('Style','text','String','aopt=',...
    'Position',[115,125,30,19],'BackgroundColor',[1,1,1]);
hLmin=uicontrol('Style','text','String','Lmin=',...
    'Position',[210,125,30,19],'BackgroundColor',[1,1,1]);

hTxtPi=uicontrol('Style','text','String','Pi=',...
    'Position',[20,100,30,19],'BackgroundColor',[1,1,1]);
hTxtP_=uicontrol('Style','text','String','P_=',...
        'Position',[20,75,30,19],'BackgroundColor',[1,1,1]);
    
hTxtT=uicontrol('Style','text','String','T=',...
        'Position',[20,50,30,19],'BackgroundColor',[1,1,1]);
hTxtT_=uicontrol('Style','text','String','T_=',...
        'Position',[20,25,30,19],'BackgroundColor',[1,1,1]);

hEPnn=uicontrol('Style','edit','Position',[55,150,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEp0=uicontrol('Style','edit','Position',[150,150,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEa0=uicontrol('Style','edit','Position',[245,150,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');

hEpk=uicontrol('Style','edit','Position',[55,125,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEak=uicontrol('Style','edit','Position',[150,125,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hELmin=uicontrol('Style','edit','Position',[245,125,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');

for k2=1:nu+1
hEi(k2)=uicontrol('Style','edit','Position',[50*k2,250,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEn(k2)=uicontrol('Style','edit','Position',[50*k2,225,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEm(k2)=uicontrol('Style','edit','Position',[50*k2,200,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEk(k2)=uicontrol('Style','edit','Position',[50*k2,175,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
set(hEi(k2),'String',num2str(i(k2)));
set(hEn(k2),'String',num2str(ni(k2)));
set(hEm(k2),'String',num2str(mi(k2)));
set(hEk(k2),'String',num2str(ci(k2)));
end
for k1=1:nu+1
hEpi(k1)=uicontrol('Style','edit','Position',[50*k1,100,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEpi_(k1)=uicontrol('Style','edit','Position',[50*k1,75,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');

hET(k1)=uicontrol('Style','edit','Position',[50*k1,50,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hET_(k1)=uicontrol('Style','edit','Position',[50*k1,25,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');

set(hEpi_(k1),'String',num2str(pi_(k1)));
set(hEpi(k1),'String',num2str(pi(k1)))
set(hET_(k1),'String',num2str(T_(k1)));
set(hET(k1),'String',num2str(T(k1)))

end
set(hEPnn,'String',num2str(Pnn));set(hEp0,'String',num2str(p0));
set(hEa0,'String',num2str(ah));set(hELmin,'String',num2str(Lmin));
set(hEpk,'String',num2str(pk));set(hEak,'String',num2str(ak));

% ------ Прогнозный расчет ------
ButtonName=questdlg('Прогнозный расчет проводить?', ...
                       'Диалог', ...
                       'Да','Нет','Да');
    switch ButtonName,
     case 'Да',       
       AddOpts.Resize='on';
AddOpts.WindowStyle='normal';
AddOpts.Interpreter='tex';
prompt={'dk=[1,2]'};      %  Два варианта прогнозного расчета
dlgTitle='Ввод данных';
lineNo=[1 9];
an=inputdlg(prompt,dlgTitle,lineNo,{''},AddOpts);
dk=str2num(an{1});
if dk==0 || dk>2
   h = msgbox('Расчета нет!','','warn');
   break
end

if dk==1   %  "Задать значение Delta_n"  
AddOpts.Resize='on';
AddOpts.WindowStyle='normal';
AddOpts.Interpreter='tex';
prompt={'Delta n'};  
dlgTitle='Ввод значения Delta n';
lineNo=[1 9];
an=inputdlg(prompt,dlgTitle,lineNo,{''},AddOpts);
Delta_n=str2num(an{1});
 % Расчет Pex, Pex_
n_n=n+Delta_n;      % прогнозное значение наработки
Pex=1-(1-p0)*exp(-nu*(ch)*ak*(n_n)/n);  % точечная оценка
xp=0.85*sqrt((Pex)*(1-Pex)/(n_n-1));   % среднее квадратическое отклонение
Pex_=Pex-norminv((1+gamma)/2)*xp;    % нижняя доверительная граница
   % -------------- Вывод результата прогнозногшо расчета -----------------
hFig=figure('Position',[ 160,130,200,300]);
hTxta=uicontrol('Style','text','String','РЕЗУЛЬТАТ ПРОГНОЗНОГО РАСЧЕТА вариант первый',...
    'Position',[45,200,110,65],'BackgroundColor',[1,0,1]);
hTxtDelta_n=uicontrol('Style','text','String','Delta n=',...
    'Position',[40,130,45,20],'BackgroundColor',[1,1,1]);
h_TxtPex=uicontrol('Style','text','String','Pex=',...
    'Position',[40,80,45,20],'BackgroundColor',[1,1,1]);
h_TxtPex_=uicontrol('Style','text','String','Pex_=',...
    'Position',[40,50,45,20],'BackgroundColor',[1,1,1]);

hEDelta_n=uicontrol('Style','edit','Position',[100,130,60,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEPex=uicontrol('Style','edit','Position',[100,80,60,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEPex_=uicontrol('Style','edit','Position',[100,50,60,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');

set(hEDelta_n,'String',num2str(Delta_n));
set(hEPex,'String',num2str(Pex));set(hEPex_,'String',num2str(Pex_));
end
    
if dk==2    %  "Задать значение Pexpr"  
AddOpts.Resize='on';
AddOpts.WindowStyle='normal'
AddOpts.Interpreter='tex';
prompt={'Pexpr'};  
dlgTitle='Ввод значения Pexpr';
lineNo=[1 9];
an=inputdlg(prompt,dlgTitle,lineNo,{''},AddOpts);
Pexpr=str2num(an{1});
 % Расчет Delta_n
A=nu*(ch)*ak/n;
Nex=-(log((1-Pexpr)/(1-p0)))/A;
Delta_n=round(Nex-n);
    % -------------- Вывод результата прогнозногшо расчета -----------------
 hFig=figure('Position',[ 160,130,200,300]);
hTxta=uicontrol('Style','text','String','РЕЗУЛЬТАТ ПРОГНОЗНОГО РАСЧЕТА вариант второй',...
    'Position',[45,200,110,65],'BackgroundColor',[1,0,1]);
hTxtPexpr=uicontrol('Style','text','String','Pexpr=',...
    'Position',[40,130,45,20],'BackgroundColor',[1,1,1]);
h_TxtDelta_n=uicontrol('Style','text','String','Delta n=',...
    'Position',[40,80,45,20],'BackgroundColor',[1,1,1]);

hEPexpr=uicontrol('Style','edit','Position',[100,130,60,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEDelta_n=uicontrol('Style','edit','Position',[100,80,60,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');

set(hEPexpr,'String',num2str(Pexpr));
set(hEDelta_n,'String',num2str(Delta_n));
end    
       continue
     case 'Нет',
      break
    end 
