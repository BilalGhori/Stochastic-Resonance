%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Figure 6a (Somatic stimulation) 
% Power norm C1 vs noise perturbation intensity,E[Arms])
% Biphasic stochastic pulse train perturbation 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_manuscript_figure6a()

addpath('figure6data')

load('figure6adata_somatic')

figure;
b=['r','b','g','m'];
hold on
for k=1:length(noiseTypes)
    shadedErrorBar(sigVarv,nanmean(SNRstruct.(noiseTypes{k}),2),nanstd(SNRstruct.(noiseTypes{k}),[],2),'lineprops',b(k));
end
%xlim(sigVarv([1 end]));
xlim([9 49]);
ylim([0 0.45]);

% Draw dashed lines to show peak C1 values

line([13 13 nan 13 13],[0 0.31401 nan 0 0.31401],'color','k','LineStyle','--')
line([9 13-0.314],[0.314 0.314],'color','k','LineStyle','--')
txt1 = '\phi_{s}';text(3.95,0.314,txt1,'color','k','fontsize',  14,'fontweight','bold')

xlabel('$E[A_{rms}] (\mu A)$','interpreter','latex','fontsize',8,'fontweight','bold'); 
ylabel('$\tilde{C_{1}}$','interpreter','latex','fontsize',8,'fontweight','bold'); 

set(gca, 'box', 'off','linewidth',1,'fontsize',10)
set(gca,'color','none')

L(1)=plot(nan, nan, 'r-','LineWidth',2);hold on,
L(2)=plot(nan, nan, 'm-','LineWidth',2);
L(3)=plot(nan, nan, 'g-','LineWidth',2);
L(4)=plot(nan, nan, 'b-','LineWidth',2);

legend(L,'$a_{w} = 0.15ms,b_{w} = 1.76ms,b_{T} = 3.3ms$',...
         '$a_{w} = 0.15ms,b_{w} = 1.76ms,b_{T} = 3.0ms$',...
         '$a_{w} = 0.15ms,b_{w} = 1.76ms,b_{T} = 5.1ms$',...
         '$a_{w} = 0.15ms,b_{w} = 1.52ms,b_{T} = 5.1ms$',...
        'interpreter','latex','fontsize',10,'fontweight','bold');
legend('boxoff')

str=['Fig6a.tiff'];
print(gcf, '-dtiff', '-r1000',str);

end




