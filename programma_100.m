% Редакция ВЮЛ
% nu - число серий испытаний
% (nu-1) - число доработок
clear all;
clc;
AddOpts.Resize='on';
AddOpts.WindowStyle='normal';
AddOpts.Interpreter='tex';
prompt={'\nu=','n1=','n2=','d1=','d2=','\gamma',};
dlgTitle='Ввод данных';
lineNo=[1 9];
an=inputdlg(prompt,dlgTitle,lineNo,{'','','','','','',''},AddOpts);
nu=str2num(an{1});
n(1)=str2num(an{2});
n(2)=str2num(an{3});
d(1)=str2num(an{4});
d(2)=str2num(an{5});
gamma=str2num(an{6});
%----------------------------1------------
p1(1)=1-((d(1)+d(2))/(n(1)+n(2)));bp1(1)=1-(d(1)/n(1));bp1(2)=p1(1);
p(1)=1-(d(1)/n(1));p(2)=1-(d(2)/n(2));
bp_(1)=betainv(1-gamma,n(1)-d(1),d(1)+1);
bp_(2)=betainv(1-gamma,n(2)-d(2),d(2)+1);
bbP_(1)=betainv(1-gamma,n(1)-d(1),d(1)+1);
bbP_(2)=betainv(1-gamma,n(1)+n(2)-d(1)-d(2),d(1)+d(2)+1);
dt(1)=d(1)+d(2);nt(1)=n(1)+n(2);d_1(1)=min(dt(1),n(1));
C1(1)=nchoosek(nt(1),dt(1));
for r=d(1):d_1(1)
    x_1(1,r)=nchoosek(n(1),r)*nchoosek(n(2),d_1(1)-r);
end
C2(1)=sum(x_1);
W(1)=C2(1)/C1(1);
W12(1)=2*min(W(1),(1-W(1)));
wp(1)=W12(1)*p1(1)+(1-W12(1))*p(2);
N(1)=n(1)*W12(1)+n(2);D(1)=N(1)*(1-wp(1));
nn(1)=round(N(1));dd(1)=round(D(1));
P_1(1)=betainv(1-gamma,nn(1)-dd(1),dd(1)+1);
i=2;
j=2;
while i<=nu-1 
AddOpts.Resize='on';
AddOpts.WindowStyle='normal';
AddOpts.Interpreter='tex';
prompt={'n = ','d = '};
dlgTitle='Ввод n и d';
lineNo=[1 9];
an=inputdlg(prompt,dlgTitle,lineNo,{'',''},AddOpts);
n(i+1)=str2num(an{1})
d(i+1)=str2num(an{2})
       p1(i)=1-((dd(i-1)+d(i+1))/(nn(i-1)+n(i+1)));
       bp1(i+1)=1-(sum(d)/sum(n)); 
       p(i+1)=1-d(i+1)/n(i+1);
       bp_(i+1)=betainv(1-gamma,n(i+1)-d(i+1),d(i+1)+1);
       dt(i)=dd(i-1)+d(i+1);nt(i)=nn(i-1)+n(i+1);d_1(i)=min(dt(i),nn(i-1));
       C1(i)=nchoosek(nt(i),dt(i)); tc=0;
       if dd(i-1)==0 || d_1(i)==0
           h = msgbox('Pасчета нет!','','warn');
           break
       end
       for r=dd(i-1):d_1(i)
           x_1(j,r)=nchoosek(nn(i-1),r)*nchoosek(n(i+1),dt(i)-r);
           tc=tc+x_1(j,r);
       end
       C2(i)=tc;
       W(i)=C2(i)/C1(i);
       W12(i)=2*min(W(i),(1-W(i)));
       wp(i)=W12(i)*p1(i)+(1-W12(i))*p(i+1);
       N(i)=nn(i-1)*W12(i)+n(i+1);D(i)=N(i)*(1-wp(i));
       nn(i)=round(N(i));dd(i)=round(D(i));
       P_1(i)=betainv(1-gamma,nn(i)-dd(i),dd(i)+1);
