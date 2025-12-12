% Copyright (C) 2025, The MathWorks, Inc.

close all

hf = figure(1);hold on,
hf.Position = [169 123 1046 793];
hf.Color = [1 1 1];
ha = gca;
ha.Visible = 'off';

rr = [255 128 0]/255;
gg = [107 150 61]/255;
bb = [97 189 252]/255;

g1 = igbtDV(1,1,2,'1');
g2 = igbtDV(1,-2,2,'2');
g3 = igbtDV(4,1,2,'3');
g4 = igbtDV(4,-2,2,'4');
g5 = igbtDV(7,1,2,'5');
g6 = igbtDV(7,-2,2,'6');

hclampap = patch([1.2 1.6 1.6 1.2],[3.2 3.2 3.6 3.6],'w'); % clamp indicator on arm a pos
hclampbp = patch([1.2 1.6 1.6 1.2]+3,[3.2 3.2 3.6 3.6],'w');  % clamp indicator on arm b pos
hclampcp = patch([1.2 1.6 1.6 1.2]+6,[3.2 3.2 3.6 3.6],'w');  % clamp indicator on arm c pos
hclampan = patch([1.2 1.6 1.6 1.2],-[3.2 3.2 3.6 3.6],'w'); % clamp indicator on arm a neg
hclampbn = patch([1.2 1.6 1.6 1.2]+3,-[3.2 3.2 3.6 3.6],'w');  % clamp indicator on arm b neg
hclampcn = patch([1.2 1.6 1.6 1.2]+6,-[3.2 3.2 3.6 3.6],'w');  % clamp indicator on arm c neg


hpos1 = plot([-1 7.4],[3 3],'k','Linewidth',2); % positive rail up to S1
hneg1 = plot([-1 7.4],[-3 -3],'k','Linewidth',2); % negative rail up to S1

hposs1 = plot([1.4 1.4],[2.2 3],'k','Linewidth',2); % positive rail to S1
hposs3 = plot([4.4 4.4],[2.2 3],'k','Linewidth',2); % positive rail to S3
hposs5 = plot([7.4 7.4],[2.2 3],'k','Linewidth',2); % positive rail to S3
hnegs2 = plot([1.4 1.4],[-2.2 -3],'k','Linewidth',2); % negative rail to S2
hnegs4 = plot([4.4 4.4],[-2.2 -3],'k','Linewidth',2); % negative rail to S4
hnegs6 = plot([7.4 7.4],[-2.2 -3],'k','Linewidth',2); % negative rail to S4

h_s1_aplus_vert = plot([1.4 1.4],[0.8 0.5],'k','Linewidth',2); % S1 to a+ vertical
h_s2_aplus_vert = plot([1.4 1.4],[-0.8 0.5],'k','Linewidth',2); % S2 to a+ vertical

h_arm1_aplus_horiz1 = plot([1.4 4.3],[0.5 0.5],'r','Linewidth',2); % arm1 to a+ horizontal
h_arm1_aplus_horiz2 = plot([4.5 7.3],[0.5 0.5],'r','Linewidth',2); % arm1 to a+ horizontal
h_arm1_aplus_horiz3 = plot([7.5 8.5],[0.5 0.5],'r','Linewidth',2); % arm1 to a+ horizontal

h_s3_aminus_vert = plot([4.4 4.4],[0.8 0],'k','Linewidth',2); % S3 to a- vertical
h_s4_aminus_vert = plot([4.4 4.4],[-0.8 0],'k','Linewidth',2); % S4 to a- vertical
h_arm2_aminus_horiz1 = plot([4.4 7.3],[0 0],'g','Linewidth',2); % arm2 to a- horizontal
h_arm2_aminus_horiz2 = plot([7.5 8.5],[0 0],'g','Linewidth',2); % arm2 to a- horizontal

