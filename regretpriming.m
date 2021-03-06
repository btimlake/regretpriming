addpath(matlabroot,'REGRET_task');
addpath(matlabroot,'patentTaskBTMP');
addpath(matlabroot,'ratingslider');

addpath('REGRET_task', 'patentTaskBTMP', 'ratingslider');

sca;
close all;
clearvars;
DateTime=datestr(now,'ddmm-HHMM');      % Get date and time for log file

%% Screen 0: Participant number entry [delete when combined with Patent Race]

%%% Enter participant number (taken from:
%%% http://www.academia.edu/2614964/Creating_experiments_using_Matlab_and_Psychtoolbox)
fail1='Please enter a participant number.'; %error  message
prompt = {'Enter participant number:'};
dlg_title ='New Participant';
num_lines = 1;
def = {'0'};
answer = inputdlg(prompt,dlg_title,num_lines,def);%presents box to enterdata into
switch isempty(answer)
    case 1 %deals with both cancel and X presses 
        error(fail1)
    case 0
        particNum=(answer{1});
end

% uncomment after debugging
% HideCursor;

%% Psychtoolbox setup
PsychDefaultSetup(2);

Screen('Preference', 'SkipSyncTests', 1);
KbName('UnifyKeyNames');

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
% screenNumber = max(screens);
screenNumber = 0;
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);

% Open an on screen window
% [window, windowRect] = PsychImaging('OpenWindow', screenNumber, white, [0 0 640 480]); % for one screen setup 
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white); % for two-screen setup

%% call scripts
regretTask;
regretTask1shot;
[player1Earnings] = patentTaskBTMP(particNum, DateTime, window, windowRect, 'random');

sca;

ShowCursor;
