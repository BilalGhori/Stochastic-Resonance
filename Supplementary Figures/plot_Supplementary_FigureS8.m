%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Supplementary Figure S8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all;

% load data
addpath('Supplementary_Data_FigS8')

%% Figure S8a

load('cPRmodel_Ih_control_Is_-0.5_Id_2.27_FigS8.mat')


figure;
subplot(3,1,1)
plot(time,Vs,'k-','Linewidth',0.5);hold on,
plot(time,Vd,'r-','Linewidth',0.5)

%xlabel('$time (ms)$','interpreter','latex','fontsize',8,'fontweight','bold'); 
%ylabel('$V_{s}(mV)$','interpreter','latex','fontsize',8,'fontweight','bold'); 

set(gca, 'box', 'off','linewidth',1,'fontsize',12)
set(gca,'color','none')
axis off,

L(1)=plot(nan, nan, 'k-','LineWidth',0.5);hold on,
L(2)=plot(nan, nan, 'r-','LineWidth',0.5);

legend(L,'$V_{s}$',...
         '$V_{d}$',...
         'interpreter','latex','fontsize',10,'Location','northeastoutside','fontweight','bold');
legend('boxoff')

title('$I_{inj}^{s} = -0.5 \mu A/cm^2, I_{inj}^{d} = 2.27 \mu A/cm^2$','interpreter','latex')


subplot(3,1,2)
plot(time,Ca,'b-','Linewidth',0.5);
set(gca, 'box', 'off','linewidth',1,'fontsize',12)
set(gca,'color','none')
axis off,


legend('$Ca$','interpreter','latex','fontsize',10,'Location','northeastoutside','fontweight','bold');
legend('boxoff')

subplot(3,1,3)
plot(time,Ih,'k-','Linewidth',0.5);

%xlabel('$time (ms)$','interpreter','latex','fontsize',8,'fontweight','bold'); 
%ylabel('$V_{s}(mV)$','interpreter','latex','fontsize',8,'fontweight','bold'); 

set(gca, 'box', 'off','linewidth',1,'fontsize',12)
set(gca,'color','none')
axis off,


legend('$I_{h}$','interpreter','latex','fontsize',10,'Location','northeastoutside','fontweight','bold');
legend('boxoff')

str=['FigS8a.tiff'];
print(gcf, '-dtiff', '-r1000',str);

%% Figure S8b

 load('cPRmodel_Ih_control_Is_-0.5_Id_15_FigS8.mat')

figure;
subplot(3,1,1)
plot(time,Vs,'k-','Linewidth',0.5);hold on,
plot(time,Vd,'r-','Linewidth',0.5)

%xlabel('$time (ms)$','interpreter','latex','fontsize',8,'fontweight','bold'); 
%ylabel('$V_{s}(mV)$','interpreter','latex','fontsize',8,'fontweight','bold'); 

set(gca, 'box', 'off','linewidth',1,'fontsize',12)
set(gca,'color','none')
axis off,

L(1)=plot(nan, nan, 'k-','LineWidth',0.5);hold on,
L(2)=plot(nan, nan, 'r-','LineWidth',0.5);

legend(L,'$V_{s}$',...
         '$V_{d}$',...
         'interpreter','latex','fontsize',10,'Location','northeastoutside','fontweight','bold');
legend('boxoff')

title('$I_{inj}^{s} = -0.5 \mu A/cm^2, I_{inj}^{d} = 15 \mu A/cm^2$','interpreter','latex')


subplot(3,1,2)
plot(time,Ca,'b-','Linewidth',0.5);

%xlabel('$time (ms)$','interpreter','latex','fontsize',8,'fontweight','bold'); 
%ylabel('$V_{s}(mV)$','interpreter','latex','fontsize',8,'fontweight','bold'); 

set(gca, 'box', 'off','linewidth',1,'fontsize',12)
set(gca,'color','none')
axis off,


legend('$Ca$','interpreter','latex','fontsize',10,'Location','northeastoutside','fontweight','bold');
legend('boxoff')


subplot(3,1,3)
plot(time,Ih,'k-','Linewidth',0.5);

%xlabel('$time (ms)$','interpreter','latex','fontsize',8,'fontweight','bold'); 
%ylabel('$V_{s}(mV)$','interpreter','latex','fontsize',8,'fontweight','bold'); 

set(gca, 'box', 'off','linewidth',1,'fontsize',12)
set(gca,'color','none')
axis off,


legend('$I_{h}$','interpreter','latex','fontsize',10,'Location','northeastoutside','fontweight','bold');
legend('boxoff')

%% save figure
str=['FigS8b.tiff'];
print(gcf, '-dtiff', '-r1000',str);

