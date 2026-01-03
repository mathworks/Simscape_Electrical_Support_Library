%% Rotating and Fixed Frame ABC Visualization
% Copyright © 2025, The MathWorks, Inc.
% 
% 
%% Introduction
% In this tutorial, we will explore using MATLAB Handle Graphics to enhance 
% the output of simulations in Simscape Electrical. We consider rotating frame and fixed-frame in this example.
% 
% 
%% Three-Phase System
% Open the following model that contains a balanced three-phase system feeding 
% a resistive load, with a nominal frequency of 60Hz. Save the simulated data 
% in new variables for ease of use. 

open_system('three_phase_01')
out = sim('three_phase_01');

time  = squeeze(out.theta.Time);
nt = numel(time);

theta = squeeze(out.theta.Data);
Vabc = squeeze(out.Vabc.Data)';
Vclarke = out.Vclarke.Data;
Van = Vabc(:,1);
Vbn = Vabc(:,2);
Vcn = Vabc(:,3);
Valpha = Vclarke(:,1);
Vbeta = Vclarke(:,2);


%% 
% We'll now use MATLAB Handle Graphics to build a visualization of three-phase 
% voltage.
% 
% Start by creating a figure window, and include the figure handle. Then add 
% axes using gca (get current axes), and include the handle to the axes.

close all % close existing figures
clf
hf = figure(1);
ha = gca;
ha.YDir = 'normal';
axis('square')
ha.XColor = [1 1 1];
ha.YColor = [1 1 1];
%
% On the right you can see some of the properties of both hf and ha
% 
% The figure and the axes are objects and hf and ha allows us to access and 
% modify the object properties. For example, to change the color of the figure 
% to all white, we can use dot notation or the set command.

hf.Color = 'w';

hva = annotation('arrow');

xDefault = hva.X;
yDefault = hva.Y;
parentDefault = hva.Parent;

hva.Parent = ha;
hva.X = [0 0];
hva.Y = [0 8];

hva.X = [0 1];
hva.Y = [0 0];

hold on
thc = linspace(0,2*pi,100); % angle for circle
plot(cos(thc),sin(thc),'k','LineWidth',0.3)

co = 4; % offset for fixed reference frame
co2 = 10; % offset for Clarke reference frame

plot(cos(thc)+co,sin(thc),'k','LineWidth',0.3)
plot([0 0]+co,[0 1],'k:','LineWidth',0.3)

plot(cos(thc)+co2,sin(thc),'k','LineWidth',0.3)
plot([0 0]+co2,[0 1],'k:','LineWidth',0.3)

plot([0 sin(2*pi/3)]+co,[0 cos(2*pi/3)],'k:','LineWidth',0.3)
plot([0 -sin(2*pi/3)]+co,[0 cos(2*pi/3)],'k:','LineWidth',0.3)
plot([0 0]+co,[0 1],'k:','LineWidth',0.3)

plot([0 sin(pi/2)]+co2,[0 cos(pi/2)],'k:','LineWidth',0.3)
plot([0 0]+co2,[0 1],'k:','LineWidth',0.3)

set(hva,'LineWidth',1,'Color','r','HeadStyle','hypocycloid')

hvb = annotation('arrow','Color','g','HeadStyle','hypocycloid','LineWidth',1);
hvb.Parent = ha;
hvb.X = [0 cos(theta(1)-2*pi/3)];
hvb.Y = [0 sin(theta(1)-2*pi/3)];

hvc = annotation('arrow','Color','b','HeadStyle','hypocycloid','LineWidth',1);
hvc.Parent = ha;
hvc.X = [0 cos(theta(1)+2*pi/3)];
hvc.Y = [0 sin(theta(1)+2*pi/3)];

% add arrows for fixed reference frame

hva1 = annotation('arrow','Color','r','HeadStyle','hypocycloid','LineWidth',1);
hva1.Parent = ha;
hva1.X = [0 0]+co;
hva1.Y = [0 1];

hs = annotation('arrow','Color','k','HeadStyle','hypocycloid','LineWidth',1);
hs.Parent = ha;
hs.X = [0 0];
hs.Y = [0 1];

hs1 = annotation('arrow','Color','k','HeadStyle','hypocycloid','LineWidth',1);
hs1.Parent = ha;
hs1.X = [0 0]+co;
hs1.Y = [0 1];

hs2 = annotation('arrow','Color','k','HeadStyle','hypocycloid','LineWidth',1);
hs2.Parent = ha;
hs2.X = [0 0]+co2;
hs2.Y = [0 1];

hvb1 = annotation('arrow','Color','g','HeadStyle','hypocycloid','LineWidth',1);
hvb1.Parent = ha;
hvb1.X = [0 sin(2*pi/3)]+co;
hvb1.Y = [0 cos(2*pi/3)];

