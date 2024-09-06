classdef PostProcessing < matlab.System
    % This is Post Processing System Object.
    %
    % NOTE: When renaming the class name untitled, the file name
    % and constructor name must be updated to use the class name.
    %
    % This template includes most, but not all, possible properties,
    % attributes, and methods that you can implement for a System object.

    % Public, tunable properties
    properties
        
        VehicleBase (1,1) double {mustBePositive, mustBeReal} = 1
        VehicleFrontAxleToCG (1,1) double {mustBePositive, mustBeReal} = 1;
        VehicleRearAxleToCG (1,1) double {mustBePositive, mustBeReal}  = 1;
        VehicleLength (1,1) double {mustBePositive, mustBeReal} = 4;
        VehicleWidth (1,1) double {mustBePositive, mustBeReal}  = 2;
        InitialPosition_X (1,1) double {mustBeReal} = 0;
        InitialPosition_Y (1,1) double {mustBeReal} = 0;
        InitialYawAngle (1,1) double {mustBeReal} = 0;
        FieldLimitXAxis (1,2) {mustBeReal} = [-10 40];
        FieldLimitYAxis (1,2) {mustBeReal} = [-10 40];
    end

    % Public, non-tunable properties
    properties (Nontunable)

    end

    % Discrete state properties
    properties (DiscreteState)

    end

    % Pre-computed constants or internal states
    properties (Access = private)
        hndlFig;
        hndlFig2;
        hndlAxes;
        hndlAxes2;
        spltax1;
        spltax2;
        spltax3;
        spltax4;

        PathStore;

        insVehicle;
        vehicle;
        vehicleControlPoint;
        vehicleGeo;
        VechileGeoFcn;
        charac;
        tire_fr;
        tire_fl;
        tire_rr;
        tire_rl;
        len;
        

        x;
        y;
        yaw;

        h1;
        h2;
        h3;
        h4;
        h5;
        h6;

        counter;

    end

    methods
        % Constructor
        function obj = PostProcessing(varargin)
            % Support name-value pair arguments when constructing object
            setProperties(obj,nargin,varargin{:})
        end
    end

    methods (Access = protected)
        %% Common functions
        function setupImpl(obj)
            % Perform one-time calculations, such as computing constants
        end

        function stepImpl(obj,vehicleIn, ReferenceInput, TimeIn)
             obj.counter = obj.counter + 1;
             obj.x   = vehicleIn.X;
             obj.y   = vehicleIn.Y;
             obj.yaw = vehicleIn.Theta;
         


             RotationFcn = @(ang)[cos(vehicleIn.Theta) -sin(vehicleIn.Theta); ...
                          sin(vehicleIn.Theta) cos(vehicleIn.Theta)];

             for k1=1:5
                obj.vehicleControlPoint(:,k1) = RotationFcn(obj.yaw)*obj.vehicleGeo(:,k1);
             end
             obj.vehicleControlPoint(1,:) = obj.vehicleControlPoint(1,:) +obj.x;
             obj.vehicleControlPoint(2,:) = obj.vehicleControlPoint(2,:) +obj.y;
             set(obj.h1,"XData",obj.vehicleControlPoint(1,:), ...
                 "YData",obj.vehicleControlPoint(2,:), ...
                 "Color", "blue");
             set(obj.h6,"XData",obj.x,"YData",obj.y);
            
             if mod(obj.counter,12)==0
                ErrDist = sqrt((vehicleIn.X - ReferenceInput.ClosestPointX)^2 + ...
                       (vehicleIn.Y - ReferenceInput.ClosestPointY)^2);
                plot(obj.spltax1,TimeIn,ErrDist,"*","Color","b");
                ErrYaw = abs(vehicleIn.Theta - ReferenceInput.ClosestPointYaw);
                plot(obj.spltax2,TimeIn,ErrYaw,"*","Color","r")
             end

              



        end

        function resetImpl(obj)
            % Initialize / reset internal or discrete properties.
            obj.PathStore = load("./Data/PathPlanData.mat");
            close all;
            obj.hndlFig = figure;
            obj.hndlFig2= figure;

            obj.hndlAxes  = axes(obj.hndlFig);
            obj.hndlAxes2 = axes(obj.hndlFig2);
            obj.hndlAxes.XMinorGrid = "on";
            obj.hndlAxes.YMinorGrid = "on";
            obj.hndlAxes.MinorGridLineStyle = "-";

            obj.counter = 0;
            scatter(obj.hndlAxes,obj.PathStore.posesAll(:,1), ...
                obj.PathStore.posesAll(:,2), 'o', ...
                'MarkerFaceColor', 'y','DisplayName',"Smoothed Path Segments", ...
                "MarkerFaceAlpha",0.3);

            obj.spltax1 = subplot(2,2,1,"Parent",obj.hndlFig2)
            plot(0,0,"*");
            title("Distance Error")
            set(obj.spltax1,"NextPlot","add");

            obj.spltax2 = subplot(2,2,2,"Parent",obj.hndlFig2)
            plot(0,0,"*",Color="red");
            title("Yaw Angle Error");
            set(obj.spltax2,"NextPlot","add");
            % 
            % subplot(2,2,3,"Parent",obj.hndlFig2)
            % obj.spltax3 = subplot(0,0,"*");
            % hold(obj.spltax3,"on");
            % 
            % subplot(2,2,4,"Parent",obj.hndlFig2)
            % obj.spltax4 = plot(0,0,"*");
            % hold(obj.spltax4,"on")                
            % obj.charac  = zeros(2,5);
            
            obj.x       = obj.InitialPosition_X;
            obj.y       = obj.InitialPosition_Y;
            obj.vehicleControlPoint = zeros(2,5);
            obj.vehicleGeo = [-obj.VehicleLength/2, ...
                           obj.VehicleLength/2, ...
                           obj.VehicleLength/2, ...
                           -obj.VehicleLength/2, ...
                           -obj.VehicleLength/2; ...
                           -obj.VehicleWidth/2, ...
                           -obj.VehicleWidth/2, ...
                           obj.VehicleWidth/2, ...
                           obj.VehicleWidth/2, ...
                           -obj.VehicleWidth/2]; 

            % obj.rearWheelGeo =[-obj.VehicleLength/2 +0.5, ...
            %                -obj.VehicleLength/2 + 0.5 +0.4, ...
            %                obj.VehicleLength/2 + 0.5 +0.5, ...
            %                -obj.VehicleLength/2+ 0.5, ...
            %                -obj.VehicleLength/2+ 0.5; ...
            %                -obj.VehicleWidth/2 + 0.2, ...
            %                -obj.VehicleWidth/2 + 0.2, ...
            %                obj.VehicleWidth/2 - 0.2, ...
            %                obj.VehicleWidth/2 -, ...
            %                -obj.VehicleWidth/2];
            
            RotationFcn = @(ang)[cos(ang) -sin(ang);sin(ang) cos(ang)];
            for k1=1:5
                obj.vehicleControlPoint(:,k1) = RotationFcn(pi/4)*obj.vehicleGeo(:,k1);
            end
            obj.vehicleControlPoint(1,:) = obj.vehicleControlPoint(1,:) +obj.x;
            obj.vehicleControlPoint(2,:) = obj.vehicleControlPoint(2,:) +obj.y;
            
            obj.hndlAxes.MinorGridLineStyle = "-";
            obj.hndlAxes.NextPlot = "add";
            obj.h1 = plot(obj.hndlAxes,obj.vehicleControlPoint(1,:) , ...
                obj.vehicleControlPoint(2,:), ...
                "Color","blue");
            % obj.h2 = plot(obj.hndlAxes,[obj.vehicleControlPoint(1,2), ...
            %     obj.vehicleControlPoint(1,3)], ...
            %     [obj.vehicleControlPoint(2,2), ...
            %     obj.vehicleControlPoint(2,3)],"Color","blue");
            % obj.h3 = plot(obj.hndlAxes,[obj.vehicleControlPoint(1,3), ...
            %     obj.vehicleControlPoint(1,4)], ...
            %     [obj.vehicleControlPoint(2,3), ...
            %     obj.vehicleControlPoint(2,4)],"Color","blue");
            % obj.h4 = plot(obj.hndlAxes,[obj.vehicleControlPoint(1,4), ...
            %     obj.vehicleControlPoint(1,5)], ...
            %     [obj.vehicleControlPoint(2,4), ....
            %     obj.vehicleControlPoint(2,5)],"Color","blue");
            obj.h6 = plot(obj.hndlAxes,obj.x,obj.y,"*","Color","yellow", ...
                'DisplayName',"Vehicle Control Point");
            obj.hndlAxes.XLim = [10 40];
            obj.hndlAxes.YLim = obj.FieldLimitYAxis;
            grid minor;

        end
        function setPose(obj,x,y,theta)
            obj.x = x;
            obj.y = y;
            obj.yaw = theta;
        end

        %% Backup/restore functions
        function s = saveObjectImpl(obj)
            % Set properties in structure s to values in object obj

            % Set public properties and states
            s = saveObjectImpl@matlab.System(obj);

            % Set private and protected properties
            %s.myproperty = obj.myproperty;
        end

        function loadObjectImpl(obj,s,wasLocked)
            % Set properties in object obj to values in structure s

            % Set private and protected properties
            % obj.myproperty = s.myproperty; 

            % Set public properties and states
            loadObjectImpl@matlab.System(obj,s,wasLocked);
        end

        %% Advanced functions
        function validateInputsImpl(obj,u)
            % Validate inputs to the step method at initialization
        end

        function validatePropertiesImpl(obj)
            % Validate related or interdependent property values
        end

        function ds = getDiscreteStateImpl(obj)
            % Return structure of properties with DiscreteState attribute
            ds = struct([]);
        end

        function processTunedPropertiesImpl(obj)
            % Perform actions when tunable properties change
            % between calls to the System object
        end

        function flag = isInputSizeMutableImpl(obj,index)
            % Return false if input size cannot change
            % between calls to the System object
            flag = false;
        end

        function flag = isInactivePropertyImpl(obj,prop)
            % Return false if property is visible based on object 
            % configuration, for the command line and System block dialog
            flag = false;
        end
    end
end
