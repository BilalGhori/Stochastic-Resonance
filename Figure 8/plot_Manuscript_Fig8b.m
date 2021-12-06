%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Manuscript Figure 8b
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% loading data files 
function plot_Manuscript_Fig8b()
%close all;

addpath('figure8data')

file=['load figure8b_data.mat'];eval(file);

          
% plot results

 b=['c','b','m','r','g','k'];

figure; hold on
for k=1:length(noiseTypes)
    shadedErrorBar(sigVarv,nanmean(SNRstruct.(noiseTypes{k}),2),nanstd(SNRstruct.(noiseTypes{k}),[],2),'lineprops',b(k));
end
% xlim(sigVarv([1 end])); 
xlim([0 10]); 
ylim([0 0.18]);

%legend(noiseTypes);

% Draw dashed lines to show peak C1 values

line([3 3 nan 3 3],[0 0.10813 nan 0 0.10813],'color','k','LineStyle','--') % draw a vertical line through peak C1
line([0 3-0.10813],[0.10813 0.10813],'color','k','LineStyle','--')         % draw a horizontal line through peak C1
line([0 0.10813],[0.10813 0.10813],'color','k','LineStyle','--')
txt1 = '\phi_{d}';text(-1,0.11027,txt1,'color','k','fontsize',  14,'fontweight','bold')
xlabel('$E[A_{rms}] (uA)$','interpreter','latex','fontsize',8,'fontweight','bold'); 
ylabel('$\tilde{C_{1}}$','interpreter','latex','fontsize',8,'fontweight','bold'); 
set(gca, 'box', 'off','linewidth',1,'fontsize',10)
set(gca,'color','none')
L(1)=plot(nan, nan, 'c-','LineWidth',2);hold on,
L(2)=plot(nan, nan, 'b-','LineWidth',2);
L(3)=plot(nan, nan, 'm-','LineWidth',2);
L(4)=plot(nan, nan, 'r-','LineWidth',2);
L(5)=plot(nan, nan, 'g-','LineWidth',2);
L(6)=plot(nan, nan, 'k-','LineWidth',2);
legend(L,'$r_c = 5.9689 Hz$',...
         '$r_c = 14.471 Hz$',...
         '$r_c = 35.085 Hz$',...
         '$r_c = 121.22 Hz$',...
         '$r_c = 418.84 Hz$',...
         '$r_c = 3508.5 Hz$',...
         'interpreter','latex','fontsize',10,'fontweight','bold');
legend('boxoff')
str=['Fig8b.tiff'];
print(gcf, '-dtiff', '-r1000',str);

end






