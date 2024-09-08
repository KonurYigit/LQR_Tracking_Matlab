clear all;
close all;;
clc;
% Populate EOL parameters.
EOL_Parameters;
DataDictionary;

assignin("base","ModelType",1);
assignin("base","ControlVariant",2);
ControlDesign;