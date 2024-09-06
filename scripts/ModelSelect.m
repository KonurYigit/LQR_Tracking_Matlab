function ModelSelect
list = {"NonlinearDynamicsModel","NonlinearKinematicsModel", "LinearDynamicsModel"};   
[indx,tf] = listdlg('PromptString',{'Select a Vehicle Model.'},...
    'SelectionMode','single','ListString',list);
switch indx
    case 1
      assignin("base","ModelType",1);
      
    case 2
      assignin("base","ModelType",2);
       
    case 3
      assignin("base","ModelType",3);

end

end