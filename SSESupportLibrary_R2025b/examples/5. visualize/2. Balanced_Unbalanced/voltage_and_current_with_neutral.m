% Copyright (C) 2025, The MathWorks, Inc.

% assign simulated data to variables

time = Ran.V.Time;

V_Ran = Ran.V.Data;
V_Rbn = Rbn.V.Data;
V_Rcn = Rcn.V.Data;

Vmag_Ran = Ran.Vmag.Data;
Vmag_Rbn = Rbn.Vmag.Data;
Vmag_Rcn = Rcn.Vmag.Data;

Vangle_Ran = Ran.Vangle.Data;
Vangle_Rbn = Rbn.Vangle.Data;
Vangle_Rcn = Rcn.Vangle.Data;

I_Ran = Ran.I.Data;
I_Rbn = Rbn.I.Data;
I_Rcn = Rcn.I.Data;
I_n   = Iground.I.Data;

Imag_Ran = Ran.Imag.Data;
Imag_Rbn = Rbn.Imag.Data;
Imag_Rcn = Rcn.Imag.Data;
Imag_n   = Iground.Imag.Data;

Iangle_Ran = Ran.Iangle.Data;
Iangle_Rbn = Rbn.Iangle.Data;
Iangle_Rcn = Rcn.Iangle.Data;
Iangle_n   = Iground.Iangle.Data;

freq = 60; % fundamental frequency in Hz

% drawing begins here

arrow_style = 'plain';

t = linspace(0,2*pi,100); % vector of angles to draw circles

circ_radius = 1; 

x_min = -3.5; % min x coordinate for time-series
x_max = -0.5; % max x coordinate for time-series
y1 = 2.5; % y offset for voltage
y2 = -1; % y offset for current
x_off  = 2; % x offset for vectors

x_length = 333; % number of points on x-axis
x_vec = linspace(x_min,x_max,x_length); % x vector for time-series data

% create borders for time-series and vectors and create objects for
% time-series and vectors
hf = figure(1);hp = plot(circ_radius*cos(t)+x_off,circ_radius*sin(t)+y2,'k',circ_radius*cos(t)+x_off,circ_radius*sin(t)+y1,'k',...
    [x_min x_max x_max x_min x_min],[-1 -1 1 1 -1]+y1,'k',...
    [x_min x_max x_max x_min x_min],[-1 -1 1 1 -1]+y2,'k',...
    x_vec,V_Ran((1:x_length)+x_length)+y1,...
    x_vec,V_Rbn((1:x_length)+x_length)+y1,...
    x_vec,V_Rcn((1:x_length)+x_length)+y1,...
    x_vec,I_Ran((1:x_length)+x_length)-y2,...
    x_vec,I_Rbn((1:x_length)+x_length)-y2,...
    x_vec,I_Rcn((1:x_length)+x_length)-y2,...
    x_vec,I_n((1:x_length)+x_length)-y2,...
    [x_min x_max],[y1 y1],'k',[x_min x_max],[y2 y2],'k');

set(hf,'Position',[493 179 1041 781])
axis([-5 4 -3 5]),axis('equal')
ha = gca;
set(ha,'Visible','off')
set(hf,'Color',[1 1 1])

lw = 3; % line width

% set colors
set(hp(5),'LineWidth',lw,'color',[255 165 0]/255)   % phase A voltage
set(hp(6),'LineWidth',lw,'color',[0 158 115]/255)   % phase B voltage
set(hp(7),'LineWidth',lw,'color',[97 100 252]/255)  % phase C voltage
set(hp(8),'LineWidth',lw,'color',[255 165 0]/255)   % phase A current
set(hp(9),'LineWidth',lw,'color',[0 158 115]/255)   % phase B current
set(hp(10),'LineWidth',lw,'color',[97 100 252]/255) % phase C current
set(hp(11),'LineWidth',lw,'color','r')              % neutral current


h_V_Ran = annotation('arrow'); % phase A voltage vector
h_V_Rbn = annotation('arrow'); % phase B voltage vector
h_V_Rcn = annotation('arrow'); % phase C voltage vector

h_I_Ran = annotation('arrow'); % phase A current vector
h_I_Rbn = annotation('arrow'); % phase B current vector
h_I_Rcn = annotation('arrow'); % phase C current vector
h_I_Ran_c = annotation('line'); % phase A current vector that stays centred
h_I_Rbn_c = annotation('line'); % phase B current vector that stays centred
h_I_Rcn_c = annotation('line'); % phase C current vector that stays centred
h_I_n = annotation('arrow');   % neutral current vector

