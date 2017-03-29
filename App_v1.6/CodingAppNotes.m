%Coding Application Notes.

%Variable names that aren't obvious.
%edit12= notes for current trial
%radiobutton6= toggle button to reveal presented stimuli, marks 1 in
%codingmat{,7}
%radiobutton7= toggles to show non-randomized ID number of sample trial
%(i.e. trialnum.samplefilenumber)
%checkbox4= 'Uncodable' button; for current trial, replaces CodingMat phonetic 
%code to 'NaN' and writes 'uncodable' in notes (codingmat rows 1 and 8
%respectively).
%axis3=spectrogram of audio
%axis6=phonetic coding on app/prints LaTex image
%uibuttongroup1= panel of buttons for IPA


% App variables:
% RandomizedList=permuted list of length num trials...where trueTrialNum=randomizedList(i)
% trial = index of Randomizedlist; back/next are trial ± 1 (i.e.
% trueTrialNum=randomizedList(trial);
% fname=filename 


%Coding Mat Rows:
% %1. phonetic code in LaTex separated by '/'.
% %2. 1st Consonant errors
% %3. Vowel errors
% %4. 2nd Consonant error
% %5. Word onset time
% %6. Word offset time
% %7. 1 if actual task presentation was revealed
% %8. Notes for current trial