h_s5_aminus_vert = plot([7.4 7.4],[0.8 -0.5],'k','Linewidth',2); % S5 to a- vertical
h_s6_aminus_vert = plot([7.4 7.4],[-0.8 -0.5],'k','Linewidth',2); % S6 to a- vertical
h_arm3_aminus_horiz = plot([7.4 8.5],[-0.5 -0.5],'b','Linewidth',2); % arm2 to a- horizontal

axis('equal')
axis([-2 19 -6 6])

plot([17.5 18],[4.5 4.5],'Color','r','LineWidth',3)
plot([17.5 18],[3.5 3.5],'Color',rr,'LineWidth',3)
text(18.2,4.5,'VAN','Fontweight','bold','FontSize',12)
text(18.2,3.5,'IA','Fontweight','bold','FontSize',12)

plot([17.5 18],[0.5 0.5],'Color','g','LineWidth',3)
plot([17.5 18],[-0.5 -0.5],'Color',gg,'LineWidth',3)
text(18.2,0.5,'VBN','Fontweight','bold','FontSize',12)
text(18.2,-0.5,'IB','Fontweight','bold','FontSize',12)

plot([17.5 18],[-3.5 -3.5],'Color','b','LineWidth',3)
plot([17.5 18],[-4.5 -4.5],'Color',bb,'LineWidth',3)
text(18.2,-3.5,'VCN','Fontweight','bold','FontSize',12)
text(18.2,-4.5,'IC','Fontweight','bold','FontSize',12)

names = getElementNames(out.logsout);

nv = numel(out.logsout{2}.Values.Time);

ID1 = abs(reshape(out.logsout{find(ismember(names,'ID1'))}.Values.Data,1,nv)); %#ok<*FNDSB>
IS1 = abs(reshape(out.logsout{find(ismember(names,'IS1'))}.Values.Data,1,nv));
ID2 = abs(reshape(out.logsout{find(ismember(names,'ID2'))}.Values.Data,1,nv));
IS2 = abs(reshape(out.logsout{find(ismember(names,'IS2'))}.Values.Data,1,nv));
ID3 = abs(reshape(out.logsout{find(ismember(names,'ID3'))}.Values.Data,1,nv));
IS3 = abs(reshape(out.logsout{find(ismember(names,'IS3'))}.Values.Data,1,nv));
ID4 = abs(reshape(out.logsout{find(ismember(names,'ID4'))}.Values.Data,1,nv));
IS4 = abs(reshape(out.logsout{find(ismember(names,'IS4'))}.Values.Data,1,nv));
ID5 = abs(reshape(out.logsout{find(ismember(names,'ID5'))}.Values.Data,1,nv));
IS5 = abs(reshape(out.logsout{find(ismember(names,'IS5'))}.Values.Data,1,nv));
ID6 = abs(reshape(out.logsout{find(ismember(names,'ID6'))}.Values.Data,1,nv));
IS6 = abs(reshape(out.logsout{find(ismember(names,'IS6'))}.Values.Data,1,nv));

pwm1 = out.logsout{find(ismember(names,'pwm'))}.Values.Data(:,1);
pwm2 = out.logsout{find(ismember(names,'pwm'))}.Values.Data(:,2);
pwm3 = out.logsout{find(ismember(names,'pwm'))}.Values.Data(:,3);
pwm4 = out.logsout{find(ismember(names,'pwm'))}.Values.Data(:,4);
pwm5 = out.logsout{find(ismember(names,'pwm'))}.Values.Data(:,5);
pwm6 = out.logsout{find(ismember(names,'pwm'))}.Values.Data(:,6);

mod1 = out.logsout{find(ismember(names,'mod'))}.Values.Data(:,1);
mod2 = out.logsout{find(ismember(names,'mod'))}.Values.Data(:,2);
mod3 = out.logsout{find(ismember(names,'mod'))}.Values.Data(:,3);

VABC = 1.5*reshape(out.logsout{find(ismember(names,'Vabc'))}.Values.Data,3,nv);
IABC = 1.5*reshape(out.logsout{find(ismember(names,'Iabc'))}.Values.Data,3,nv);

VAB = VABC(1,:);
VBC = VABC(2,:);
VCA = VABC(3,:);

