function [onset, h_onset, h_offset] = ...
    changeSpectrogram(AudioTrial, onset, offset, speed, handles)
%makes matrix of all data needed for plotting spectrograms;

    %global CodingMat

%     EventTimes1 = [EventTimes EventTimes(end)+2];
%     StimulusEvent1 = SkipEvents + 4*trial;
%     StimulusEvent2 = SkipEvents + 4*trial + 1;
%     
 sf = 30000;
%     
%     AudioTrial = Audio(round(sf*(EventTimes1(StimulusEvent1)-1)): ...
%     round(sf*EventTimes1(StimulusEvent2)));
%     AudioTrial = 2*(AudioTrial - mean(AudioTrial))/ ...
%     (max(AudioTrial) - min(AudioTrial));
    AudioStart=1;
    
    player = audioplayer(AudioTrial(AudioStart:end), (speed*sf)); 
    
    
    %fprintf('Player sf = %f\n',player.SampleRate);
    
    [s,f,t,p] = spectrogram(AudioTrial, 512,7/8*512, [], sf, 'power', 'yaxis');
    p0 = mean(reshape(p(1:100, :), 1, [])); %baseline signal
    Lp = 20*log10(p./p0); %decibel calculation
    baseWind=1:60;
    base = Lp(:,baseWind);
    axes(handles.axes3)
    hold off
    pcolor(t, f, Lp); ylim([0 5000]); shading interp; colormap jet;
    hold on; h = plot([1 1], ylim, 'k', 'linewidth', 1);
    %% setup the timer for the audioplayer object
    player.TimerFcn = {@plotMarker, player, h, sf}; % timer callback function
    player.TimerPeriod = 0.01; % period of the timer in seconds
    play(player);
    
    if isempty(onset)
        onset = detectSpeechOnset(Lp, t, f, 1:60, 0); %give the speech calculation the powers in dB
        if onset~=-1
            onset = t(onset);
        end
    end
    if onset > 0
        hold on; h_onset = plot(handles.axes3, [onset onset], ylim, 'k', 'linewidth', 1);
    else
        h_onset = [];
    end
    if ~isempty(offset)
        hold on; h_offset = plot(handles.axes3, [offset offset], ylim, 'b', 'linewidth', 1);
    else
        h_offset = [];
    end
    setappdata(0, 'sf', sf);
    setappdata(0, 'PlayAudio', player);
    

%% the timer callback function definition
function plotMarker(...
    obj, ...            % refers to the object that called this function (necessary parameter for all callback functions)
    eventdata, ...      % this parameter is not used but is necessary for all callback functions
    player, ...         % audioplayer object to the callback function
    h, ...              % marker handle
    fs)                 % sampling frequency

% check if sound is playing, then only plot new marker
if strcmp(player.Running, 'on')

    % update marker
    h.XData = player.CurrentSample*[1 1]/fs;%player.SampleRate;

end
    