h_ref_VRan = annotation('line'); % dashed line for phase A voltage reference
h_ref_VRbn = annotation('line'); % dashed line for phase B voltage reference
h_ref_VRcn = annotation('line'); % dashed line for phase C voltage reference

h_ref_IRan = annotation('line'); % dashed line for phase A current reference
h_ref_IRbn = annotation('line'); % dashed line for phase A current reference
h_ref_IRcn = annotation('line'); % dashed line for phase A current reference

h_VRan = annotation('line');     % dashed line from phase A voltage time-series to vector
h_VRbn = annotation('line');     % dashed line from phase B voltage time-series to vector
h_VRcn = annotation('line');     % dashed line from phase C voltage time-series to vector

h_IRan = annotation('line');     % dashed line from phase A current time-series to vector
h_IRbn = annotation('line');     % dashed line from phase A current time-series to vector
h_IRcn = annotation('line');     % dashed line from phase A current time-series to vector
h_In = annotation('line');       % dashed line from neutral current time-series to vector

text(-4,2.5,'Phase Voltage','FontSize',14,'HorizontalAlignment','right')
text(-4,-1,'Line Current','Fontsize',14,'HorizontalAlignment','right')

hw = 10; % arrow head width

% set various properties
set(h_V_Ran,'Parent',ha,'Headstyle',arrow_style,'HeadWidth',hw,'Linewidth',lw,'Color',[255 165 0]/255);
set(h_V_Rbn,'Parent',ha,'Headstyle',arrow_style,'HeadWidth',hw,'Linewidth',lw,'Color',[0 158 115]/255);
set(h_V_Rcn,'Parent',ha,'Headstyle',arrow_style,'HeadWidth',hw,'Linewidth',lw,'Color',[97 100 252]/255);
set(h_ref_VRan,'Parent',ha,'Linewidth',1,'Color','k','LineStyle',':');
set(h_ref_VRbn,'Parent',ha,'Linewidth',1,'Color','k','LineStyle',':');
set(h_ref_VRcn,'Parent',ha,'Linewidth',1,'Color','k','LineStyle',':');
set(h_I_Ran,'Parent',ha,'Headstyle',arrow_style,'HeadWidth',hw,'Linewidth',lw,'Color',[255 165 0]/255);
set(h_I_Rbn,'Parent',ha,'Headstyle',arrow_style,'HeadWidth',hw,'Linewidth',lw,'Color',[0 158 115]/255);
set(h_I_Rcn,'Parent',ha,'Headstyle',arrow_style,'HeadWidth',hw,'Linewidth',lw,'Color',[97 100 252]/255);
set(h_I_n,'Parent',ha,'Headstyle',arrow_style,'HeadWidth',hw,'Linewidth',lw,'Color','r');
set(h_I_Ran_c,'Parent',ha,'Linewidth',2,'Color',[255 165 0]/255,'LineStyle',':');
set(h_I_Rbn_c,'Parent',ha,'Linewidth',2,'Color',[0 158 115]/255,'LineStyle',':');
set(h_I_Rcn_c,'Parent',ha,'Linewidth',2,'Color',[97 100 252]/255,'LineStyle',':');


set(h_ref_IRan,'Parent',ha,'Linewidth',1,'Color','k','LineStyle',':');
set(h_ref_IRbn,'Parent',ha,'Linewidth',1,'Color','k','LineStyle',':');
set(h_ref_IRcn,'Parent',ha,'Linewidth',1,'Color','k','LineStyle',':');
set(h_In,'Parent',ha,'Linewidth',1,'Color','r','LineStyle',':');

set(h_VRan,'Parent',ha,'Linewidth',1,'Color',[255 165 0]/255,'LineStyle',':');
set(h_VRbn,'Parent',ha,'Linewidth',1,'Color',[0 158 115]/255,'LineStyle',':');
set(h_VRcn,'Parent',ha,'Linewidth',1,'Color',[97 100 252]/255,'LineStyle',':');

set(h_IRan,'Parent',ha,'Linewidth',1,'Color',[255 165 0]/255,'LineStyle',':');
set(h_IRbn,'Parent',ha,'Linewidth',1,'Color',[0 158 115]/255,'LineStyle',':');
set(h_IRcn,'Parent',ha,'Linewidth',1,'Color',[97 100 252]/255,'LineStyle',':');