IA = IABC(1,:);
IB = IABC(2,:);
IC = IABC(3,:);


lt = 1000;

xta = linspace(9.5,17,lt);
plot([xta(1) xta(end)],[4 4],'k')
plot([xta(1) xta(end)],[0 0],'k')
plot([xta(1) xta(end)],[-4 -4],'k')
hvab = plot(xta,VAB(1:lt)+4 ,'LineWidth',1,'Color','r');
hvbc = plot(xta,VBC(1:lt) ,'LineWidth',1,'Color','g');
hvca = plot(xta,VCA(1:lt)-4 ,'LineWidth',1,'Color','b');
hia = plot(xta,IA(1:lt)+4 ,'LineWidth',1.5,'Color',rr);
hib = plot(xta,IB(1:lt) ,'LineWidth',1.5,'Color',gg);
hic = plot(xta,IC(1:lt)-4 ,'LineWidth',1.5,'Color',bb);
xtad = xta(2)-xta(1);

for l = 1:1:numel(ID1)-lt


if l <= lt

    set(hvab,'XData',linspace(xta(1),xta(1)+l*xtad(1),l),'YData',VAB(1:l)+4)
    set(hvbc,'XData',linspace(xta(1),xta(1)+l*xtad(1),l),'YData',VBC(1:l))
    set(hvca,'XData',linspace(xta(1),xta(1)+l*xtad(1),l),'YData',VCA(1:l)-4)
    
    set(hia,'XData',linspace(xta(1),xta(1)+l*xtad(1),l),'YData',IA(1:l)+4)
    set(hib,'XData',linspace(xta(1),xta(1)+l*xtad(1),l),'YData',IB(1:l))
    set(hic,'XData',linspace(xta(1),xta(1)+l*xtad(1),l),'YData',IC(1:l)-4)

elseif l > lt


    set(hvab,'XData',xta,'YData',VAB((1:lt)+l)+4)
    set(hvbc,'XData',xta,'YData',VBC((1:lt)+l))
    set(hvca,'XData',xta,'YData',VCA((1:lt)+l)-4)
    
    set(hia,'XData',xta,'YData',IA((1:lt)+l)+4)
    set(hib,'XData',xta,'YData',IB((1:lt)+l))
    set(hic,'XData',xta,'YData',IC((1:lt)+l)-4)

end

ithresh = 1e-3;

if mod1(l) == 1
    hclampap.FaceColor = 'k';
else
    hclampap.FaceColor = 'w';
end

if mod1(l) == -1
    hclampan.FaceColor = 'k';
else
    hclampan.FaceColor = 'w';
end


if mod2(l) == 1
    hclampbp.FaceColor = 'k';
else
    hclampbp.FaceColor = 'w';
end

if mod2(l) == -1
    hclampbn.FaceColor = 'k';
else
    hclampbn.FaceColor = 'w';
end


if mod3(l) == 1
    hclampcp.FaceColor = 'k';
else
    hclampcp.FaceColor = 'w';
end

if mod3(l) == -1
    hclampcn.FaceColor = 'k';
else
    hclampcn.FaceColor = 'w';
end


if pwm1(l) >= ithresh
    g1.ts.Color = 'r';
elseif pwm1(l) < ithresh
    g1.ts.Color = 'k';
end    
if pwm2(l) >= ithresh
    g2.ts.Color = 'r';
elseif pwm2(l) < ithresh
    g2.ts.Color = 'k';
end    
if pwm3(l) >= ithresh
    g3.ts.Color = 'g';
elseif pwm3(l) < ithresh
    g3.ts.Color = 'k';
end    
if pwm4(l) >= ithresh
    g4.ts.Color = 'g';
elseif pwm4(l) < ithresh
    g4.ts.Color = 'k';
end    
if pwm5(l) >= ithresh
    g5.ts.Color = 'b';
elseif pwm5(l) < ithresh
    g5.ts.Color = 'k';
end    
if pwm6(l) >= ithresh
    g6.ts.Color = 'b';
