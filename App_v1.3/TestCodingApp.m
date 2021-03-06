
function varargout = TestCodingApp(varargin)
% TESTCODINGAPP MATLAB code for TestCodingApp.fig
%      TESTCODINGAPP, by itself, creates a new TESTCODINGAPP or raises the existing
%      singleton*.
%
%      H = TESTCODINGAPP returns the handle to a new TESTCODINGAPP or the handle to
%      the existing singleton*.
%
%      TESTCODINGAPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTCODINGAPP.M with the given input arguments.
%
%      TESTCODINGAPP('Property','Value',...) creates a new TESTCODINGAPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TestCodingApp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TestCodingApp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TestCodingApp

% Last Modified by GUIDE v2.5 07-Nov-2016 09:28:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TestCodingApp_OpeningFcn, ...
                   'gui_OutputFcn',  @TestCodingApp_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before TestCodingApp is made visible.
function TestCodingApp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TestCodingApp (see VARARGIN)

% Choose default command line output for TestCodingApp
handles.output = hObject;

% Update handles structure

guidata(hObject, handles);
global CodingMat
CodingMat=cell(8,120);
assignin('base', 'CodingMat', CodingMat);
addpath(genpath(pwd));

path1='/usr/bin:/bin:/usr/sbin:/sbin';
setenv('PATH', [path1 ':/Library/TeX/texbin/']);
guidata(hObject, handles);


% This sets up the initial plot - only do when we are invisible
% so window can get raised using TestCodingApp.

set(handles.axes6,'Visible','off')
set(handles.axes6, 'Color', 'none')
setappdata(0,  'CurrentPhoneticCode', '');

if strcmp(get(hObject,'Visible'),'off')
    axes(handles.axes3); 
    plot(rand(1));   
end
set(handles.dropDownStim,'String', ' ');
set(handles.dropDownStim,'Value', 1);
set(handles.figure1, 'KeyPressFcn', @keyboardinput)

% UIWAIT makes TestCodingApp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TestCodingApp_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in dropDownStim.
function dropDownStim_Callback(hObject, eventdata, handles)
% hObject    handle to dropDownStim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns dropDownStim contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dropDownStim
getpixelposition(hObject);
previousTrial=getappdata(0, 'trial');
%trial is the index of the actual randomized list. 
trial=get(hObject, 'Value');
RandList=getappdata(0, 'RandomizedList');
changeTrial(hObject, eventdata, handles, RandList(trial), RandList(previousTrial));
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function dropDownStim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dropDownStim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
setappdata(0, 'trial', 1);

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');     
end

guidata(hObject,handles);



% --------------------------------------------------------------------

% --- Executes on button press in BackButton.
function BackButton_Callback(hObject, eventdata, handles)
% hObject    handle to BackButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentTrial=getappdata(0, 'trial');
RandList=getappdata(0, 'RandomizedList');

if  (currentTrial-1)>0
changeTrial(hObject, eventdata, handles, RandList(currentTrial-1), RandList(currentTrial))
end;



% --- Executes on button press in NextButton.
function NextButton_Callback(hObject, eventdata, handles)
% hObject    handle to NextButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
currentTrial=getappdata(0, 'trial');
RandList=getappdata(0, 'RandomizedList');
if (currentTrial+1)<=getappdata(0,'numTrials')
    changeTrial(hObject, eventdata, handles, RandList(currentTrial+1), RandList(currentTrial))
end
  guidata(hObject,handles);



