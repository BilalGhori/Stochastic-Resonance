%% Creating manuscript figure-1

clc;clear;close all;
figure(1);
% load data files
load('inputSignals_spikes_data_1.mat')
subplot(5,1,5);plot(t(1:15000),Iinj_s(1:15000),'color','b','LineWidth',2);xlim(t([1 15000])),...
    box off,set(gca,'color','none'),set(gca,'linewidth',1,'fontsize',10,'fontweight','bold');set(gca,'xtick',[])
%hold on; plot(t(ix(:,1)),max(Iinj_s)+1,'ok');
load('inputSignals_spikes_data_5.mat')
subplot(5,1,4);plot(t(1:15000),Iinj_s(1:15000),'color','r','LineWidth',2);hold on; plot(t(ix(:,1)),max(Iinj_s)+1,'ok');...
    xlim(t([1 15000])),box off,set(gca,'color','none'), set(gca,'xtick',[]),set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')
load('inputSignals_spikes_data_10.mat')
subplot(5,1,3);plot(t(1:15000),Iinj_s(1:15000),'color','m','LineWidth',2);hold on; plot(t(ix(:,1)),max(Iinj_s)+2,'ok');...
    xlim(t([1 15000])),box off,set(gca,'color','none'), set(gca,'xtick',[]),set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')
load('inputSignals_spikes_data_12.mat')
subplot(5,1,2);plot(t(1:15000),Iinj_s(1:15000),'color','g','LineWidth',2);hold on; plot(t(ix(:,1)),max(Iinj_s)+2,'ok');...
    xlim(t([1 15000])),box off,set(gca,'color','none'), set(gca,'xtick',[]),set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')
load('inputSignals_spikes_data_17.mat')
subplot(5,1,1);plot(t(1:15000),Iinj_s(1:15000),'color','y','LineWidth',2);hold on; plot(t(ix(:,1)),max(Iinj_s)+2,'ok');...
    xlim(t([1 15000])),box off,set(gca,'color','none'),...
    set(gca,'xtick',[]),set(gca,'linewidth',1,'fontsize',10,'fontweight','bold')

% print and save figure

print(gcf, '-dtiff', '-r1000', 'figure1.tiff');
