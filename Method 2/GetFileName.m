function [name] = GetFileName()

[file, path] = uigetfile('*');

name = strcat(path, file);