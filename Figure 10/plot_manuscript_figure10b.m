%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% plot Manuscript figure 10b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% loading data files 
function plot_manuscript_figure10b()
clc;clear;close all;

addpath('figure10data')

% load data 
load('figure10bdata_dendritic.mat')
         
figure;
b=['r','b','g','m'];
hold on
for k=1:length(noiseTypes)
    shadedErrorBar(sigVarv,nanmean(SNRstruct.(noiseTypes{k}),2),nanstd(SNRstruct.(noiseTypes{k}),[],2),'lineprops',b(k));
end

xlim(sigVarv([1 end]));
ylim([0 0.6]);

line([21 21 nan 21 21],[0 0.57492 nan 0 0.57492],'color','k','LineStyle','--')
%line([0 21-0.57492],[0.57492 0.57492],'color','k','LineStyle','--')
%txt1 = '\phi_{d}';text(-9.0749,0.57492,txt1,'color','k','fontsize',  14,'fontweight','bold')
xlabel('$E[A_{rms}] (\mu A)$','interpreter','latex','fontsize',8,'fontweight','bold'); 
ylabel('$\tilde{C_{1}}$','interpreter','latex','fontsize',8,'fontweight','bold'); 
set(gca, 'box', 'off','linewidth',1,'fontsize',10)
set(gca,'color','none')
L(1)=plot(nan, nan, 'r-','LineWidth',2);hold on,
L(2)=plot(nan, nan, 'b-','LineWidth',2);
L(3)=plot(nan, nan, 'g-','LineWidth',2);
L(4)=plot(nan, nan, 'm-','LineWidth',2);
legend(L,'$a_{w} = 0.15ms,b_{w} = 1.04ms,b_{T} = 1.5ms$',...
         '$a_{w} = 0.15ms,b_{w} = 1.52ms,b_{T} = 6.0ms$',...
         '$a_{w} = 0.15ms,b_{w} = 1.52ms,b_{T} = 2.4ms$',...
         '$a_{w} = 0.15ms,b_{w} = 1.52ms,b_{T} = 5.1ms$',...
    'interpreter','latex','fontsize',10,'fontweight','bold');
legend('boxoff')

str=['figure10b.tiff'];
print(gcf, '-dtiff', '-r1000',str);

end




