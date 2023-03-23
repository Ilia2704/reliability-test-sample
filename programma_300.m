% Редакция ВЮЛ 
clear all;
clc;
%alpha=0.05, gamma=1-alpha=1-0.05=0.95;
% mu-число типов(причин) отказов;
% nu(j)-число серий (этапов) испытаний при j-м типе отказов;
% (nu(j)-1) - число доработок в испытаниях при j-м типе отказов;
%----------------------------------------
  
ButtonName=questdlg('Количество типов отказов известно. Задать?',...
    'Диалог',...
    'Да','Нет','Да');
    AddOpts.Resize='on';
    AddOpts.WindowStyle='normal';
    AddOpts.Interpreter='tex';
    prompt={'\mu='};
    dlgTitle='Ввод данных';
    lineNo=[1 9];
    an=inputdlg(prompt,dlgTitle,lineNo,{''},AddOpts);
mu=str2num(an{1});
%----------------------------------------
A=ones(1, mu);       
 for j=1:1:mu    
     
% При вводе исходных данных выполняется условие:
% причины отказов рассматриваются в последовательности
% {nu(1)<=nu(2)<=...<=nu(mu)};

ButtonName=questdlg('Сколько серий испытаний для данного типа отказов задать? Продолжить?',...
    'Диалог',...
    'Да','Нет','Да');
    switch ButtonName,
        case 'Да',
    AddOpts.Resize='on';
    AddOpts.WindowStyle='normal';
    AddOpts.Interpreter='tex';
    prompt={'\nu=','n1=','n2=','d1=','d2=','T1=','T2=','\alpha='};
    dlgTitle='Ввод данных';
    lineNo=[1 9];
    an=inputdlg(prompt,dlgTitle,lineNo,{'','','','','','','',''},AddOpts);
nu=str2num(an{1});
n(1)=str2num(an{2});
n(2)=str2num(an{3});
d(1)=str2num(an{4});
d(2)=str2num(an{5});
T(1)=str2num(an{6});
T(2)=str2num(an{7});
alpha=str2num(an{8});
 % ---- расчет для одной (1-й) доработки \двух (1-й + 2-й) серий испытаний\----
n1(1)=2*d(1);n2(1)=2*d(2)+2;
F(1)=((d(2)+1)/d(1))*((n(1)*T(1))/(n(2)*T(2)));
W(1)=fcdf(F(1),n1(1),n2(1));
S(1)=n(1)*T(1);S(2)=n(2)*T(2);
L(1)=(d(2)/S(2))+W(1)*((d(1)+d(2))/(S(1)+S(2))-(d(2)/S(2)))
SS(1)=S(1)*W(1)+S(2)
P(1)=exp(-L(1))
dd(1)=L(1)*SS(1);
L_(1)=0.5*chi2inv(1-alpha,2*dd(1)+2)/SS(1);
P_(1)=exp(-L_(1));
 % ---- расчет для второй и последующих доработок (до последней (nu-1)) или
 % третьей и последующих серий испытаний (до последней (nu)-й серии) ------
 i=2;
Pnu=P(1);
Pnu_=P_(1);

if nu==2
  B(j)=A(j).*L(1);     
  C(j)=A(j).*SS(1);        
end    
  
while i<=nu-1
AddOpts.Resize='on';
AddOpts.WindowStyle='normal';
AddOpts.Interpreter='tex';
prompt={'n = ','d = ','T = '};
dlgTitle='Ввод n, d и T';
lineNo=[1 9];
an=inputdlg(prompt,dlgTitle,lineNo,{'','',''},AddOpts);
n(i+1)=str2num(an{1});
d(i+1)=str2num(an{2});
T(i+1)=str2num(an{3});

n1(i)=2*dd(i-1);n2(i)=2*d(i+1)+2;
F(i)=((d(i+1)+1)/dd(i-1))*((SS(i-1))/(n(i+1)*T(i+1)));
W(i)=fcdf(F(i),n1(i),n2(i));
S(i+1)=n(i+1)*T(i+1);
L(i)=(d(i+1)/S(i+1))+W(i)*((dd(i-1)+d(i+1))/(SS(i-1)+S(i+1))-(d(i+1)/S(i+1)));
SS(i)=SS(i-1)*W(i)+S(i+1);
P(i)=exp(-L(i));
dd(i)=L(i)*SS(i);
L_(i)=0.5*chi2inv(1-alpha,2*dd(i)+2)/SS(i);
P_(i)=exp(-L_(i));

   if i==nu-1
