%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot Manuscript Figure 7
% Parameter optimization of C1 using broadband noise (subthreshold regime)

% December, 2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_manuscript_figure7()

%% load data

addpath('figure7data')
load('figure7adata1.mat')
load('figure7adata2.mat')


somatic=1;
numRep=8;

% computing average SNRdata

SNRdata=(SNRdata_4 + SNRdata_42)./numRep;

%% Figure 7 (top panel)
% -- plot results
% Noise correlation rate vs E[Arms]
figure;
subplot(5,1,[1 4])
SNRpcol = [SNRdata; [ones(length(vPow),1)*(max(vCT)+1) vPow(:) zeros(length(vPow),1)]];
hp = pcolor( reshape(SNRpcol(:,1),length(vPow),[]),...
             reshape(SNRpcol(:,2),length(vPow),[]),...
             reshape(SNRpcol(:,3),length(vPow),[]) );
set(hp,'edgecolor','none')
set(gca,'xscale','log')
set(gca,'yscale','log')
set(gca, 'box', 'off','linewidth',0.5,'fontsize',10,'fontweight','bold')
ylabel('$E[A_{rms}] (uA)$','interpreter','latex','fontsize',10);
xlim([0.005 5])
colormap jet
colormap(jet)


%% Figure 7 (bottom panel)

load('figure7bdata1.mat')
load('figure7bdata2.mat')

% computing average SNRdata

SNRdata=(SNRdata_4 + SNRdata_42)./numRep;


% look at max C1 over each correlation rate value
subplot(5,1,5)

% Average over all repetitions based on parameter values
tmp = bsxfun(@eq,SNRdata(:,1),vCT);           % matix of indicies of where each entry matches sigVec
[rowCT, ~]=find(tmp');                        % indicies into C (transpose tmp because find looks down rows first)
tmp = bsxfun(@eq,SNRdata(:,2),vPow);
[rowPow, ~]=find(tmp');

% accumulate averages into A (dimensions: vPow x vCT)
Amean = accumarray([rowPow rowCT],SNRdata(:,3),[],@mean);     

% plot Noise correlation rate rc vs max(C1)
shadedErrorBar(vCT,max(Amean), nanstd(Amean),'lineprops','k')
set(gca,'xscale','log')
xlim([0.005 5])
set(gca, 'box', 'off','linewidth',0.5,'fontsize',10,'fontweight','bold')
set(gca,'color','none')
xlabel('Noise Correlation Rate, r_c(ms^{-1})');
ylabel('max($\tilde{C_{1}}$)','interpreter','latex','fontsize',10);
ylim([0 0.2])

if somatic==1
line([0.0059689 0.0059689 nan 0.0059689 0.0059689],[0 1 nan 0 1],'color','k','LineStyle','--')      % draw a dashed line
line([0.014471 0.014471 nan 0.014471 0.014471],[0 1 nan 0 1],'color','k','LineStyle','--')          % draw a dashed line
line([0.035085 0.035085 nan 0.035085 0.035085],[0 1 nan 0 1],'color','k','LineStyle','--')          % draw a dashed line
line([0.12122 0.12122 nan 0.12122 0.12122],[0 1 nan 0 1],'color','k','LineStyle','--')              % draw a dashed line
line([0.41884 0.41884 nan 0.41884 0.41884],[0 1 nan 0 1],'color','k','LineStyle','--')              % draw a dashed line
line([3.5085 3.5085 nan 3.5085 3.5085],[0 1 nan 0 1],'color','k','LineStyle','--')                  % draw a dashed line
end

% print figure
if somatic==1
str=['Fig7.tiff'];print(gcf, '-dtiff', '-r1000',str );
end

      
end


