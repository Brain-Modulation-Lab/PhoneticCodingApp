Function loadAllTrials(EventTimes, SkipEvents, 
TotTrials=floor((length(EventTimes)-SkipEvents)/4);

for i=1:TotTrials
    
    EventTimes1 = [EventTimes EventTimes(end)+2];
    StimulusEvent1 = SkipEvents + 4*i;
    StimulusEvent2 = SkipEvents + 4*i + 1;
    
    sf = 30000;
    
    CurrAudioTrial = Audio(round(sf*(EventTimes1(StimulusEvent1)-1)): ...
    round(sf*(EventTimes1(StimulusEvent2)+.5)));



    AudioTrial(:,i) = {(2*(CurrAudioTrial - mean(CurrAudioTrial))/ ...
    (max(CurrAudioTrial) - min(CurrAudioTrial)))};
    AudioStart=1;
end


SetAppData(0, AudioTrial, 'AudioTrial')