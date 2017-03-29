function [numTrials, AudioTrials] =LoadAllTrials(AudioData) 
numTrials=floor((length(AudioData.EventTimes)-AudioData.SkipEvents)/4);
EventTimes1 = [AudioData.EventTimes AudioData.EventTimes(end)+2];
for i=1:numTrials
    
    StimulusEvent1 = AudioData.SkipEvents + 4*i;
    StimulusEvent2 = AudioData.SkipEvents + 4*i + 1;
   
    sf=AudioData.Afs;
        
    preStim = 0;
    postStim = 0;
    
    CurrAudioTrial = AudioData.Audio((round(sf*(EventTimes1(StimulusEvent1)-preStim))+1): ...
    round(sf*(EventTimes1(StimulusEvent2)+postStim)));


    AudioTrials(:,i) = {(2*(CurrAudioTrial - mean(CurrAudioTrial))/ ...
    (max(CurrAudioTrial) - min(CurrAudioTrial)))};
    
end

