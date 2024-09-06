classdef vehicleplot < handle
 % Written By : Konur Yigit
    properties
        backtotire = 0.5;
        len = 3.5;
        width = 2;
        wheellen = 0.3;
        wheelwid = 0.1;
        tread = 0.1;
        wb  = 3;
        
        charac = zeros(2,5);
        tire_fr = zeros(2,5);
        tire_fl = zeros(2,5);
        tire_rr = zeros(2,5);
        tire_rl = zeros(2,5);
        
        x = 0.;
        y = 0.
        yaw = 0.
        steer = 0;
        
        max_steer_angle = pi/4;
        
        tempnum = 0;
        h1 = 0;
        h2 = 0;
        h3 = 0;
        h4 = 0;
        h5 = 0;
        h6 = 6;
        
    end
    
    methods
        function ins = vehicleplot(ins)
            
            
                ins.backtotire = 1.;
                ins.len = 3;
                ins.width = 2.9;
                ins.wb = 2.5;
                ins.wheellen = .3;
                ins.wheelwid = .2;
                
            
            
        end
        
        function plot(ins, tempHndl)
            ins.charac = [-ins.backtotire, (ins.len-ins.backtotire), ...
                (ins.len-ins.backtotire), -ins.backtotire, -ins.backtotire; ...
                .5*ins.width, .5*ins.width, -.5*ins.width, -.5*ins.width, .5*ins.width]; 
            
            ins.tire_fr = [ins.wheellen, -ins.wheellen, -ins.wheellen, ins.wheellen, ins.wheellen; ...
                (-ins.wheelwid-ins.tread), (-ins.wheelwid-ins.tread), (ins.wheelwid-ins.tread), (ins.wheelwid-ins.tread), ...
                (-ins.wheelwid-ins.tread)];
           
            ins.tire_rr = ins.tire_fr;
            ins.tire_fl = ins.tire_fr;
            ins.tire_fl(2,:) = ins.tire_fl(2,:)*-1;
            ins.tire_rl      = ins.tire_rr;
            ins.tire_rl(2,:) = ins.tire_rl(2,:)*-1;
            
            RotationMatrix1 = [cos(ins.yaw), sin(ins.yaw); ...
                -sin(ins.yaw), cos(ins.yaw)];
            
            RotationMatrix2 = [cos(ins.yaw), sin(ins.yaw); ...
                -sin(ins.yaw), cos(ins.yaw)];
                
            ins.tire_fr = (ins.tire_fr'*RotationMatrix2)';
            ins.tire_fl = (ins.tire_fl'*RotationMatrix2)';
            ins.tire_fr(1,:) = ins.tire_fr(1,:)  + ins.wb;
            ins.tire_fl(1,:) = ins.tire_fl(1,:)  + ins.wb;
            
            ins.charac = (ins.charac'*RotationMatrix1)';
            ins.tire_fr = (ins.tire_fr'*RotationMatrix1)';
            ins.tire_fl = (ins.tire_fl'*RotationMatrix1)';
            
            ins.charac(1,:) = ins.charac(1,:)  + ins.x;
            ins.charac(2,:) = ins.charac(2,:)  + ins.y;
            ins.tire_fl(1,:) = ins.tire_fl(1,:)  + ins.x;
            ins.tire_fl(2,:) = ins.tire_fl(2,:)  + ins.y;
            ins.tire_rl(1,:) = ins.tire_rl(1,:)  + ins.x;
            ins.tire_rl(2,:) = ins.tire_rl(2,:)  + ins.y;
            ins.tire_fr(1,:) = ins.tire_fr(1,:)  + ins.x;
            ins.tire_fr(2,:) = ins.tire_fr(2,:)  + ins.y;
            ins.tire_rr(1,:) = ins.tire_rr(1,:)  + ins.x;
            ins.tire_rr(2,:) = ins.tire_rr(2,:)  + ins.y;
            
            if ins.tempnum==0
                
                ins.h1 = plot(tempHndl,ins.charac(1,:),ins.charac(2,:),"Color","green");
                ins.h2 = plot(tempHndl,ins.tire_fr(1,:),ins.tire_fr(2,:),"Color","blue");
                ins.h3 = plot(tempHndl,ins.tire_rr(1,:),ins.tire_rr(2,:),"Color","blue");
                ins.h4 = plot(tempHndl,ins.tire_fl(1,:),ins.tire_fl(2,:),"Color","blue");
                ins.h3 = plot(tempHndl,ins.tire_rl(1,:),ins.tire_rl(2,:),"Color","blue");
                ins.h6 = plot(tempHndl,ins.x,ins.y,"*");
                ins.tempnum = 1;
            else
                set(ins.h1,"XData",ins.charac(1,:),"YData",ins.charac(2, :));
                set(ins.h2,"XData",ins.tire_fr(1,:),"YData",ins.tire_fr(2, :));
                set(ins.h3,"XData",ins.tire_rr(1,:),"YData",ins.tire_rr(2, :));
                set(ins.h4,"XData",ins.tire_fl(1,:),"YData",ins.tire_fl(2, :));
                set(ins.h2,"XData",ins.tire_rl(1,:),"YData",ins.tire_rl(2, :));
                
            end
            
        end
        
        function setPose(ins, x0,y0, yaw0)
            ins.x = x0;
            ins.y = y0;
            ins.yaw = yaw0;
        end
    end
end