h_A = annotation('line'); % line for phase A legend
h_B = annotation('line'); % line for phase B legend
h_C = annotation('line'); % line for phase C legend

set(h_A,'Parent',ha,'Linewidth',lw,'Color',[255 165 0]/255);
set(h_B,'Parent',ha,'Linewidth',lw,'Color',[0 158 115]/255);
set(h_C,'Parent',ha,'Linewidth',lw,'Color',[97 100 252]/255);

set(h_A,'X',[-4.2 -4],'Y',[1.1 1.1]);
set(h_B,'X',[-4.2 -4],'Y',[0.9 0.9]);
set(h_C,'X',[-4.2 -4],'Y',[0.7 0.7]);

text(-4.3,1.12,'Phase A','Fontsize',12,'HorizontalAlignment','right')
text(-4.3,0.92,'Phase B','Fontsize',12,'HorizontalAlignment','right')
text(-4.3,0.72,'Phase C','Fontsize',12,'HorizontalAlignment','right')

text_offset = -1.2;

% ABC text that rotates with the voltage vectors
htVa = text(text_offset*Vmag_Ran(end)*cos(-2*pi*freq*time(end)-Vangle_Ran(end))+x_off,text_offset*Vmag_Ran(end)*sin(-2*pi*freq*time(end)-Vangle_Ran(end))+y1,'A','HorizontalAlignment','center');
htVb = text(text_offset*Vmag_Rbn(end)*cos(-2*pi*freq*time(end)-Vangle_Rbn(end))+x_off,text_offset*Vmag_Rbn(end)*sin(-2*pi*freq*time(end)-Vangle_Rbn(end))+y1,'B','HorizontalAlignment','center');
htVc = text(text_offset*Vmag_Rcn(end)*cos(-2*pi*freq*time(end)-Vangle_Rcn(end))+x_off,text_offset*Vmag_Rcn(end)*sin(-2*pi*freq*time(end)-Vangle_Rcn(end))+y1,'C','HorizontalAlignment','center');

% ABC text that rotates with the current vectors
htIa = text(text_offset*Imag_Ran(end)*cos(-2*pi*freq*time(end)-Iangle_Ran(end))+x_off,text_offset*Imag_Ran(end)*sin(-2*pi*freq*time(end)-Iangle_Ran(end))+y2,'A','HorizontalAlignment','center');
htIb = text(text_offset*Imag_Rbn(end)*cos(-2*pi*freq*time(end)-Iangle_Rbn(end))+x_off,text_offset*Imag_Rbn(end)*sin(-2*pi*freq*time(end)-Iangle_Rbn(end))+y2,'B','HorizontalAlignment','center');
htIc = text(text_offset*Imag_Rcn(end)*cos(-2*pi*freq*time(end)-Iangle_Rcn(end))+x_off,text_offset*Imag_Rcn(end)*sin(-2*pi*freq*time(end)-Iangle_Rcn(end))+y2,'C','HorizontalAlignment','center');