elseif pwm6(l) < ithresh
    g6.ts.Color = 'k';
end    



    if ID1(l) > ithresh

        g1.d(1).Color = 'r';
        g1.d(2).Color = 'r';
        g1.d(3).Color = 'r';
        g1.d(4).Color = 'r';
        g1.d(5).Color = 'r';
        g1.d(6).Color = 'r';
        g1.d(7).Color = 'r';
        g1.d(8).Color = 'r';
        g1.td.Color = 'r';
        
    elseif ID1(l) < ithresh

        g1.d(1).Color = 'k';
        g1.d(2).Color = 'k';
        g1.d(3).Color = 'k';
        g1.d(4).Color = 'k';
        g1.d(5).Color = 'k';
        g1.d(6).Color = 'k';
        g1.d(7).Color = 'k';
        g1.d(8).Color = 'k';
        g1.td.Color = 'k';
        
    end

    if ID2(l) > ithresh

        g2.d(1).Color = 'r';
        g2.d(2).Color = 'r';
        g2.d(3).Color = 'r';
        g2.d(4).Color = 'r';
        g2.d(5).Color = 'r';
        g2.d(6).Color = 'r';
        g2.d(7).Color = 'r';
        g2.d(8).Color = 'r';
        g2.td.Color = 'r';
        
    elseif ID2(l) < ithresh

        g2.d(1).Color = 'k';
        g2.d(2).Color = 'k';
        g2.d(3).Color = 'k';
        g2.d(4).Color = 'k';
        g2.d(5).Color = 'k';
        g2.d(6).Color = 'k';
        g2.d(7).Color = 'k';
        g2.d(8).Color = 'k';
        g2.td.Color = 'k';
        
    end
    if ID3(l) > ithresh

        g3.d(1).Color = 'g';
        g3.d(2).Color = 'g';
        g3.d(3).Color = 'g';
        g3.d(4).Color = 'g';
        g3.d(5).Color = 'g';
        g3.d(6).Color = 'g';
        g3.d(7).Color = 'g';
        g3.d(8).Color = 'g';
        g3.td.Color = 'g';
        
    elseif ID3(l) < ithresh

        g3.d(1).Color = 'k';
        g3.d(2).Color = 'k';
        g3.d(3).Color = 'k';
        g3.d(4).Color = 'k';
        g3.d(5).Color = 'k';
        g3.d(6).Color = 'k';
        g3.d(7).Color = 'k';
        g3.d(8).Color = 'k';
        g3.td.Color = 'k';
        
    end

    if ID4(l) > ithresh

        g4.d(1).Color = 'g';
        g4.d(2).Color = 'g';
        g4.d(3).Color = 'g';
        g4.d(4).Color = 'g';
        g4.d(5).Color = 'g';
        g4.d(6).Color = 'g';
        g4.d(7).Color = 'g';
        g4.d(8).Color = 'g';
        g4.td.Color = 'g';
        
    elseif ID4(l) < ithresh

        g4.d(1).Color = 'k';
        g4.d(2).Color = 'k';
        g4.d(3).Color = 'k';
        g4.d(4).Color = 'k';
        g4.d(5).Color = 'k';
        g4.d(6).Color = 'k';
        g4.d(7).Color = 'k';
        g4.d(8).Color = 'k';
        g4.td.Color = 'k';
    end

    if ID5(l) > ithresh

        g5.d(1).Color = 'b';
        g5.d(2).Color = 'b';
        g5.d(3).Color = 'b';
        g5.d(4).Color = 'b';
        g5.d(5).Color = 'b';
        g5.d(6).Color = 'b';
        g5.d(7).Color = 'b';
        g5.d(8).Color = 'b';
        g5.td.Color = 'b';
        
    elseif ID5(l) < ithresh

        g5.d(1).Color = 'k';
        g5.d(2).Color = 'k';
        g5.d(3).Color = 'k';
        g5.d(4).Color = 'k';
        g5.d(5).Color = 'k';
        g5.d(6).Color = 'k';
        g5.d(7).Color = 'k';
        g5.d(8).Color = 'k';
        g5.td.Color = 'k';
    end

    if ID6(l) > ithresh

        g6.d(1).Color = 'b';
        g6.d(2).Color = 'b';
        g6.d(3).Color = 'b';
        g6.d(4).Color = 'b';
        g6.d(5).Color = 'b';
        g6.d(6).Color = 'b';
        g6.d(7).Color = 'b';
        g6.d(8).Color = 'b';
        g6.td.Color = 'b';
        
    elseif ID6(l) < ithresh

        g6.d(1).Color = 'k';
        g6.d(2).Color = 'k';
        g6.d(3).Color = 'k';
        g6.d(4).Color = 'k';
        g6.d(5).Color = 'k';
        g6.d(6).Color = 'k';
        g6.d(7).Color = 'k';
        g6.d(8).Color = 'k';
        g6.td.Color = 'k';
        
    end

