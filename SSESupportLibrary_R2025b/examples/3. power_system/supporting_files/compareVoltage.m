ww = extractAfter(tagI, '_');
www = extractBefore(ww, '_');
busNo = str2double(www);

clear ww www

[~,b] = ismember(busNo,data1.bus(:,1));

clf
close all
tidx = find(out.Vmag.Time >= 9.9);
rel_error_V = 100*(out.Vmag.Data(tidx(1),:)'./(rateV'*1000*sqrt(2/3))-data1.bus(b,8))./data1.bus(b,8);
figure(1),bar(rel_error_V),grid
xlabel('Bus Number')
ylabel('Relative Error (%)')
title('Bus Voltage Relative Error')
figure(2),histogram(rel_error_V,50),grid
ylabel('Number of instances')
xlabel('Relative Error (%)')
title('Bus Voltage Relative Error')