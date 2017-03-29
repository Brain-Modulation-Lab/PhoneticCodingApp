
function pushbutton_Select_wav_File_Callback(hObject, eventdata, handles)
[filename, pathname] = uigetfile('*.wav');
filename = fullfile(pathname, filename);
[signal, Fs] = wavread(filename);
player = audioplayer(signal, Fs);
play(player);
pause(max(size(signal))/Fs);

%When this function exits, the player variable is deleted along with the rest 
%of the pushbutton_Select_wav_File_Callback function's workspace. When the 
%variable is deleted, playback stops. Using PLAYBLOCKING to avoid exiting the 
%callback function until playback is complete.