Pnu=P(nu-1);
Pnu_=P_(nu-1);
B(j)=A(j).*L(nu-1);     
C(j)=A(j).*SS(nu-1);        
   end    
 %--------------------------- Промежуточная графика -----------------------------   

    if i>1
m2=1:i;
hFig=figure('Position',[200,200,600,400]);
plot(m2,P,'o--',m2,P_,'s--',...
    'LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',5);
legend('P','P-',4)
xlabel('Число доработок \nu','fontname','Arial Unicode MS')
ylabel('Точечная оценка P и нижняя доверительная граница P_','fontname','Arial Unicode MS')
title('Аппроксимация данных кусочно-линейной формой','fontname','Arial Unicode MS')
grid on; hold on;
    end
%--------------------------------------------------------
ButtonName=questdlg('Продолжить', ...
                       'Диалог', ...
                       'Да','Нет','Да');
    switch ButtonName,
     case 'Да', 
      i=i+1
       continue
     case 'Нет',
      break
    end 
end
%-------------------  Промежуточные результаты: -----------------
s1=max(size(P_));
zz=max(size(n));
for i=2:max(size(n))
    if i==2
        nnn(i-1)=n(i)+n(i-1)
    else
        nnn(i-1)=nnn(i-2)+n(i)
    end
end
i=1;
ii=1;
while i<=s1
    pP_(ii)=P_(i);
    pP(ii)=P(i);
    nn(ii)=nnn(i);
    ii=ii+1;
    pP_(ii)=pP_(ii-1);
    pP(ii)=pP(ii-1);
    nn(ii)=nn(ii-1);
    i=i+1;
    ii=ii+1;
end
s2=max(size(nn));
for i=2:s2-1
    nn(i)=nn(i+1)