% Графики зависимости значений 'pP' и 'pP_' от числа доработок:
if i>1
m2=1:i;
hFig=figure('Position',[200,200,600,400]);
plot(m2,wp,'o',m2,wp,'r-',m2,P_1,'s',m2,P_1,'r--',...
    'LineWidth',3,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',3);
legend('pP','pP','pP-','pP-',-1);
xlabel('Число доработок (\nu-1)','fontname','Arial Unicode MS');
ylabel('pP, pP_','fontname','Arial Unicode MS');
title('Полигонная зависимость показателей от числа доработок','fontname','Arial Unicode MS');
grid on
end
ButtonName=questdlg('Продолжить', ...
                       'Диалог', ...
                       'Да','Нет','Да');
 switch ButtonName,
     case 'Да', 
      i=i+1
      j=j+1
       continue
     case 'Нет',
      break
   end 
end
% Графики зависимости значений 'bP','bP_','bbP','bbP_','pP','pP_' от числа испытаний:
% Варианты графического представления зависимостей
jj=1;
while jj<=3
AddOpts.Resize='on';
AddOpts.WindowStyle='normal';
AddOpts.Interpreter='tex';
prompt={'dk=[1,2,3]'};
dlgTitle='Ввод данных';
lineNo=[1 9];
an=inputdlg(prompt,dlgTitle,lineNo,{''},AddOpts);
dk=str2num(an{1});
if dk==0 || dk>3
   h = msgbox('Расчета нет!','','warn');
   break
end
%------ уточнение значений bbp_ ---------------
s1=max(size(P_1));
zz=max(size(n));
for i=1:zz
    if i==1
        nm(i)=n(i);
        dm(i)=d(i);
    else
        nm(i)=nm(i-1)+n(i);
        dm(i)=dm(i-1)+d(i);
    end
end
for k=1:zz
    bbp_(k)=betainv(1-gamma,nm(k)-dm(k),dm(k)+1);
end
% графики значений 'bP','bP-','bbP','bbP-','pP','pP-'в виде полиглнов
if dk==1
for i=2:zz
    if i==2
        ntc(i-1)=n(i)+n(i-1);
    else
        ntc(i-1)=ntc(i-2)+n(i);
    end
end
for j=1:zz-1
    bps(j)=p(j+1);
    bp_s(j)=bp_(j+1);
    bbps(j)=bp1(j+1);
    bbp_s(j)=bbp_(j+1);
end
hFig=figure('Position',[200,200,600,400]);
plot(ntc,bps,'o',ntc,bps,'g-',ntc,bp_s,'s',ntc,bp_s,'g--',ntc,bbps,'o',ntc,bbps,'b-',...
    ntc,bbp_s,'s',ntc,bbp_s,'b--',ntc,wp,'o',ntc,wp,'r-',ntc,P_1,'s',ntc,P_1,'r--',...
                'LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5); grid on; hold on;
legend('bP','bP','bP-','bP-','bbP','bbP','bbP-','bbP-','pP','pP','pP-','pP-',-1);
xlabel('Число испытаний n','fontname','Arial Unicode MS');
ylabel('bP, bP, bP_, bP_, bbP, bbP, bbP_, bbP_, pP, pP, pP_, pP_,','fontname','Arial Unicode MS');
title('Полигонная зависимость показателей от числа испытаний','fontname','Arial Unicode MS');
set(gca,'LineWidth',2);
end
% графики значений 'bP','bP-','bbP','bbP-','pP','pP-' в виде ступеней
if dk==2
for i=2:zz
    if i==2
        nnn(i-1)=n(i)+n(i-1);
    else
        nnn(i-1)=nnn(i-2)+n(i);
    end
end
i=1;
j=1;
while i<=s1
    P(j)=p(i+1);
    bbP(j)=bp1(i+1);
    bP_(j)=bp_(i+1);
    bbP_(j)=bbp_(i+1);
    pP(j)=wp(i);
    pP_(j)=P_1(i);
    nn(j)=nnn(i);
    j=j+1;
    P(j)=P(j-1);
    bbP(j)=bbP(j-1);
    bbP_(j)=bbP_(j-1);
    bP_(j)=bP_(j-1);
    pP_(j)=pP_(j-1);
    pP(j)=pP(j-1);
    nn(j)=nn(j-1);
    i=i+1;
    j=j+1;
end
s2=max(size(nn));
for i=2:s2-1
    nn(i)=nn(i+1);
end
nn(s2)=nn(s2)+1;
hFig=figure('Position',[200,200,600,400]);
plot(nn,P,'g-',nn,bP_,'g--',nn,bbP,'b-',nn,bbP_,'b--',nn,pP,'r-',nn,pP_,'r--','LineWidth',2,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5); grid on; hold on;
legend('bP','bP-','bbP','bbP-','pP','pP-',-1);
xlabel('Число испытаний n','fontname','Arial Unicode MS');
ylabel('bP, bP_, bbP, bbP_, pP, pP_','fontname','Arial Unicode MS');
title('Ступенчатая зависимость показателей от числа испытаний','fontname','Arial Unicode MS');
set(gca,'LineWidth',2);
end
% графики значений bP и bP_
if dk==3
ks1=max(size(p));
i=1;
j=1;
while i<=ks1
    bP(j)=p(i);
    bP_(j)=bp_(i);
    kn(j)=nm(i);
    j=j+1;
    bP(j)=bP(j-1);
    bP_(j)=bP_(j-1);
    kn(j)=kn(j-1);
    i=i+1;
    j=j+1;
end
ks2=max(size(kn));
for i=2:ks2-1
    kn(i)=kn(i+1);
end
kn(ks2)=kn(ks2)+1;
hFig=figure('Position',[200,200,600,400]);
plot(kn,bP,'g-',kn,bP_,'g--','LineWidth',3,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','g',...
                'MarkerSize',5); grid on; hold on;
legend('bP','bP_',-1);
xlabel('Число испытаний n','fontname','Arial Unicode MS');
ylabel('Значения bP и bP_','fontname','Arial Unicode MS');
title('Стурпенчатая зависимость bP и bP_ от n','fontname','Arial Unicode MS');
set(gca,'LineWidth',2);
end
% окончание графического представления результатов
ButtonName=questdlg('Продолжить рисование ?,', ...
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
% Вывод таблицы результатов расчета.
% Назначение обозначений, использованных в таблице результатов
% (в программе):
% bP (p) -  оценка ВБР по биномиальной модели;
% bP_ (bр_) - НДГ оценки ВБР по биномиальной модели;
% bbP (bp1) - оценка ВБР по биномиальной модели с накоплением;
% bbP_ (bbp_) - НДГ оценки ВБР по биномиальной модели с накоплением;
% рР (wp) - оценка ВБР по рекуррентной биномиальной модели;
% рР_ (P_1) - НДГ оценки ВБР по рекуррентной биномиальной модели;
hFig=figure('Position',[160,130,50*zz+60,390]);
hTxta=uicontrol('Style','text','String','РЕЗУЛЬТАТЫ',...
    'Position',[(50*zz/2)-20,350,100,20],'BackgroundColor',[1,0,1]);
h_Txtn=uicontrol('Style','text','String','n=',...
    'Position',[10,275,35,19],'BackgroundColor',[1,1,1]);
h_Txtd=uicontrol('Style','text','String','d=',...
    'Position',[10,250,35,19],'BackgroundColor',[1,1,1]);
h_Txtp=uicontrol('Style','text','String','bP=',...
    'Position',[10,225,35,19],'BackgroundColor',[1,1,1]);
hTxtbp_=uicontrol('Style','text','String','bP_=',...
    'Position',[10,200,35,19],'BackgroundColor',[1,1,1]);
h_Txtbp1=uicontrol('Style','text','String','bbP=',...
    'Position',[10,175,35,19],'BackgroundColor',[1,1,1]);
hTxtbbP_=uicontrol('Style','text','String','bbP_=',...
    'Position',[10,150,35,19],'BackgroundColor',[1,1,1]);
hTxtw=uicontrol('Style','text','String','W=',...
    'Position',[10,125,35,19],'BackgroundColor',[1,1,1]);
h_Txtnn=uicontrol('Style','text','String','nn=',...
    'Position',[10,100,35,19],'BackgroundColor',[1,1,1]);
h_Txtdd=uicontrol('Style','text','String','dd=',...
    'Position',[10,75,35,19],'BackgroundColor',[1,1,1]);
h_Txtwp=uicontrol('Style','text','String','pP=',...
    'Position',[10,50,35,19],'BackgroundColor',[1,1,1]);
hTxtP_1=uicontrol('Style','text','String','pP_=',...
    'Position',[10,25,35,19],'BackgroundColor',[1,1,1]);

for i=1:max(size(n))
hEi(i)=uicontrol('Style','edit','Position',[50*i,300,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEn(i)=uicontrol('Style','edit','Position',[50*i,275,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEd(i)=uicontrol('Style','edit','Position',[50*i,250,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','center');
hEp(i)=uicontrol('Style','edit','Position',[50*i,225,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEbp_(i)=uicontrol('Style','edit','Position',[50*i,200,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEbp1(i)=uicontrol('Style','edit','Position',[50*i,175,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEbbp_(i)=uicontrol('Style','edit','Position',[50*i,150,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
end

for i=1:max(size(n))-1
hEw(i)=uicontrol('Style','edit','Position',[50+50*i,125,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEnn(i)=uicontrol('Style','edit','Position',[50+50*i,100,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEdd(i)=uicontrol('Style','edit','Position',[50+50*i,75,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEwp(i)=uicontrol('Style','edit','Position',[50+50*i,50,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
hEP_1(i)=uicontrol('Style','edit','Position',[50+50*i,25,50,20],...
    'BackgroundColor',[1,1,1],'HorizontalAlignment','left');
end
qq=[1:1:zz];
for i=1:max(size(n))
    set(hEi(i),'String',num2str(qq(i)));
    set(hEn(i),'String',num2str(n(i)));
    set(hEd(i),'String',num2str(d(i)));
    set(hEp(i),'String',num2str(p(i)));
    set(hEbp_(i),'String',num2str(bp_(i)));
    set(hEbbp_(i),'String',num2str(bbp_(i)));
    set(hEbp1(i),'String',num2str(bp1(i)));
end
for i=1:max(size(n))-1
set(hEw(i),'String',num2str(W(i)));set(hEwp(i),'String',num2str(wp(i)));
set(hEnn(i),'String',num2str(nn(i)));set(hEdd(i),'String',num2str(dd(i)));
set(hEP_1(i),'String',num2str(P_1(i)));
end
