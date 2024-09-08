function ModelSelect
list = {"NonlinearDynamicsModel","NonlinearKinematicsModel", "LinearDynamicsModel"};   
[indx,tf] = listdlg('PromptString',{'Select a Vehicle Model.'},...
    'SelectionMode','single','ListString',list);
isModelOpen = bdIsLoaded('top_model');

switch indx
    case 1
      assignin("base","ModelType",1);
      if ~isModelOpen
          open_system("top_model");
      end
      set_param('top_model','SimulationCommand','Update');
    case 2
      assignin("base","ModelType",2);
      if ~isModelOpen
          open_system("top_model");
      end
      set_param('top_model','SimulationCommand','Update');
    case 3
      if ~isopen
          open_system("top_model");
      end
      assignin("base","ModelType",3);

end

end