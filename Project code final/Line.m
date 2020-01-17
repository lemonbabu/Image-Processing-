function varargout = Line(varargin)
% LINE M-file for Line.fig
%      LINE, by itself, creates a new LINE or raises the existing
%      singleton*.
%
%      H = LINE returns the handle to a new LINE or the handle to
%      the existing singleton*.
%
%      LINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINE.M with the given input arguments.
%
%      LINE('Property','Value',...) creates a new LINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Line_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Line_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Line

% Last Modified by GUIDE v2.5 11-Apr-2019 18:57:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Line_OpeningFcn, ...
                   'gui_OutputFcn',  @Line_OutputFcn, ...
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

% --- Executes just before Line is made visible.
function Line_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Line (see VARARGIN)

% Choose default command line output for Line
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Line wait for user response (see UIRESUME)
% uiwait(handles.Line);

% maximize(handles.Line);
% maximize;

% Set the figure icon
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(handles.LTrack,'javaframe');
jIcon=javax.swing.ImageIcon('dental-icon.gif');
jframe.setFigureIcon(jIcon);

% --- Outputs from this function are returned to the command line.
function varargout = Line_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Home.
function Home_Callback(hObject, eventdata, handles)
% hObject    handle to Home (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LTproject = guidata(gcbo);

% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LTproject = guidata(gcbo);

[basefilename,path]= uigetfile({'*.tif'},'Open Tif Image File');
filename= fullfile(path, basefilename);
I = imread (filename);

% if I = [MxNx4]
if(size(I,3)==4)
    I(:,:,4)=[]; % convert to I = [MxNx3]
end

global img;
img = I;
% if I = [MxN]
if(size(I,3)==1)
    [I]=gray2rgb(I); % convert to I = [MxNx3]
%     figure;imshow(I);
end

global pic;
pic = I;
axes (handles.HistGreenChan);
imhist(pic);

size(I)
CitraAsli = I;
set(LTproject.LTrack,'CurrentAxes',LTproject.CitraAsli);
set (imshow(CitraAsli));
set(LTproject.LTrack,'Userdata',filename);
set(LTproject.CitraAsli,'Userdata',I);
set(LTproject.filebrowse,'String',strcat('File Location : ',path,basefilename));


% --- Executes on button press in gapi.
function gapi_Callback(hObject, eventdata, handles)
% hObject    handle to gapi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in linestrength.
function linestrength_Callback(hObject, eventdata, handles)
% hObject    handle to linestrength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in linetracking.
function linetracking_Callback(hObject, eventdata, handles)
% hObject    handle to linetracking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LTproject = guidata(gcbo);
%set(project.CitraAsli, 'String', ''); ;

set(gcf,'WindowStyle','Normal')
frames = java.awt.Frame.getFrames();
frames(end).setAlwaysOnTop(0); 

ReBut = questdlg('Are you really want to reset this application?','Reset','Yes','No','default');
% frames(end).setAlwaysOnTop(1);
switch ReBut
case {'No'}
%     set(gcf,'WindowStyle','Modal')
%     frames = java.awt.Frame.getFrames();
%     frames(end).setAlwaysOnTop(1); 
% take no action
case 'Yes'
closeGUI = LTproject.LTrack; %handles.LTproject is the GUI figure
 
guiPosition = get(LTproject.LTrack,'Position'); %get the position of the GUI
guiName = get(LTproject.LTrack,'Name'); %get the name of the GUI
close(closeGUI); %close the old GUI
eval(guiName) %call the GUI again
end



% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LTproject = guidata(gcbo);

set(gcf,'WindowStyle','Normal')
frames = java.awt.Frame.getFrames();
frames(end).setAlwaysOnTop(0); 

pos_size = get(LTproject.LTrack,'Position');
% Call modaldlg with the argument 'Position'.
button = questdlg('Are you really want to close this application?','Close','Yes','No','default');
% Set the figure icon
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(handles.LTrack,'javaframe');
jIcon=javax.swing.ImageIcon('dental-icon.gif');
jframe.setFigureIcon(jIcon);
switch button
case {'No'}
case 'Yes'
close;
end


% --- Executes on button press in login.
function login_Callback(hObject, eventdata, handles)
% hObject    handle to login (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in logout.
function logout_Callback(hObject, eventdata, handles)
% hObject    handle to logout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LTproject = guidata(gcbo);

set(gcf,'WindowStyle','Normal')
frames = java.awt.Frame.getFrames();
frames(end).setAlwaysOnTop(0); 

pos_size = get(LTproject.LTrack,'Position');
% Call modaldlg with the argument 'Position'.
button = questdlg('Are you really want to close this application?','close','Yes','No','default');
switch button
case {'No'}
case 'Yes'
close;
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function LTrack_DeleteFcn(hObject, eventdata, handles)


% --- Executes on button press in filebrowse.
function filebrowse_Callback(hObject, eventdata, handles)
% hObject    handle to filebrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function reset_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in negative.
function negative_Callback(hObject, eventdata, handles)
% hObject    handle to negative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
global temp;

[pic_negative] = negative(pic);
temp = pic_negative;
figure,imshow(temp);

axes (handles.HistGreenChan);
imhist(temp);

axes (handles.MapQuantization);
imshow (temp);

% --- Executes on button press in SaltPepper.
function SaltPepper_Callback(hObject, eventdata, handles)
% hObject    handle to SaltPepper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
global temp;

temp = imnoise(pic,'salt & pepper',0.02);
figure,imshow(temp);

axes (handles.HistGreenChan);
imhist(temp);

axes (handles.MapQuantization);
imshow (temp);

% --- Executes on button press in bluerNoise.
function bluerNoise_Callback(hObject, eventdata, handles)
% hObject    handle to bluerNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
global temp;

[I] = bluerNoise(pic);
temp = I;

figure,imshow(temp);

axes (handles.HistGreenChan);
imhist(temp);

axes (handles.MapQuantization);
imshow (temp);

% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
global temp;
pic = temp;

axes (handles.CitraAsli);
imshow(pic);


% --- Executes on button press in Imadjust.
function Imadjust_Callback(hObject, eventdata, handles)
% hObject    handle to Imadjust (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
global temp;

[I] = imadjust(pic);
temp = I;
figure,imshow(temp);

axes (handles.HistGreenChan);
imhist(temp);

axes (handles.MapQuantization);
imshow (temp);


% --- Executes on button press in histeq.
function histeq_Callback(hObject, eventdata, handles)
% hObject    handle to histeq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
global temp;

temp = histeq(pic);
figure,imshow(temp);

axes (handles.HistGreenChan);
imhist(temp);

axes (handles.MapQuantization);
imshow (temp);

% --- Executes on button press in Smooth.
function Smooth_Callback(hObject, eventdata, handles)
% hObject    handle to Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
global temp;

imgd = im2double(pic);
f = ones(3,3)/9;
img1 = filter2(f, imgd, 'same');
temp = imcrop(img1,[0 0 550 550]);
figure,imshow(temp);

axes (handles.HistGreenChan);
imhist(temp);

axes (handles.MapQuantization);
imshow (temp);

% --- Executes on button press in MedianFilter.
function MedianFilter_Callback(hObject, eventdata, handles)
% hObject    handle to MedianFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
global temp;

[A] = medianFilter(pic);
temp = A;
figure,imshow(temp);

axes (handles.HistGreenChan);
imhist(temp);

axes (handles.MapQuantization);
imshow (temp);

% --- Executes on button press in WienerFilter.
function WienerFilter_Callback(hObject, eventdata, handles)
% hObject    handle to WienerFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pic;
global temp;

[A] = wienerFilter(pic);
temp = A;
figure,imshow(temp);

axes (handles.HistGreenChan);
imhist(temp);

axes (handles.MapQuantization);
imshow (temp);
