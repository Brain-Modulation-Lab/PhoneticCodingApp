function updateCodingMatrix(hObject, eventdata, handles)
%takes whatever is coded currently and saves it to the
trial=getappdata(0, 'trial');
%speed=getappdata(0, 'AudioSpeed');
RandList=getappdata(0, 'RandomizedList');
global CodingMat;

%Coding Mat Rows:
%1. phonetic code in LaTex separated by '/'.
%2. 1st Consonant errors
%3. Vowel errors
%4. 2nd Consonant error
%5. Word onset time
%6. Word offset time
%7. 1 if actual task presentation was revealed
%8. Notes for current trial


CodingMat(1:6,RandList(trial))= ...
    {getappdata(0,'CurrentPhoneticCode'); ...
     get(handles.C1errorInput, 'String'); ...
     get(handles.VerrorInput, 'String'); ...
     get(handles.C2errorInput, 'String'); ...
     getappdata(0, 'AudioOnset'); ...
     getappdata(0, 'AudioOffset')};

CodingMat(8, RandList(trial))={get(handles.edit12, 'String')};

CodingMat(9:10,RandList(trial))= ...
     {getappdata(0, 'VowelOnset'); ...
      getappdata(0, 'VowelOffset')};    

assignin('base', 'CodingMat', CodingMat);

guidata(hObject, handles);