end
nn(s2)=nn(s2)+10;
plot(nn,pP,'r',nn,pP_,'k','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5); grid on; hold on;
legend('P','P_',4);
xlabel('Число испытаний n, число доработок \nu','fontname','Arial Unicode MS')
ylabel('Значение P, P_','fontname','Arial Unicode MS')
title('ВБР с изменением числа испытаний и числа доработок','fontname','Arial Unicode MS')
set(gca,'LineWidth',2);

hFig=figure('Position',[160,130,50*zz+60,410]);
hTxta=uicontrol('Style','text','String','РЕЗУЛЬТАТЫ',...
    'Position',[(50*zz/2)-20,380,100,20],'BackgroundColor',[1,0,1]);
h_Txtn=uicontrol('Style','text','String','n=',...
    'Position',[10,325,35,19],'BackgroundColor',[1,1,1]);
h_Txtd=uicontrol('Style','text','String','d=',...
    'Position',[10,300,35,19],'BackgroundColor',[1,1,1]);
h_TxtT=uicontrol('Style','text','String','T=',...
    'Position',[10,275,35,19],'BackgroundColor',[1,1,1]);
hTxtw=uicontrol('Style','text','String','W=',...
    'Position',[10,250,35,19],'BackgroundColor',[1,1,1]);
h_TxtL=uicontrol('Style','text','String','L=',...
    'Position',[10,225,35,19],'BackgroundColor',[1,1,1]);
h_TxtP=uicontrol('Style','text','String','P=',...
    'Position',[10,200,35,19],'BackgroundColor',[1,1,1]);
h_Txtp1=uicontrol('Style','text','String','SS=',...
    'Position',[10,175,35,19],'BackgroundColor',[1,1,1]);
h_Txtdd=uicontrol('Style','text','String','dd=',...
    'Position',[10,150,35,19],'BackgroundColor',[1,1,1]);
h_TxtL_=uicontrol('Style','text','String','L_=',...
    'Position',[10,125,35,19],'BackgroundColor',[1,1,1]);
hTxtP_=uicontrol('Style','text','String','P_=',...
    'Position',[10,100,35,19],'BackgroundColor',[1,1,1]);
hTxtPnu=uicontrol('Style','text','String','Pnu=',...
    'Position',[10,75,35,19],'BackgroundColor',[1,1,1]);
hTxtPnu_=uicontrol('Style','text','String','Pnu_=',...
    'Position',[10,50,35,19],'BackgroundColor',[1,1,1]);

for i=1:max(size(n))
hEi(i)=uicontrol('Style','edit','Position',[50*i,350,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEn(i)=uicontrol('Style','edit','Position',[50*i,325,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEd(i)=uicontrol('Style','edit','Position',[50*i,300,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hET(i)=uicontrol('Style','edit','Position',[50*i,275,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
end
for i=1:max(size(n))-1
hEw(i)=uicontrol('Style','edit','Position',[50+50*i,250,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEL(i)=uicontrol('Style','edit','Position',[50+50*i,225,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEP(i)=uicontrol('Style','edit','Position',[50+50*i,200,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hESS(i)=uicontrol('Style','edit','Position',[50+50*i,175,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEdd(i)=uicontrol('Style','edit','Position',[50+50*i,150,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEL_(i)=uicontrol('Style','edit','Position',[50+50*i,125,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEP_1(i)=uicontrol('Style','edit','Position',[50+50*i,100,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
end
hEPnu=uicontrol('Style','edit','Position',[50,75,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEPnu_=uicontrol('Style','edit','Position',[50,50,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');

qq=[1:1:zz];
for i=1:max(size(n))
    set(hEi(i),'String',num2str(qq(i)));
    set(hEn(i),'String',num2str(n(i)));
    set(hEd(i),'String',num2str(d(i)));
    set(hET(i),'String',num2str(T(i)));
end
for i=1:max(size(n))-1
set(hEL(i),'String',num2str(L(i)));set(hEL_(i),'String',num2str(L_(i)));
set(hEw(i),'String',num2str(W(i)));set(hEP(i),'String',num2str(P(i)));
set(hESS(i),'String',num2str(SS(i)));set(hEdd(i),'String',num2str(dd(i)));
set(hEP_1(i),'String',num2str(P_(i)));
end
set(hEPnu,'String',num2str(Pnu));set(hEPnu_,'String',num2str(Pnu_));
        continue
    case 'Нет',
        break
    end    
end   %--------- Завершение цикла по j(mu)------------------------

% -------------- Окончательный расчет ----------------------------
Ls=sum(B);                   
Smu=min(C);                             
Pmu=exp(-Ls);
dmu=Ls*Smu;
Lmu_=(0.5/Smu)*chi2inv(1-alpha,2*dmu+2);
Pmu_=exp(-Lmu_);
% -------------- Вывод окончательного результата -----------------
hFig=figure('Position',[ 160,130,200,300]);
hTxta=uicontrol('Style','text','String','ОКОНЧАТЕЛЬНЫЕ РЕЗУЛЬТАТЫ',...
    'Position',[45,250,110,35],'BackgroundColor',[1,0,1]);
h_TxtLs=uicontrol('Style','text','String','Ls=',...
    'Position',[45,220,35,20],'BackgroundColor',[1,1,1]);
h_TxtSmu=uicontrol('Style','text','String','Smu=',...
    'Position',[45,190,35,20],'BackgroundColor',[1,1,1]);
h_Txtdmu=uicontrol('Style','text','String','dmu=',...
    'Position',[45,160,35,20],'BackgroundColor',[1,1,1]);
hTxtLmu_=uicontrol('Style','text','String','Lmu_=',...
    'Position',[45,130,35,20],'BackgroundColor',[1,1,1]);
h_TxtPmu=uicontrol('Style','text','String','Pmu=',...
    'Position',[45,80,35,20],'BackgroundColor',[1,1,1]);
h_TxtPmu_=uicontrol('Style','text','String','Pmu_=',...
    'Position',[45,50,35,20],'BackgroundColor',[1,1,1]);

hELs=uicontrol('Style','edit','Position',[100,220,55,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hESmu=uicontrol('Style','edit','Position',[100,190,55,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEdmu=uicontrol('Style','edit','Position',[100,160,55,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hELmu_=uicontrol('Style','edit','Position',[100,130,55,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEPmu=uicontrol('Style','edit','Position',[100,80,55,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEPmu_=uicontrol('Style','edit','Position',[100,50,55,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');

set(hELs,'String',num2str(Ls));set(hESmu,'String',num2str(Smu));
set(hEdmu,'String',num2str(dmu));set(hELmu_,'String',num2str(Lmu_));
set(hEPmu,'String',num2str(Pmu));set(hEPmu_,'String',num2str(Pmu_))
