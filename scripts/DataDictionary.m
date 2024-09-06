function DataDictionary() 
% DATADICTIONARY initializes a set of bus objects in the MATLAB base workspace 

% Bus object: VehicleInputBus 
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'SteeringAng';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'VehicleSpeed';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = '';

VehicleInputBus = Simulink.Bus;
VehicleInputBus.HeaderFile = '';
VehicleInputBus.Description = '';
VehicleInputBus.DataScope = 'Auto';
VehicleInputBus.Alignment = -1;
VehicleInputBus.PreserveElementDimensions = 0;
VehicleInputBus.Elements = elems;
clear elems;
assignin('base','VehicleInputBus', VehicleInputBus);

% Bus object: VehicleModelBus 
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'X';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = sprintf('m');
elems(1).Description = '';

elems(2) = Simulink.BusElement;
elems(2).Name = 'Xdot';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = sprintf('m/s');
elems(2).Description = '';

elems(3) = Simulink.BusElement;
elems(3).Name = 'Y';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = sprintf('m');
elems(3).Description = '';

elems(4) = Simulink.BusElement;
elems(4).Name = 'Ydot';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = sprintf('m/s');
elems(4).Description = '';

elems(5) = Simulink.BusElement;
elems(5).Name = 'Theta';
elems(5).Dimensions = 1;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = sprintf('rad');
elems(5).Description = '';

elems(6) = Simulink.BusElement;
elems(6).Name = 'Thetadot';
elems(6).Dimensions = 1;
elems(6).DimensionsMode = 'Fixed';
elems(6).DataType = 'double';
elems(6).Complexity = 'real';
elems(6).Min = [];
elems(6).Max = [];
elems(6).DocUnits = sprintf('rad/s');
elems(6).Description = '';

elems(7) = Simulink.BusElement;
elems(7).Name = 'Beta';
elems(7).Dimensions = 1;
elems(7).DimensionsMode = 'Fixed';
elems(7).DataType = 'double';
elems(7).Complexity = 'real';
elems(7).Min = [];
elems(7).Max = [];
elems(7).DocUnits = sprintf('rad');
elems(7).Description = '';

VehicleModelBus = Simulink.Bus;
VehicleModelBus.HeaderFile = '';
VehicleModelBus.Description = '';
VehicleModelBus.DataScope = 'Auto';
VehicleModelBus.Alignment = -1;
VehicleModelBus.PreserveElementDimensions = 0;
VehicleModelBus.Elements = elems;
clear elems;
assignin('base','VehicleModelBus', VehicleModelBus);

% Bus object: PathManagerOut 
clear elems;
elems(1) = Simulink.BusElement;
elems(1).Name = 'ClosestPointX';
elems(1).Dimensions = 1;
elems(1).DimensionsMode = 'Fixed';
elems(1).DataType = 'double';
elems(1).Complexity = 'real';
elems(1).Min = [];
elems(1).Max = [];
elems(1).DocUnits = '';
elems(1).Description = sprintf('ClosestPointX');

elems(2) = Simulink.BusElement;
elems(2).Name = 'ClosestPointY';
elems(2).Dimensions = 1;
elems(2).DimensionsMode = 'Fixed';
elems(2).DataType = 'double';
elems(2).Complexity = 'real';
elems(2).Min = [];
elems(2).Max = [];
elems(2).DocUnits = '';
elems(2).Description = sprintf('ClosestPointY');

elems(3) = Simulink.BusElement;
elems(3).Name = 'ClosestPointYaw';
elems(3).Dimensions = 1;
elems(3).DimensionsMode = 'Fixed';
elems(3).DataType = 'double';
elems(3).Complexity = 'real';
elems(3).Min = [];
elems(3).Max = [];
elems(3).DocUnits = '';
elems(3).Description = sprintf('YawAngle');

elems(4) = Simulink.BusElement;
elems(4).Name = 'ClosestPointK';
elems(4).Dimensions = 1;
elems(4).DimensionsMode = 'Fixed';
elems(4).DataType = 'double';
elems(4).Complexity = 'real';
elems(4).Min = [];
elems(4).Max = [];
elems(4).DocUnits = '';
elems(4).Description = sprintf('Curvature');

elems(5) = Simulink.BusElement;
elems(5).Name = 'ClosestPointKdot';
elems(5).Dimensions = 1;
elems(5).DimensionsMode = 'Fixed';
elems(5).DataType = 'double';
elems(5).Complexity = 'real';
elems(5).Min = [];
elems(5).Max = [];
elems(5).DocUnits = '';
elems(5).Description = sprintf('DerrivativeOfCurvature');

elems(6) = Simulink.BusElement;
elems(6).Name = 'ClosestPointS';
elems(6).Dimensions = 1;
elems(6).DimensionsMode = 'Fixed';
elems(6).DataType = 'double';
elems(6).Complexity = 'real';
elems(6).Min = [];
elems(6).Max = [];
elems(6).DocUnits = '';
elems(6).Description = sprintf('Segment Length with respct to origin');

PathManagerOut = Simulink.Bus;
PathManagerOut.HeaderFile = '';
PathManagerOut.Description = '';
PathManagerOut.DataScope = 'Auto';
PathManagerOut.Alignment = -1;
PathManagerOut.PreserveElementDimensions = 0;
PathManagerOut.Elements = elems;
clear elems;
assignin('base','PathManagerOut', PathManagerOut);

