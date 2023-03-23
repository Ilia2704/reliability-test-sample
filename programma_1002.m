global hEdn hEdd hEdgamma hEdP hEdP_ hEdT hEdT_
str=get(hEdn,'String');n=str2num(str);str=get(hEdd,'String');d=str2num(str);
str=get(hEdgamma,'String');gamma=str2num(str);
P=1-d/n
P_=betainv(1-gamma,n-d,d+1)
T=-1/log(P)
T_=-1/log(P_)
set(hEdP,'String',num2str(P));set(hEdP_,'String',num2str(P_));
set(hEdT,'String',num2str(T));set(hEdT_,'String',num2str(T_));
