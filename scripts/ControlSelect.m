function ControlSelect
list = {"LQR","LQR With Integrator"};   
[indx,tf] = listdlg('PromptString',{'Select Control Variant'},...
    'SelectionMode','single','ListString',list);
switch indx
    case 1
      assignin("base","ControlVariant",1);
      
    case 2
      assignin("base","ControlVariant",2);
       
    

end

end