for l = x_length:numel(time)-x_length


    % update the voltage vectors
    set(h_V_Ran,'X',[0 -Vmag_Ran(l)*cos(-2*pi*freq*time(l)-Vangle_Ran(l))]+x_off,'Y',[0 -Vmag_Ran(l)*sin(-2*pi*freq*time(l)-Vangle_Ran(l))]+y1); 

    set(h_V_Rbn,'X',[0 -Vmag_Rbn(l)*cos(-2*pi*freq*time(l)-Vangle_Rbn(l))]+x_off,'Y',[0 -Vmag_Rbn(l)*sin(-2*pi*freq*time(l)-Vangle_Rbn(l))]+y1);

    set(h_V_Rcn,'X',[0 -Vmag_Rcn(l)*cos(-2*pi*freq*time(l)-Vangle_Rcn(l))]+x_off,'Y',[0 -Vmag_Rcn(l)*sin(-2*pi*freq*time(l)-Vangle_Rcn(l))]+y1);

    % update the voltage vector text 
    set(htVa,'Position',[text_offset*Vmag_Ran(l)*cos(-2*pi*freq*time(l)-Vangle_Ran(l))+x_off text_offset*Vmag_Ran(l)*sin(-2*pi*freq*time(l)-Vangle_Ran(l))+y1 0]);
    set(htVb,'Position',[text_offset*Vmag_Rbn(l)*cos(-2*pi*freq*time(l)-Vangle_Rbn(l))+x_off text_offset*Vmag_Rbn(l)*sin(-2*pi*freq*time(l)-Vangle_Rbn(l))+y1 0]);
    set(htVc,'Position',[text_offset*Vmag_Rcn(l)*cos(-2*pi*freq*time(l)-Vangle_Rcn(l))+x_off text_offset*Vmag_Rcn(l)*sin(-2*pi*freq*time(l)-Vangle_Rcn(l))+y1 0]);

    % update the current vector text
    set(htIa,'Position',[text_offset*Imag_Ran(l)*cos(-2*pi*freq*time(l)-Iangle_Ran(l))+x_off text_offset*Imag_Ran(l)*sin(-2*pi*freq*time(l)-Iangle_Ran(l))+y2 0]);
    set(htIb,'Position',[text_offset*Imag_Rbn(l)*cos(-2*pi*freq*time(l)-Iangle_Rbn(l))+x_off text_offset*Imag_Rbn(l)*sin(-2*pi*freq*time(l)-Iangle_Rbn(l))+y2 0]);
    set(htIc,'Position',[text_offset*Imag_Rcn(l)*cos(-2*pi*freq*time(l)-Iangle_Rcn(l))+x_off text_offset*Imag_Rcn(l)*sin(-2*pi*freq*time(l)-Iangle_Rcn(l))+y2 0]);

    % update the time-series data
    set(hp(5), 'YData',V_Ran((1:x_length)+l)+y1)
    set(hp(6), 'YData',V_Rbn((1:x_length)+l)+y1)
    set(hp(7), 'YData',V_Rcn((1:x_length)+l)+y1)
    set(hp(8), 'YData',I_Ran((1:x_length)+l)+y2)
    set(hp(9), 'YData',I_Rbn((1:x_length)+l)+y2)
    set(hp(10),'YData',I_Rcn((1:x_length)+l)+y2)
    set(hp(11),'YData',I_n((1:x_length)+l)+y2)

    % if neutral current goes less than 0.1 then remove the arrow head

    if Imag_n < 0.1
    set(h_I_n,'HeadLength',0,'HeadWidth',0)
    else
    set(h_I_n,'HeadLength',hw,'HeadWidth',hw)
    end

    % current vectors that are added

    set(h_I_Ran,'X',[0 -Imag_Ran(l)*cos(-2*pi*freq*time(l)-Iangle_Ran(l))]+x_off,'Y',[0 -Imag_Ran(l)*sin(-2*pi*freq*time(l)-Iangle_Ran(l))]+y2); % vectors
    set(h_I_n,'X',[0 -Imag_n(l)*cos(-2*pi*freq*time(l)-Iangle_n(l))]+x_off,'Y',[0 -Imag_n(l)*sin(-2*pi*freq*time(l)-Iangle_n(l))]+y2); % vectors

    xx1 = -Imag_Ran(l)*cos(-2*pi*freq*time(l)-Iangle_Ran(l)); % x coordinate of phase a tip
    yy1 = -Imag_Ran(l)*sin(-2*pi*freq*time(l)-Iangle_Ran(l)); % y coordinate of phase a tip

    set(h_I_Rbn,'X',[0 -Imag_Rbn(l)*cos(-2*pi*freq*time(l)-Iangle_Rbn(l))]+x_off+xx1,'Y',[0 -Imag_Rbn(l)*sin(-2*pi*freq*time(l)-Iangle_Rbn(l))]+y2+yy1);

    xx2 = -Imag_Rbn(l)*cos(-2*pi*freq*time(l)-Iangle_Rbn(l))+xx1; % x coordinate of phase a + b tip
    yy2 = -Imag_Rbn(l)*sin(-2*pi*freq*time(l)-Iangle_Rbn(l))+yy1; % y coordinate of phase a + b tip

    set(h_I_Rcn,'X',[0 -Imag_Rcn(l)*cos(-2*pi*freq*time(l)-Iangle_Rcn(l))]+x_off+xx2,'Y',[0 -Imag_Rcn(l)*sin(-2*pi*freq*time(l)-Iangle_Rcn(l))]+y2+yy2);

    % current vectors that stay centered at the origina
    set(h_I_Ran_c,'X',[0 -Imag_Ran(l)*cos(-2*pi*freq*time(l)-Iangle_Ran(l))]+x_off,'Y',[0 -Imag_Ran(l)*sin(-2*pi*freq*time(l)-Iangle_Ran(l))]+y2); % vectors
    set(h_I_Rbn_c,'X',[0 -Imag_Rbn(l)*cos(-2*pi*freq*time(l)-Iangle_Rbn(l))]+x_off,'Y',[0 -Imag_Rbn(l)*sin(-2*pi*freq*time(l)-Iangle_Rbn(l))]+y2);
    set(h_I_Rcn_c,'X',[0 -Imag_Rcn(l)*cos(-2*pi*freq*time(l)-Iangle_Rcn(l))]+x_off,'Y',[0 -Imag_Rcn(l)*sin(-2*pi*freq*time(l)-Iangle_Rcn(l))]+y2);


    % dashed lines on voltage vectors
    set(h_ref_VRan,'X',[0 -circ_radius*cos(-2*pi*freq*time(l))]+x_off,'Y',[0 -circ_radius*sin(-2*pi*freq*time(l))]+y1);
    set(h_ref_VRbn,'X',[0 -circ_radius*cos(-2*pi*freq*time(l)-2*pi/3)]+x_off,'Y',[0 -circ_radius*sin(-2*pi*freq*time(l)-2*pi/3)]+y1);
    set(h_ref_VRcn,'X',[0 -circ_radius*cos(-2*pi*freq*time(l)+2*pi/3)]+x_off,'Y',[0 -circ_radius*sin(-2*pi*freq*time(l)+2*pi/3)]+y1);

    % dashed lines on current vectors
    set(h_ref_IRan,'X',[0 -circ_radius*cos(-2*pi*freq*time(l))]+x_off,'Y',[0 -circ_radius*sin(-2*pi*freq*time(l))]+y2);
    set(h_ref_IRbn,'X',[0 -circ_radius*cos(-2*pi*freq*time(l)-2*pi/3)]+x_off,'Y',[0 -circ_radius*sin(-2*pi*freq*time(l)-2*pi/3)]+y2);
    set(h_ref_IRcn,'X',[0 -circ_radius*cos(-2*pi*freq*time(l)+2*pi/3)]+x_off,'Y',[0 -circ_radius*sin(-2*pi*freq*time(l)+2*pi/3)]+y2);

    % dashed lines from voltage time-series to voltage vectors
    set(h_VRan,'X',[x_max -Vmag_Ran(l)*cos(-2*pi*freq*time(l)-Vangle_Ran(l))+x_off],'Y',[V_Ran(x_length+l)+y1 V_Ran(x_length+l)+y1]);
    set(h_VRbn,'X',[x_max -Vmag_Rbn(l)*cos(-2*pi*freq*time(l)-Vangle_Rbn(l))+x_off],'Y',[V_Rbn(x_length+l)+y1 V_Rbn(x_length+l)+y1]);
    set(h_VRcn,'X',[x_max -Vmag_Rcn(l)*cos(-2*pi*freq*time(l)-Vangle_Rcn(l))+x_off],'Y',[V_Rcn(x_length+l)+y1 V_Rcn(x_length+l)+y1]);

    % dashed lines from current time-series to current vectors
    set(h_IRan,'X',[x_max -Imag_Ran(l)*cos(-2*pi*freq*time(l)-Iangle_Ran(l))+x_off],'Y',[I_Ran(x_length+l)+y2 I_Ran(x_length+l)+y2]);
    set(h_IRbn,'X',[x_max -Imag_Rbn(l)*cos(-2*pi*freq*time(l)-Iangle_Rbn(l))+x_off],'Y',[I_Rbn(x_length+l)+y2 I_Rbn(x_length+l)+y2]);
    set(h_IRcn,'X',[x_max -Imag_Rcn(l)*cos(-2*pi*freq*time(l)-Iangle_Rcn(l))+x_off],'Y',[I_Rcn(x_length+l)+y2 I_Rcn(x_length+l)+y2]);
    set(h_In,  'X',[x_max -Imag_n(l)*cos(-2*pi*freq*time(l)-Iangle_n(l))+x_off],'Y',[I_n(x_length+l)+y2 I_n(x_length+l)+y2]);

    drawnow

end
