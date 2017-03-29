function updateCodingMatrix(hObject, eventdata, handles)
%takes whatever is coded currently and saves it to the
trial=getappdata(0, 'trial');
%speed=getappdata(0, 'AudioSpeed');
RandList=getappdata(0, 'RandomizedList');
global CodingMat;


CodingMat(1:6,RandList(trial))={getappdata(0,'CurrentPhoneticCode');get(handles.C1errorInput, 'String'); ...
    get(handles.VerrorInput, 'String'); get(handles.C2errorInput, 'String'); getappdata(0, 'AudioOnset'); ...
    getappdata(0, 'AudioOffset')};


assignin('base', 'CodingMat', CodingMat);

guidata(hObject, handles);


