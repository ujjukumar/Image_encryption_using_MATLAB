%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Image Encryption using 3D chaotic map method %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = ImageEncryptionGui(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageEncryptionGui_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageEncryptionGui_OutputFcn, ...
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


function ImageEncryptionGui_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
axes(handles.axes4)
guidata(hObject, handles);
clear all;
clc;

function varargout = ImageEncryptionGui_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)

global k;
global l;
global m;
global gray_image;

[k, l, m] = Initializer();
[gray_image] = Image_input();
axes(handles.axes1)
imshow(gray_image);
guidata(hObject, handles);


function pushbutton2_Callback(hObject, eventdata, handles) %#ok<*DEFNU>

global k;
global l;
global m;
global gray_image;
global Enc_Img;
global xored_image;

row = 256;
col = 256;
[xored_image] = Encrypt_Image(k, l, m, gray_image);
axes(handles.axes2)

% Writing Encrypted Image back to disk
Enc_Img = reshape(xored_image, row, col);
imshow(uint8(Enc_Img));
imwrite(uint8(Enc_Img), 'Encypted.jpg', 'Quality', 100);
guidata(hObject, handles);


function pushbutton3_Callback(hObject, eventdata, handles)

global k;
global l;
global m;
global gray_image;
global Dec_Img;
global Enc_Img;
global xored_image;

[Dec_Img] = Decrypt_Image(k, l, m, Enc_Img, xored_image);
axes(handles.axes3);
imshow(uint8(Dec_Img));
imwrite(uint8(Dec_Img), 'Decrypted.jpg', 'Quality', 100);

Plotting_Images(gray_image, uint8(Enc_Img), uint8(Dec_Img))
guidata(hObject, handles);