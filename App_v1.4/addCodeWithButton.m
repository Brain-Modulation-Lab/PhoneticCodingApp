function addCodeWithButton(codeInput,handles,hObject);
%set(handles.axes6, 'Color', 'none')
axes(handles.axes6); 
CurrentPhoneticCode=getappdata(0, 'CurrentPhoneticCode');

if ~isempty(getappdata(0, 'CurrentPhoneticCode'));
    new=strcat(getappdata(0, 'CurrentPhoneticCode'), codeInput , '/');   
else 
    new=strcat(codeInput , '/');
end
     
     ind=[0 regexp(new, '/','end')];
     newLength=length(codeInput);
     setappdata(0, 'ind', ind);
     setappdata(0, 'newLength', newLength);
     setappdata(0, 'PreviousCode', CurrentPhoneticCode);
     setappdata(0, 'CurrentPhoneticCode', new);

h=handles.axes6.Children;

if ~isempty(h)
    delete(findobj(h, 'Type', 'image'))
end
%packages= {'graphicx',{'fontenc','T1'},'tipa','tipx'};
img=lateximage(10,10, new,'EquationOnly',false, 'LatexPackages', ...
    {'graphicx',{'fontenc','T1'},'tipa','tipx'},'HorizontalAlignment','center','FontSize',20, 'OverSamplingFactor',1);
axis off
guidata(hObject, handles);   
end
