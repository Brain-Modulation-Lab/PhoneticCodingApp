

function changeTrial(hObject, eventdata, handles, trial, previous)


global CodingMat;
if trial>0 && trial<getappdata(0,'numTrials');
    if ~previous==0
    updateCodingMatrix(hObject, eventdata, handles);
    end
    if sum(cellfun('isempty',CodingMat(2:end,trial)))==0
        set(hAnnotChildren, 'String', []);
        set(handles.C1errorInput, 'String', []);
        set(handles.VerrorInput, 'String', []);
        set(handles.C2errorInput, 'String', []);
        setappdata(0,'AudioOnset', [])
        setappdata(0,'AudioOffset', [])
    else
        set(handles.C1errorInput, 'String', CodingMat{2,trial});
        set(handles.VerrorInput, 'String', CodingMat{3,trial});
        set(handles.C2errorInput, 'String', CodingMat{4,trial});
        setappdata(0,'AudioOnset', CodingMat{5,trial});
        setappdata(0,'AudioOffset', CodingMat{6,trial});        
    end
    
    if isempty(CodingMat{1,trial})
        setappdata(0, 'CurrentPhoneticCode', ' ');
    else
        setappdata(0, 'CurrentPhoneticCode', CodingMat{1,trial});
    end
    
    guidata(hObject,handles);
    %AudioData=getappdata(0,'AudioData');
    AudioTrials=getappdata(0,'AudioTrials');
    AudioTrial=AudioTrials{trial};
    sf = getappdata(0,'Afs');

    [onset, h_onset, h_offset]=changeSpectrogram(AudioTrial, sf, getappdata(0, 'AudioOnset'), getappdata(0, 'AudioOffset'), getappdata(0, 'AudioSpeed'), handles);
    
    
%     [onset, h_onset, h_offset]=changeSpectrogram(AudioData.Audio, AudioData.EventTimes, ...
%         AudioData.SkipEvents, trial, getappdata(0, 'AudioOnset'), getappdata(0, 'AudioOffset'), getappdata(0, 'AudioSpeed'), handles);
    
%     [onset, h_onset, h_offset]=changeSpectrogram(AudioData.Audio, AudioData.EventTimes, ...
%         AudioData.SkipEvents, trial, onset, offset, speed, handles);
    
    setappdata(0,'AudioOnset', onset);
    handles.h_onset = h_onset;
    handles.h_offset = h_offset;
    
    %the value here for trial is the actual trial so it needs to be
    %converted back to the randomized form using (find(randtrial==trial))
    RandList=getappdata(0, 'RandomizedList');
    set(handles.dropDownStim,'Value', find(RandList==trial));
    setappdata(0, 'trial', find(RandList==trial));
    
    
    set(handles.radiobutton6,'Value',0); 
%     guidata(hObject,handles);

   axes(handles.axes6); 
   new=getappdata(0, 'CurrentPhoneticCode');
   if ~isempty(new)
     setappdata(0, 'ind', [0 regexp(new, '/','end')]);
   else
     setappdata(0, 'ind', []);
   end  
   
   h=handles.axes6.Children;
   if ~isempty(h)
   delete(findobj(h, 'Type', 'image'));
   end
   packages= {'graphicx',{'fontenc','T1'},'tipa','tipx'};
    img=lateximage(10,10, new,'EquationOnly',false, 'LatexPackages',packages,'HorizontalAlignment','center','FontSize',20, 'OverSamplingFactor',1);
    axis off

    updateCodingMatrix(hObject, eventdata, handles);
    guidata(hObject,handles);
end





% function changeTrial(hObject, eventdata, handles, trial, previous)
% global CodingMat;
% if trial>0 && trial<121
% 
%     updateCodingMatrix(hObject, eventdata, handles);
% 
%     if sum(cellfun('isempty',CodingMat(:,trial)))==0
%         hAnnotAxes=findall(gcf, 'Tag', 'scribeOverlay');
%         hAnnotChildren = get(hAnnotAxes,'Children');
%         set(hAnnotChildren, 'String', []);
%         set(handles.C1errorInput, 'String', []);
%         set(handles.VerrorInput, 'String', []);
%         set(handles.C2errorInput, 'String', []);
%         setappdata(0,'AudioOnset', [])
%         setappdata(0,'AudioOffset', [])
%     else
%         hAnnotAxes=findall(gcf, 'Tag', 'scribeOverlay');
%         hAnnotChildren = get(hAnnotAxes,'Children');
%         set(hAnnotChildren, 'String', CodingMat{1,trial});
%         set(handles.C1errorInput, 'String', CodingMat{2,trial});
%         set(handles.VerrorInput, 'String', CodingMat{3,trial});
%         set(handles.C2errorInput, 'String', CodingMat{4,trial});
%         setappdata(0,'AudioOnset', CodingMat{5,trial});
%         setappdata(0,'AudioOffset', CodingMat{6,trial});        
%     end
%     guidata(hObject,handles);
%     speed=getappdata(0, 'AudioSpeed');
%     AudioData=getappdata(0,'AudioData');
%     %onset=CodingMat{5,trial};
%     %offset=CodingMat{6,trial};
%     onset=getappdata(0, 'AudioOnset');
%     offset=getappdata(0, 'AudioOffset');
%     fprintf('Speed = %f\n',speed);
%     [onset, h_onset, h_offset]=changeSpectrogram(AudioData.Audio, AudioData.EventTimes, ...
%         AudioData.SkipEvents, trial, onset, offset, speed, handles);
%     setappdata(0,'AudioOnset', onset);
%     handles.h_onset = h_onset;
%     handles.h_offset = h_offset;
%     set(handles.dropDownStim,'Value', trial);
%     setappdata(0, 'trial', trial);
%     guidata(hObject,handles);
% 
%     updateCodingMatrix(hObject, eventdata, handles);
%    guidata(hObject,handles);
% end
% 
% 
% 
% 