%%%%%%%%%%%%%%%%

    if IS1(l) > ithresh

        g1.m(1).Color = 'r';
        g1.m(2).Color = 'r';
        g1.m(3).Color = 'r';
        g1.m(4).Color = 'r';
        g1.m(5).Color = 'r';
        g1.m(6).Color = 'r';
        g1.m(7).Color = 'r';
        g1.m(8).Color = 'r';
        g1.m(9).Color = 'r';
       
    elseif IS1(l) < ithresh

        g1.m(1).Color = 'k';
        g1.m(2).Color = 'k';
        g1.m(3).Color = 'k';
        g1.m(4).Color = 'k';
        g1.m(5).Color = 'k';
        g1.m(6).Color = 'k';
        g1.m(7).Color = 'k';
        g1.m(8).Color = 'k';
        g1.m(9).Color = 'k';
        
    end

    if IS2(l) > ithresh

        g2.m(1).Color = 'r';
        g2.m(2).Color = 'r';
        g2.m(3).Color = 'r';
        g2.m(4).Color = 'r';
        g2.m(5).Color = 'r';
        g2.m(6).Color = 'r';
        g2.m(7).Color = 'r';
        g2.m(8).Color = 'r';
        g2.m(9).Color = 'r';
        
    elseif IS2(l) < ithresh

        g2.m(1).Color = 'k';
        g2.m(2).Color = 'k';
        g2.m(3).Color = 'k';
        g2.m(4).Color = 'k';
        g2.m(5).Color = 'k';
        g2.m(6).Color = 'k';
        g2.m(7).Color = 'k';
        g2.m(8).Color = 'k';
        g2.m(9).Color = 'k';
        
    end

    if IS3(l) > ithresh

        g3.m(1).Color = 'g';
        g3.m(2).Color = 'g';
        g3.m(3).Color = 'g';
        g3.m(4).Color = 'g';
        g3.m(5).Color = 'g';
        g3.m(6).Color = 'g';
        g3.m(7).Color = 'g';
        g3.m(8).Color = 'g';
        g3.m(9).Color = 'g';
        
    elseif IS3(l) < ithresh

        g3.m(1).Color = 'k';
        g3.m(2).Color = 'k';
        g3.m(3).Color = 'k';
        g3.m(4).Color = 'k';
        g3.m(5).Color = 'k';
        g3.m(6).Color = 'k';
        g3.m(7).Color = 'k';
        g3.m(8).Color = 'k';
        g3.m(9).Color = 'k';
        
    end

    if IS4(l) > ithresh

        g4.m(1).Color = 'g';
        g4.m(2).Color = 'g';
        g4.m(3).Color = 'g';
        g4.m(4).Color = 'g';
        g4.m(5).Color = 'g';
        g4.m(6).Color = 'g';
        g4.m(7).Color = 'g';
        g4.m(8).Color = 'g';
        g4.m(9).Color = 'g';
        
    elseif IS4(l) < ithresh

        g4.m(1).Color = 'k';
        g4.m(2).Color = 'k';
        g4.m(3).Color = 'k';
        g4.m(4).Color = 'k';
        g4.m(5).Color = 'k';
        g4.m(6).Color = 'k';
        g4.m(7).Color = 'k';
        g4.m(8).Color = 'k';
        g4.m(9).Color = 'k';
        
    end

    if IS5(l) > ithresh

        g5.m(1).Color = 'b';
        g5.m(2).Color = 'b';
        g5.m(3).Color = 'b';
        g5.m(4).Color = 'b';
        g5.m(5).Color = 'b';
        g5.m(6).Color = 'b';
        g5.m(7).Color = 'b';
        g5.m(8).Color = 'b';
        g5.m(9).Color = 'b';
        
    elseif IS5(l) < ithresh

        g5.m(1).Color = 'k';
        g5.m(2).Color = 'k';
        g5.m(3).Color = 'k';
        g5.m(4).Color = 'k';
        g5.m(5).Color = 'k';
        g5.m(6).Color = 'k';
        g5.m(7).Color = 'k';
        g5.m(8).Color = 'k';
        g5.m(9).Color = 'k';
        
    end

    if IS6(l) > ithresh

        g6.m(1).Color = 'b';
        g6.m(2).Color = 'b';
        g6.m(3).Color = 'b';
        g6.m(4).Color = 'b';
        g6.m(5).Color = 'b';
        g6.m(6).Color = 'b';
        g6.m(7).Color = 'b';
        g6.m(8).Color = 'b';
        g6.m(9).Color = 'b';
        
    elseif IS6(l) < ithresh

        g6.m(1).Color = 'k';
        g6.m(2).Color = 'k';
        g6.m(3).Color = 'k';
        g6.m(4).Color = 'k';
        g6.m(5).Color = 'k';
        g6.m(6).Color = 'k';
        g6.m(7).Color = 'k';
        g6.m(8).Color = 'k';
        g6.m(9).Color = 'k';
        
    end
    
