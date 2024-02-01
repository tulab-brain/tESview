function varargout = tesview(varargin)
% TESVIEW MATLAB code file for tesview.fig
%      TESVIEW, by itself, creates a new TESVIEW or raises the existing
%      singleton*.
%
%      H = TESVIEW returns the handle to a new TESVIEW or the handle to
%      the existing singleton*.
%
%      TESVIEW('Property','Value',...) creates a new TESVIEW using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to tesview_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TESVIEW('CALLBACK') and TESVIEW('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TESVIEW.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tesview

% Last Modified by GUIDE v2.5 02-Jan-2024 18:07:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tesview_OpeningFcn, ...
                   'gui_OutputFcn',  @tesview_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before tesview is made visible.
function tesview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for tesview
handles.output = hObject;
fig=figure(...
    'WindowStyle','modal',...
    'Name','Starting...',...
    'NumberTitle','off',...
    'Visible','on',...
    'Position',[650 300 420 450],...
    'CloseRequestFcn',[],...
    'MenuBar','none');
imshow('cover.tif')
set(gca,'position',[0 0 1 1]);
axis off
pause(2);
delete(fig);

% Update handles structure
guidata(hObject, handles);

% global parameters
global EFdirectory
[EFdirectory,~] = fileparts(which('tesview'));

% UIWAIT makes tesview wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tesview_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

activeNum=size(findobj(findobj('Tag','uipanel1'),'Style','popupmenu','Visible','on'),1);
if activeNum<=5
    set(handles.edit1,'Enable','Off')
    eval(['set(handles.popupmenu' num2str(activeNum(1)+2) ',''Visible'',''on'')'])
    eval(['set(handles.edit' num2str(activeNum(1)+2) ',''Visible'',''on'')'])
    eval(['set(handles.text' num2str(activeNum(1)+2) ',''Visible'',''on'')'])
else
    warndlg('Six electrodes at most. Please remove all the electrodes and manually enter stimulation recipe under "More Electrodes" if more electrodes are to be simulated.','Current Input Error')
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
activeNum=size(findobj(findobj('Tag','uipanel1'),'Style','popupmenu','Visible','on'),1);
if activeNum>1
    eval(['set(handles.popupmenu' num2str(activeNum(1)+1) ',''Visible'',''off'')'])
    eval(['set(handles.edit' num2str(activeNum(1)+1) ',''Visible'',''off'')'])
    eval(['set(handles.text' num2str(activeNum(1)+1) ',''Visible'',''off'')'])
elseif activeNum==1
    set(handles.edit1,'Enable','on')
    eval(['set(handles.popupmenu' num2str(activeNum(1)+1) ',''Visible'',''off'')'])
    eval(['set(handles.edit' num2str(activeNum(1)+1) ',''Visible'',''off'')'])
    eval(['set(handles.text' num2str(activeNum(1)+1) ',''Visible'',''off'')'])
end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% global EFdirectory
% templates=dir([EFdirectory filesep 'template']);
% set(hObject,'String',{templates(3:end).name})

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- No ticks for axes.
function axes1_CreateFcn(hObject, eventdata, handles)
set(hObject,'xTick',[]);
set(hObject,'yTick',[]);
set(hObject,'XColor','none');
set(hObject,'YColor','none');


function axes2_CreateFcn(hObject, eventdata, handles)
set(hObject,'xTick',[]);
set(hObject,'yTick',[]);
set(hObject,'XColor','none');
set(hObject,'YColor','none');


function axes3_CreateFcn(hObject, eventdata, handles)
set(hObject,'xTick',[]);
set(hObject,'yTick',[]);
set(hObject,'XColor','none');
set(hObject,'YColor','none');


function axes4_CreateFcn(hObject, eventdata, handles)
set(hObject,'xTick',[]);
set(hObject,'yTick',[]);
set(hObject,'Color','none');
set(hObject,'XColor','none');
set(hObject,'YColor','none');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global EFdirectory
Template=get(handles.popupmenu1,'String');
currentVal=get(handles.popupmenu1,'Value')
CurrentTemplate=Template
subjdir=[EFdirectory filesep 'template' filesep CurrentTemplate]
fid = fopen([subjdir filesep CurrentTemplate '_roastLog']); simTag = textscan(fid,'%s',1,'HeaderLines',0);fclose(fid);
simTag=strrep(simTag{1},':','');  


activeNum=size(findobj(findobj('Tag','uipanel1'),'Style','popupmenu','Visible','on'),1);
I_all=zeros(activeNum,1);
iserror=0;

if activeNum==0 & get(handles.edit3,'Enable')=='on'

    recipe=get(handles.edit1,'String');
    recipe=eval(['{' recipe '}']);
    ELEC=recipe(1:2:end);

    if mod(length(recipe),2)~=0
        errordlg('Unrecognized format of recipe. Please enter property-value pair.','Error');
        iserror=1;
    else
        for j=length(recipe)/2
            I_all=cell2mat(recipe(2:2:end));
            recipe{2*j}=I_all(j);
        end
    end



elseif activeNum>=1

    for i=1:activeNum
        ELEC_all=eval(['get(handles.popupmenu' num2str(i+1) ',''String'')']);
        ELEC_val=eval(['get(handles.popupmenu' num2str(i+1) ',''Value'')']);
        ELEC{i}=ELEC_all{ELEC_val};
        I_in=eval(['get(handles.edit' num2str(i+1) ',''String'')']);

        if isempty(str2num(I_in)) | ~isnumeric(str2num(I_in))
            errordlg('Please enter the currents.','Current Input Error')
            iserror=1;
            break
        else

            I_all(i)=str2num(I_in);
            recipe{2*i-1}=ELEC{i};recipe{2*i}=I_all(i);
            clear ELEC_val I_in

        end

    end

end

disp('  ')
disp('--------------------------------')
disp('  ')
disp('Starting at:')
dt=datetime('now','Format','yyyy-MM-dd HH:mm:ss');disp(dt)
disp('--------------------------------')
disp('  ')
disp(['Head model: ' CurrentTemplate])
disp('  ')
disp('Recipe: ')
for k=1:length(ELEC)
    disp([ELEC{k} '  ' num2str(I_all(k)) 'mA'])
end
disp('  ')
disp('--------------------------------')
disp('  ')
disp('--------------------------------')
disp('Checking inputs......')
disp('--------------------------------')
disp('  ')


if ~iserror
    if abs(sum(I_all))>eps
        warndlg('The summed currents should be 0! Please reset currents.','Current Input Error')
    elseif length(unique(ELEC))~=length(ELEC)
        warndlg('Redundant electrodes!','Current Input Error')
    else
        disp('--------------------------------')
        disp('Computing electric field......')
        disp('--------------------------------')
        [ef_all,ef_mag]=ef_calculator([subjdir filesep CurrentTemplate '.nii'],simTag{1},recipe);

        % image settings
        
        [Nx,Ny,Nz] = size(ef_mag);
        pos = round(size(ef_mag)/2);
        label='Electric field Intensity(V/m)';
        
        if all(isnan(ef_mag(:)))
            error('The image volume you provided does not have any meaningful values.');
        elseif double(min(ef_mag(:)))==double(prctile(ef_mag(:),95))
            mydata.clim = 'auto';
        else
            mydata.clim = double([min(ef_mag(:)) max(ef_mag(:))]);
        end
        
        temp = size(ef_all);
        if any(temp(1:3)~=[Nx,Ny,Nz]) || temp(4)~=3
            error('Vector field does not have correct size.');
        end
        
        [mydata.xi,mydata.yi,mydata.zi] = ndgrid(1:Nx,1:Ny,1:Nz);
        mydata.ef_mag=ef_mag;
        mydata.ef_all=ef_all;
        mydata.pos=pos;
        mydata.label=label;
        
        % % show images
        set(gcf,'UserData',mydata);
        showimg
        set(gcf,'WindowButtonDownFcn',@fCallback)

    end
end


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
