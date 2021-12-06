%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Manuscript Figure 9 (Somatic stimulation)
% Optimization of biphasic pulse train parameters (suprathreshold regime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_manuscript_figure9()
clc;clear;close all;
% load data
%addpath('figure9data')
somatic=1;

if somatic==1
load('figure9data_somatic.mat')
 
end

% produce parameter ranges
[vaw ,vbw ,vbt ,vPow] = deal(unique(SNRdata(:,1)),unique(SNRdata(:,2)),unique(SNRdata(:,3)),unique(SNRdata(:,4)));

% -- Plot Results:
if somatic==1
    
          
% 3D points colored by SNR [pow x bw x bt]
surfData.x = zeros(length(vPow),length(vbw),length(vbt))*nan;
surfData.y = zeros(length(vPow),length(vbw),length(vbt))*nan;
surfData.z = zeros(length(vPow),length(vbw),length(vbt))*nan;
surfData.c = zeros(length(vPow),length(vbw),length(vbt))*nan;
SNRdata1aw = SNRdata(1:length(SNRdata)/length(vaw),:);  % only use worst aw

% build each surface
for k = 1:length(SNRdata1aw)
    datapt =  SNRdata1aw(k,:);
    inds   = [find(datapt(4)==vPow), find(datapt(2)==vbw),find(datapt(3)==vbt)];
    surfData.c(inds(1),inds(2),inds(3)) = datapt(6);
    surfData.x(inds(1),inds(2),inds(3)) = datapt(4);
    surfData.y(inds(1),inds(2),inds(3)) = datapt(2);
    surfData.z(inds(1),inds(2),inds(3)) = datapt(3);
end

% plot each surface
figure;
hold on;
hs = 0;
for k=1:length(vbt)
    hs(k) = surf(surfData.x(:,:,k),surfData.y(:,:,k),surfData.z(:,:,k),surfData.c(:,:,k));
    
end

plot3(38.6377,1.04,1.5+0.01,'sk','Color','b','MarkerSize',15,'MarkerFaceColor','#D9FFFF') % max.C1
plot3(14.4928,1.52,6+0.01,'.k','Color','w','MarkerSize',15,'MarkerFaceColor','#D9FFFF')   % 80% max.C1
plot3(23.0145,1.52,2.4+0.01,'dk','Color','b','MarkerSize',15,'MarkerFaceColor','#D9FFFF') % C1 near HB
xlabel('Expected RMS Amplitude, $E[A_{rms}] (uA)$','Position',[16.6325 1.7562 -0.0666],'Rotation',[-25],'interpreter','latex','fontsize',8,'fontweight','bold'); 
ylabel('Pulse Width, $b_{w} (ms)$','Position',[51.6666 1.5298 0.7428],'Rotation',[20],'interpreter','latex','fontsize',8,'fontweight','bold'); 
zlabel('Interpulse Period, $b_{T} (ms)$','interpreter','latex','fontsize',8);
pbaspect([4 1 4])
view(48.8265,21.5321)
set(hs,'edgecolor','none')
caxis([0 0.56915])
grid on
xlim([min(vPow)+10 max(vPow)])
ylim([min(vbw) max(vbw)])
set(gca, 'box', 'on','linewidth',0.5,'fontsize',5,'fontweight','bold')
set(gca,'color','none')
zlim([1 max(vbt)+0.5])
colormap jet 
colormap(jet)


c=colorbar('location','south');
% c.Label.Position=[-0.0313, -0.3082,0];
c.Label.Position=[-0.0674, 0.1523,0];
c.Label.Rotation=[0];
set(c,'position',[0.15 0.1 0.20 0.03])
set(c.Label,'String',['$','\tilde{C_{1}}','$'],'interpreter','latex','fontsize',12)
str=['Fig9a.tiff'];
print(gcf, '-dtiff', '-r1000',str );


% histogram of SNR distributions
figure;
subplot(2,1,1)
ixaw = SNRdata(:,1)==0.15;
SNRdata_aw = SNRdata(ixaw,:);
mxSNR = max(SNRdata_aw(:,6));
rd=SNRdata_aw(:,6)>=mxSNR*0.80 & SNRdata_aw(:,6)<mxSNR;     % red dots
bd=SNRdata_aw(:,6)<mxSNR*0.80;                              % black dots
gd=SNRdata_aw(:,6)==mxSNR;                                  % green dot
plot(SNRdata_aw(bd,4),SNRdata_aw(bd,6),'.k','markersize',5)
hold on
plot(SNRdata_aw(rd,4),SNRdata_aw(rd,6),'.r','markersize',15)
plot(SNRdata_aw(gd,4),SNRdata_aw(gd,6),'.','color',[0.25 0.8 0.35],'markersize',25)
xlim([min(vPow)-0.5 max(vPow)+0.5])
ylim([0 0.6]);
xlabel('$E[A_{rms}] (uA)$','interpreter','latex','fontsize',10,'fontweight','bold');
ylabel('$\tilde{C_{1}}$','interpreter','latex','fontsize',10,'fontweight','bold');
set(gca, 'box', 'off')
set(gca,'color','none')
subplot(2,1,2)
histogram(SNRdata_aw(:,6))
xlabel('$\tilde{C_{1}}$','interpreter','latex');
xlim([0 0.6]);
ylabel('frequency')
set(gca, 'box', 'off')
set(gca,'color','none')

str=['Fig9bc.tiff'];
print(gcf, '-dtiff', '-r1000',str );
    
end

end