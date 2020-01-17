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

% Last Modified by GUIDE v2.5 11-Apr-2019 18:40:48

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
global picgray
global picrgb
picgray = I;

% if I = [MxNx4]
if(size(I,3)==4)
    I(:,:,4)=[]; % convert to I = [MxNx3]
end

% if I = [MxN]
if(size(I,3)==1)
    [I]=gray2rgb(I); % convert to I = [MxNx3]
%     figure;imshow(I);
end
picrgb = I;

size(I)
CitraAsli = I;
set(LTproject.LTrack,'CurrentAxes',LTproject.CitraAsli);
set (imshow(CitraAsli));
set(LTproject.LTrack,'Userdata',filename);
set(LTproject.CitraAsli,'Userdata',I);
set(LTproject.filebrowse,'String',strcat('File Location : ',path,basefilename));

% histogram showing code
axes (handles.HistGreenChan);
imhist(I);


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LTproject = guidata(gcbo);
ImageInput = get(LTproject.CitraAsli,'Userdata');
disp(size(ImageInput));
[GC,ATW,ATG,Vs,ATW2,VsM,dilateEdge] = FnTrackInit8(ImageInput,1);

GreenChan=GC;
%axes (handles.GreenChan);
%imshow(GreenChan);

% imshow (GreenChan); 
axes (handles.HistGreenChan);
imhist(GreenChan);

%axes (handles.TrackingAreaWhite);
%imshow (ATW);

%axes (handles.TrackingAreaGray);

%imshow (ATW2);

LT = FnTrack21(GC,VsM,dilateEdge);

axes (handles.MapQuantization);
imshow (LT);


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

% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picrgb;
pic = picrgb;
pic_neg = nagetive(pic);

figure,imshow(pic_neg);

axes (handles.HistGreenChan);
imhist(pic_neg);

axes (handles.MapQuantization);
imshow (pic_neg);


% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picrgb;
pic = picrgb;

i = pic(:,:,1);
rtemp = min(i);         % find the min. value of pixels in all the columns (row vector)
rmin = min(rtemp);      % find the min. value of pixel in the image
rtemp = max(i);         % find the max. value of pixels in all the columns (row vector)
rmax = max(rtemp);      % find the max. value of pixel in the image
m = 255/(rmax - rmin);  % find the slope of line joining point (0,255) to (rmin,rmax)
c = 255 - m*rmax;       % find the intercept of the straight line with the axis
i_new = m*i + c;        % transform the image according to new slope
figure,imshow(i_new);

axes (handles.HistGreenChan);
imhist(i_new);

axes (handles.MapQuantization);
imshow (i_new);



% --- Executes on button press in pushbutton62.
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picrgb;
pic = picrgb;
pic_histeq = histeq(pic);

figure,imshow(pic_histeq);

axes (handles.HistGreenChan);
imhist(pic_histeq);

axes (handles.MapQuantization);
imshow (pic_histeq);


% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton64.
function pushbutton64_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picrgb;
pic = picrgb;
pic = imnoise(pic,'salt & pepper',0.02);

figure,imshow(pic);

axes (handles.HistGreenChan);
imhist(pic);

axes (handles.MapQuantization);
imshow (pic);


% --- Executes on button press in pushbutton65.
function pushbutton65_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton65 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton66.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global picrgb;
pic = picrgb;
pic = medianFilter(pic);

figure,imshow(pic);

axes (handles.HistGreenChan);
imhist(pic);

axes (handles.MapQuantization);
imshow (pic);

% --- Executes on button press in pushbutton67.
function pushbutton67_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global picrgb;
pic = picrgb;
pic = WienFilter (pic);
