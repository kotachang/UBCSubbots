%% cameraParams to Yaml File

% The purpose of this script is to automate the process of converting a 
% matlab cameraParams object to a yaml file that ROS can read.
% I wrote a bit of documentation on this, titled 'How To Calibrate Cameras'
% if you want to know whats going on. If not, here is what you have to
% do for this to work.
%   1. Type the name of your cameraParams object to the variable
%      'cameraParamObj' below (most likely, it is called cameraParams). You have
%      to have your camera params in the same workspace. If you just ran the
%      calibration session with matlab, this should be set up. If not, you can
%      double click your cameraParams file (titled something like 
%      'cameraParams.mat') to open it.
%   2. Replace the name of your output file for the fileId variable.
%   3. Name your camera with the camera_name variable. It can be anything,
%      as long as it is not named the same as another camera that ROS is
%      using.
%   4. Run the file and enjoy!

cameraParamObj = cameraParamsIMU;
fileID = fopen('OUTPUT_FILE.yaml','w');
camera_name = 'CAMERA_NAME';


iMT = cameraParams.IntrinsicMatrix';
rd = cameraParams.RadialDistortion;
td = cameraParams.TangentialDistortion;

fprintf(fileID,'image_width: %d\n',cameraParamObj.ImageSize(1,1));
fprintf(fileID,'image_width: %d\n',cameraParamObj.ImageSize(1,2));
fprintf(fileID,'camera_name: %s\n', camera_name);
fprintf(fileID,'camera_matrix:\n  rows: 3\n  cols: 3\n  data: [%9f %9f %9f %9f %9f %9f %9f %9f %9f]\n', ...
    iMT(1,1), iMT(1,2), iMT(1,3), ...
    iMT(2,1), iMT(2,2), iMT(2,3), ...
    iMT(3,1), iMT(3,2), iMT(3,3));

fprintf(fileID,'distortion_model: plumb_bob\n');
fprintf(fileID,'distortion_coefficients:\n  rows: 1\n  cols: 5\n  data: [%9f %9f %9f %9f %9f]\n', ...
    rd(1,1), rd(1,2), td(1,1), td(1,2), rd(1,3));

fprintf(fileID,'rectification_matrix:\n  rows: 3\n  cols: 3\n  data: [1, 0, 0, 0, 1, 0, 0, 0, 1]\n');
fprintf(fileID,'projection_matrix:\n  rows: 3\n  cols: 4\n  data: [%9f %9f %9f 0 %9f %9f %9f 0 %9f %9f %9f 0]',...
    iMT(1,1), iMT(1,2), iMT(1,3), ...
    iMT(2,1), iMT(2,2), iMT(2,3), ...
    iMT(3,1), iMT(3,2), iMT(3,3));

