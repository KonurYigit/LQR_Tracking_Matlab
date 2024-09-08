function ControlSelect
list = {"LQR Model State Feedback","LQR True State Feedback","LQR With Integrator"};   
[indx,tf] = listdlg('PromptString',{'Select Control Variant'},...
    'SelectionMode','single','ListString',list);
switch indx
    case 1
      assignin("base","ControlVariant",1);
      set_param('top_model','SimulationCommand','Update');
    case 2
      assignin("base","ControlVariant",2);
      set_param('top_model','SimulationCommand','Update');
    case 3
      assignin("base","ControlVariant",3);
      set_param('top_model','SimulationCommand','Update');

end

end