% --- Executes on button press in EndButton.
function EndButton_Callback(hObject, eventdata, handles)
% hObject    handle to EndButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%[filename, pathname] = uiputfile('*.mat', 'Save Workspace as')
selection = questdlg(['Save ' get(handles.figure1,'Name') '?'],...
                     ['Save ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    %return;
    close()
elseif strcmp(selection,'Yes')
    updateCodingMatrix(hObject, eventdata, handles);
    guidata(hObject,handles);
    writeLog
    global CodingMat
CodingMatrix=CodingMat;
fname=getappdata(0, 'fname');
save(fname, 'CodingMatrix', '-append')
close()
end



% --------------------------------------------------------------------

% --- Executes on button press in repreataudio.
function repreataudio_Callback(hObject, eventdata, handles)
% hObject    handle to repreataudio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Player=getappdata(0,'PlayAudio');
AudioSpeed=getappdata(0,'AudioSpeed');
play(Player);
%fprintf('Speed = %f\n',AudioSpeed);
%fprintf('Player sf = %f\n',Player.SampleRate);
guidata(hObject,handles);

% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Player=getappdata(0,'PlayAudio');
AudioSpeed=getappdata(0,'AudioSpeed')
resume(Player);
%fprintf('Speed = %f\n',AudioSpeed);
%fprintf('Player sf = %f\n',Player.SampleRate);
guidata(hObject,handles);


% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Player=getappdata(0,'PlayAudio');
AudioSpeed=getappdata(0,'AudioSpeed')
pause(Player);
guidata(hObject,handles);


% --------------------------------------------------------------------




% --- Executes on button press in sym1.
function sym1_Callback(hObject, eventdata, handles)
% hObject    handle to sym1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='a\textsci';
addCodeWithButton(sym, handles, hObject);


% --- Executes on button press in sym2.
function sym2_Callback(hObject, eventdata, handles)
% hObject    handle to sym2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textscripta';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym3.
function sym3_Callback(hObject, eventdata, handles)
% hObject    handle to sym3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textscripta \textupsilon';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym4.
function sym4_Callback(hObject, eventdata, handles)
% hObject    handle to sym4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textturnscripta';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym5.
function sym5_Callback(hObject, eventdata, handles)
% hObject    handle to sym5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\ae';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym6.
function sym6_Callback(hObject, eventdata, handles)
% hObject    handle to sym6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym6='\textturnv';
addCodeWithButton(sym6, handles, hObject);

% --- Executes on button press in sym7.
function sym7_Callback(hObject, eventdata, handles)
% hObject    handle to sym7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym7='\textdyoghlig';
addCodeWithButton(sym7, handles, hObject);

% --- Executes on button press in sym8.
function sym8_Callback(hObject, eventdata, handles)
% hObject    handle to sym8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym8='\dh';
addCodeWithButton(sym8, handles, hObject);

% --- Executes on button press in sym9.
function sym9_Callback(hObject, eventdata, handles)
% hObject    handle to sym9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym9='\textopeno';
addCodeWithButton(sym9, handles, hObject);


% --- Executes on button press in sym10.
function sym10_Callback(hObject, eventdata, handles)
% hObject    handle to sym10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym10='\textopeno\textsci';
addCodeWithButton(sym10, handles, hObject);

% --- Executes on button press in sym11.
function sym11_Callback(hObject, eventdata, handles)
% hObject    handle to sym11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textesh';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym12.
function sym12_Callback(hObject, eventdata, handles)
% hObject    handle to sym12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textyogh';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym13.
function sym13_Callback(hObject, eventdata, handles)
% hObject    handle to sym13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\texttheta';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym14.
function sym14_Callback(hObject, eventdata, handles)
% hObject    handle to sym14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textupsilon';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym15.
function sym15_Callback(hObject, eventdata, handles)
% hObject    handle to sym15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textepsilon';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym16.
function sym16_Callback(hObject, eventdata, handles)
% hObject    handle to sym16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textg';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym17.
function sym17_Callback(hObject, eventdata, handles)
% hObject    handle to sym17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textsci';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym18.
function sym18_Callback(hObject, eventdata, handles)
% hObject    handle to sym18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\ng';
addCodeWithButton(sym, handles, hObject);

% --- Executes on button press in sym19.
function sym19_Callback(hObject, eventdata, handles)
% hObject    handle to sym19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sym='\textglotstop';
addCodeWithButton(sym, handles, hObject);


% --- Executes on button press in Del.
function Del_Callback(hObject, eventdata, handles)
% hObject    handle to Del (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

currentCoding=getappdata(0, 'CurrentPhoneticCode');
ind=getappdata(0, 'ind');
if ~isequal(ind,[0])
    new=currentCoding(1:ind(end-1));
    axes(handles.axes6); 
    h=handles.axes6.Children;
    if ~isempty(h)
        delete(findobj(h, 'Type', 'image'));
        packages= {'graphicx',{'fontenc','T1'},'tipa','tipx'};
        img=lateximage(10,10, new,'EquationOnly',false, 'LatexPackages',packages,'HorizontalAlignment','center','FontSize',20, 'OverSamplingFactor',1);
        axis off;
        setappdata(0, 'CurrentPhoneticCode', new);
        setappdata(0, 'ind', ind(1:end-1));
    end
end
guidata(hObject, handles);  
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function C1errorInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C1errorInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function C1errorInput_Callback(hObject, eventdata, handles)
% hObject    handle to C2errorInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C2errorInput as text
%        str2double(get(hObject,'String')) returns contents of C2errorInput as a double



% --- Executes during object creation, after setting all properties.
function VerrorInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VerrorInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function VerrorInput_Callback(hObject, eventdata, handles)
% hObject    handle to C2errorInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C2errorInput as text
%        str2double(get(hObject,'String')) returns contents of C2errorInput as a double



% --- Executes during object creation, after setting all properties.
function C2errorInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C2errorInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function C2errorInput_Callback(hObject, eventdata, handles)
% hObject    handle to C2errorInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C2errorInput as text
%        str2double(get(hObject,'String')) returns contents of C2errorInput as a double


% --- Executes on button press in updateoutputcell.
function updateoutputcell_Callback(hObject, eventdata, handles)
% hObject    handle to updateoutputcell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%trial=randi(120); %change to actual trial number. 
updateCodingMatrix(hObject, eventdata, handles);


% --- Executes on button press in MarkOnset.
function MarkOnset_Callback(hObject, eventdata, handles)
% hObject    handle to MarkOnset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[t,~,button] = ginput(1); %wait for mouse input to mark when analysis should begin

if isfield(handles, 'h_onset')
    if ~isempty(handles.h_onset) && isfield(handles.h_onset, 'XData')
        handles.h_onset.XData = t*[1 1];
    else
        hold on; h_onset = plot(t*[1 1], ylim, 'k', 'linewidth', 1);
        handles.h_onset = h_onset;
    end
else
    hold on; h_onset = plot(t*[1 1], ylim, 'k', 'linewidth', 1);
    handles.h_onset = h_onset;
end
setappdata(0,'AudioOnset', t);
updateCodingMatrix(hObject, eventdata, handles);
guidata(hObject,handles);



% --- Executes on button press in MarkOffset.
function MarkOffset_Callback(hObject, eventdata, handles)
% hObject    handle to MarkOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[t,~,button] = ginput(1); %wait for mouse input to mark when analysis should begin
if isfield(handles, 'h_offset')
    if ~isempty(handles.h_offset) && isfield(handles.h_offset, 'XData')
        handles.h_offset.XData = t*[1 1];
    else
        hold on; h_offset = plot(t*[1 1], ylim, 'b', 'linewidth', 1);
        handles.h_offset = h_offset;
    end
else
    hold on; h_offset = plot(t*[1 1], ylim, 'b', 'linewidth', 1);
    handles.h_offset = h_offset;
end
setappdata(0,'AudioOffset', t);
updateCodingMatrix(hObject, eventdata, handles);
guidata(hObject,handles);


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function keyboardinput(hObject, eventdata, handles)
handles=guidata(hObject); % get me current handle definitions
keypressed=get(handles.figure1,'CurrentCharacter');
if ~isempty(keypressed)
    if isstrprop(keypressed,'alpha')
        addCodeWithButton(keypressed, handles, hObject);
    end
end
guidata(hObject,handles);


% --- Executes on slider movement.
function PlaySpeedSlider_Callback(hObject, eventdata, handles)
% hObject    handle to PlaySpeedSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

speed = get(hObject,'Value'); %returns position of slider
set(handles.PlaySpeedText, 'String', num2str(speed,'%2.1f'));
setappdata(0, 'AudioSpeed',speed);
player =  getappdata(0, 'PlayAudio');
sf =  getappdata(0, 'sf');
player.SampleRate = speed*sf;
setappdata(0, 'PlayAudio', player);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function PlaySpeedSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlaySpeedSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function PlaySpeedText_Callback(hObject, eventdata, handles)
% hObject    handle to PlaySpeedText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 speed = str2double(get(hObject,'String')); %returns contents of edit11 as a double
 if speed>0.1 && speed<1.5
     set(handles.PlaySpeedSlider, 'Value', speed);
     setappdata(0, 'AudioSpeed',speed);
     player =  getappdata(0, 'PlayAudio');
     sf =  getappdata(0, 'sf');
     player.SampleRate = speed*sf;
     setappdata(0, 'PlayAudio', player);
 else
     set(hObject, 'String', num2str(AudioSpeed,'%3.2f'));
 end
 guidata(hObject,handles);
 


% --- Executes during object creation, after setting all properties.
function PlaySpeedText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlaySpeedText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenFile_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, path] = uigetfile('*.mat', 'Select Subject Audio file');
    filename=strcat( path, fname);
    AudioData=load(filename);
    setappdata(0,'trial', 1);
    setappdata(0,'Afs', AudioData.Afs);
    %setappdata(0,'AudioData', AudioData);
    setappdata(0,'AudioSpeed', 1.0);
    setappdata(0,'fname', fname);
    setappdata(0,'WordList', AudioData.WordList);
    if isfield(AudioData, 'CodingMatrix')
        global CodingMat
        CodingMat=AudioData.CodingMatrix;
        assignin('base', 'CodingMat', CodingMat);
        
    end
    
[numTrials, AudioTrials] =LoadAllTrials(AudioData);

 RandomizedList=randperm(numTrials);
 setappdata(0, 'RandomizedList', RandomizedList);
 setappdata(0, 'AudioTrials', AudioTrials);
 setappdata(0, 'numTrials', numTrials);
 
 changeTrial(hObject, eventdata, handles, RandomizedList(1), 0);
 
 for TrialNum=1:numTrials;
 ListNames{TrialNum}=sprintf('Word %d', TrialNum);
 end
 
 set(handles.dropDownStim, 'String', ListNames);
 set(handles.figure1, 'KeyPressFcn', @keyboardinput)
 
 guidata(hObject,handles);



% --------------------------------------------------------------------
function SaveFile_Callback(hObject, eventdata, handles)
% hObject    handle to SaveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
updateCodingMatrix(hObject, eventdata, handles);
guidata(hObject,handles);
writeLog
global CodingMat
CodingMatrix=CodingMat;
fname=getappdata(0, 'fname');
save(fname, 'CodingMatrix', '-append')
close()




% --- Executes during object creation, after setting all properties.
function codingpanel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to codingpanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hObject.Visible='on';
guidata(hObject,handles);



% % --- Executes on mouse press over axes background.
function axes6_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to axes6 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% handles=guihandles; % get me current handle definitions
% keypressed=get(handles.figure1,'CurrentCharacter')
% PreviousString=getappdata(0, 'CurrentPhoneticCode');
% 


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%get word at current trial.
%change using set(h0bject,'String', currentWord)
if (get(hObject,'Value') == get(hObject,'Max'))
	WL=getappdata(0, 'WordList');
    trial=getappdata(0, 'trial');
    RandList=getappdata(0, 'RandomizedList');
    hObject.String= WL{RandList(trial)};
    global CodingMat
    CodingMat(7,RandList(trial))={1};
else
    hObject.String='Reveal Word';
end

guidata(hObject, handles);


% Hint: get(hObject,'Value') returns toggle state of radiobutton6


function writeLog
	% Alert user via the command window and a popup message.
	user=char( getHostName( java.net.InetAddress.getLocalHost ) );
    version='1.3 (11/07/16)';
    filename=getappdata(0,'fname');
    
    fid = fopen('log.txt','at');
    fprintf(fid, '%s :: %s modified by [ %s ] using Phonetic Coding App v. %s\n', datestr(now), filename(1:end-4), user, version);
 	fclose(fid);
   
    

function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7
if (get(hObject,'Value') == get(hObject,'Max'))
    trial=getappdata(0, 'trial');
    RandList=getappdata(0, 'RandomizedList');
    %hObject.String= RandList(trial);
    fname=getappdata(0, 'fname');
    hObject.String= [num2str(RandList(trial)) '.' num2str(fname(end-5:end-4))];
else
    hObject.String='Token ID';
end

guidata(hObject, handles);
