function [numTrials, AudioTrials] =LoadAllTrials(AudioData) 


if isfield(AudioData, 'SpeechTrials')
    
    numTrials = size(AudioData.SpeechTrials,1);
    
    allAfs = unique([AudioData.SpeechTrials{:,2}]);
    if length(allAfs)>1
        Afs = min(allAfs);
        SpeechTrials = cellfun(@(x,y) resample(x, Afs, y), ...
            AudioData.SpeechTrials(:,4), AudioData.SpeechTrials(:,2), ...
            'uniformoutput', false);
    end

    % zoom in on marked speech
    for tr=1:length(SpeechTrials)     
        tstart = 1;
        tend = length(SpeechTrials{tr});
        if ~isempty(AudioData.SpeechTrials{tr,12})
            tstart = round(Afs*AudioData.SpeechTrials{tr,12});
        end
        if ~isempty(AudioData.SpeechTrials{tr,13})
            tend = round(Afs*AudioData.SpeechTrials{tr,13});
        end        
        SpeechTrials{tr} = SpeechTrials{tr}(tstart:tend);   
    end
    
    AudioTrials = SpeechTrials;
    
else

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
        
%         AudioTrials(:,i) = {(2*(CurrAudioTrial - mean(CurrAudioTrial))/ ...
%             (max(CurrAudioTrial) - min(CurrAudioTrial)))};

    end

end

AudioTrials = cellfun(@(x) (2*(x - mean(x))/ (max(x) - min(x))), AudioTrials, 'uniformoutput',false);