%%%%%%%%%%%%

if IS1(l) >= ithresh || ID1(l) >= ithresh 

    hposs1.Color = 'r';
    h_s1_aplus_vert.Color = 'r';

elseif IS1(l) < ithresh && ID1(l) < ithresh 
    
    hposs1.Color = 'k';
    h_s1_aplus_vert.Color = 'k';
    
end

if IS2(l) >= ithresh || ID2(l) >= ithresh 

    hnegs2.Color = 'r';
    h_s2_aplus_vert.Color = 'r';

elseif IS2(l) < ithresh && ID2(l) < ithresh 
    
    hnegs2.Color = 'k';
    h_s2_aplus_vert.Color = 'k';
    
end

if IS3(l) >= ithresh || ID3(l) >= ithresh 

    hposs3.Color = 'g';
    h_s3_aminus_vert.Color = 'g';

elseif IS3(l) < ithresh && ID3(l) < ithresh 
    
    hposs3.Color = 'k';
    h_s3_aminus_vert.Color = 'k';
    
end

if IS4(l) >= ithresh || ID4(l) >= ithresh 

    hnegs4.Color = 'g';
    h_s4_aminus_vert.Color = 'g';
    

elseif IS4(l) < ithresh && ID4(l) < ithresh 
    
    hnegs4.Color = 'k';
    h_s4_aminus_vert.Color = 'k';
    
end
if IS5(l) >= ithresh || ID5(l) >= ithresh 

    hposs5.Color = 'b';
    h_s5_aminus_vert.Color = 'b';

elseif IS5(l) < ithresh && ID5(l) < ithresh 
    
    hposs5.Color = 'k';
    h_s5_aminus_vert.Color = 'k';
    
end

if IS6(l) >= ithresh || ID6(l) >= ithresh 

    hnegs6.Color = 'b';
    h_s6_aminus_vert.Color = 'b';
    

elseif IS6(l) < ithresh && ID6(l) < ithresh 
    
    hnegs6.Color = 'k';
    h_s6_aminus_vert.Color = 'k';
    
end

pause(0.002)
drawnow

end