hvc1 = annotation('arrow','Color','b','HeadStyle','hypocycloid','LineWidth',1);
hvc1.Parent = ha;
hvc1.X = [0 sin(-2*pi/3)]+co;
hvc1.Y = [0 cos(-2*pi/3)];
axis([-5 21 -1.5 1.5],'equal')

hvalpha = annotation('arrow','Color',[192 0 0]/255,'HeadStyle','hypocycloid','LineWidth',1);
hvalpha.Parent = ha;
hvalpha.X = [0 0]+co2;
hvalpha.Y = [0 1];

hvbeta = annotation('arrow','Color',[0 75 135]/255,'HeadStyle','hypocycloid','LineWidth',1);
hvbeta.Parent = ha;
hvbeta.X = [0 sin(pi/2)]+co2;
hvbeta.Y = [0 cos(pi/2)];

al = 4.5; % axis length
plot([-al 0],[0 0],'k:')
plot([0 al*cosd(120)]+co,[0 -al*sind(120)],'k:')
plot([0 al*cosd(-120)]+co,[0 -al*sind(-120)],'k:')
plot([0 al*cosd(0)]+co,[0 -al*sind(0)],'k:')

plot([0 al*cosd(0)]+co2,[0 -al*sind(0)],'k:')
plot([0 al*cosd(90)]+co2,[0 -al*sind(90)],'k:')

%%
% We'll now add a time-series plot to the left of the vectors. Set up the x-axis 
% location of the time-series window, and decide how many time-steps you need 
% in the x-axis.

time_window = 667;

xaxis = linspace(-4.5,-1.5,time_window);

hvat = plot(xaxis,Van(1:time_window),'r','LineWidth',1);
axis([-5 16 -5 5],'equal')

% set up xaxis for fixed reference frame where we will rotate the
% time-series plots

xaxis1 = linspace(0,3,time_window);

hvat1 = plot(xaxis1+co+1.2,Van(1:time_window),'r','LineWidth',1);
hvalphat = plot(xaxis1+co2+1.3,Valpha(1:time_window),'Color',[192 0 0]/255,'LineWidth',1);

% rotate the b- and c-axes time-series plots for fixed-frame

thbr = -120;                     
Rb = [cosd(thbr) -sind(thbr);  
     sind(thbr)  cosd(thbr)];

thcr = 120;                      
Rc = [cosd(thcr) -sind(thcr);   
     sind(thcr)  cosd(thcr)];

xyb = Rb * [xaxis1; Vbn(1:time_window)']; 
xyc = Rc * [xaxis1; Vcn(1:time_window)']; 

hvbt1 = plot(xyb(1,:)+co+1.2*cosd(-120), xyb(2,:)+1.2*sind(-120), 'g');
hvct1 = plot(xyc(1,:)+co+1.2*cosd(120), xyc(2,:)-1.2*sind(-120), 'b');

% rotate the beta axis

thbeta = -90;                     
Rbeta = [cosd(thbeta) -sind(thbeta);  
     sind(thbeta)  cosd(thbeta)];

xybeta = Rbeta * [xaxis1; Vbeta(1:time_window)']; 

hvbetat = plot(xybeta(1,:)+co2+1.2*cosd(thbeta), xybeta(2,:)+1.2*sind(thbeta),'Color',[0 75 135]/255);


%% 
% Add phase B and C time-series and add a line for the x-axis

hvbt = plot(xaxis,Vbn(1:time_window),'g','LineWidth',1);
hvct = plot(xaxis,Vcn(1:time_window),'b','LineWidth',1);
%% 
% Next add dashed lines between the arrow heads of the vectors and the time-series 
% data. This is useful for clarifying that the vectors and time-series are matching 
% at a given time instant

hvacl = plot([xaxis(end) hva.X(2)],[hva.Y(2) hva.Y(2)],'r:');
hvbcl = plot([xaxis(end) hvb.X(2)],[hvb.Y(2) hvb.Y(2)],'g:');
hvccl = plot([xaxis(end) hvc.X(2)],[hvc.Y(2) hvc.Y(2)],'b:');

hvacl1 = plot([0 1.2]+co,[hvat1.YData(1) hvat1.YData(1)],'r:');
hvbcl1 = plot([hvb1.X(2) hvbt1.XData(1)],[hvb1.X(2) hvbt1.XData(1)],'g:');
hvccl1 = plot([hvc1.X(2) hvct1.XData(1)],[hvc1.X(2) hvct1.XData(1)],'b:');

hvalphal1 = plot([0 1.25]+co2,[hvalphat.YData(1) hvalphat.YData(1)],'Color',[192 0 0]/255,'LineStyle',':');
hvbetal1 = plot([hvbetat.XData(1) hvbetat.XData(1)],[0 -1.2],'Color',[0 75 135]/255,'LineStyle',':');


%% 

hat = text(1.2*cos(theta(1)),1.2*sin(theta(1)),'A','HorizontalAlignment','center');
hbt = text(1.2*cos(theta(1)-2*pi/3),1.2*sin(theta(1)-2*pi/3),'B','HorizontalAlignment','center');
hct = text(1.2*cos(theta(1)+2*pi/3),1.2*sin(theta(1)+2*pi/3),'C','HorizontalAlignment','center');

hat1 = text(co,1.2,'A','HorizontalAlignment','center');
hbt1 = text(1.2*sin(-2*pi/3)+co,1.2*cos(-2*pi/3),'C','HorizontalAlignment','center');
hct1 = text(1.2*sin(+2*pi/3)+co,1.2*cos(+2*pi/3),'B','HorizontalAlignment','center');

hat2 = text(co2,1.2,'\alpha','HorizontalAlignment','center');
hbt2 = text(co2+1.15,-0.2,'\beta','HorizontalAlignment','center');

for x = 1:nt-time_window

    hva.X = [0 cos(theta(x))];
    hva.Y = [0 sin(theta(x))];
   
    hva1.Y = [0 hva.Y(2)];
    
    hvalpha.Y = [0 hvalphat.YData(1)];
    hvbeta.X = [0 Vbeta(time_window+x)]+co2;

    hvb1.X = [0 hvb.Y(2)*sin(2*pi/3)]+co;
    hvb1.Y = [0 hvb.Y(2)*cos(2*pi/3)];
    
    hvc1.X = [0 hvc.Y(2)*sin(-2*pi/3)]+co;
    hvc1.Y = [0 hvc.Y(2)*cos(-2*pi/3)];
    
    hvb.X = [0 cos(theta(x)-2*pi/3)];
    hvb.Y = [0 sin(theta(x)-2*pi/3)];
    
    hvc.X = [0 cos(theta(x)+2*pi/3)];
    hvc.Y = [0 sin(theta(x)+2*pi/3)];

    hs1.X = [0 cos(theta(x)+pi)]+co;
    hs1.Y = [0 -sin(theta(x)+pi)];
    
    hs2.X = [0 cos(theta(x)+pi)]+co2;
    hs2.Y = [0 -sin(theta(x)+pi)];
    

    hvacl.XData = [xaxis(end) hva.X(2)];
    hvacl.YData = [hva.Y(2) hva.Y(2)];
    
    hvacl1.XData = [hva1.X(2) hvat1.XData(1)];
    hvacl1.YData = [hva1.Y(2) hvat1.YData(1)];
    
    hvbcl1.XData = [hvb1.X(2) hvbt1.XData(1)];
    hvbcl1.YData = [hvb1.Y(2) hvbt1.YData(1)];
    
    hvccl1.XData = [hvc1.X(2) hvct1.XData(1)];
    hvccl1.YData = [hvc1.Y(2) hvct1.YData(1)];
    
    hvbcl.XData = [xaxis(end) hvb.X(2)];
    hvbcl.YData = [hvb.Y(2) hvb.Y(2)];
    
    hvccl.XData = [xaxis(end) hvc.X(2)];
    hvccl.YData = [hvc.Y(2) hvc.Y(2)];
    
    hvalphal1.YData = [hvalpha.Y(2) hvalpha.Y(2)];
    hvbetal1.XData = [hvbetat.XData(1) hvbetat.XData(1)];

    hvat.YData = Van((1:time_window)+x);
    hvat1.YData = flipud(Van((1:time_window)+x));
   
    hvalphat.YData = flipud(Valpha((1:time_window)+x));
    
    hvbt.YData = Vbn((1:time_window)+x);
    hvct.YData = Vcn((1:time_window)+x);

    xyb = Rb * [xaxis1; flipud(Vbn((1:time_window)+x))'];
    xyc = Rc * [xaxis1; flipud(Vcn((1:time_window)+x))'];
    hvbt1.XData = xyb(1,:)+co+1.2*cosd(-120);
    hvbt1.YData = xyb(2,:)+1.2*sind(-120);

    hvct1.XData = xyc(1,:)+co+1.2*cosd(120);
    hvct1.YData = xyc(2,:)-1.2*sind(-120);

    xybeta = Rbeta * [xaxis1; flipud(Vbeta((1:time_window)+x))'];
    hvbetat.XData = xybeta(1,:)+co2+1.2*cosd(90);
    hvbetat.YData = xybeta(2,:)-1.2*sind(90);
    

    hat.Position = 1.2*[cos(theta(x)) sin(theta(x)) 0];
    hbt.Position = 1.2*[cos(theta(x)-2*pi/3) sin(theta(x)-2*pi/3) 0];
    hct.Position = 1.2*[cos(theta(x)+2*pi/3) sin(theta(x)+2*pi/3) 0];
   
    drawnow
    pause(0.1)

end
%% 
% END OF TUTORIAL 03