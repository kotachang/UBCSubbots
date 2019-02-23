# How to calibrate cameras

How to calibrate fisheye cameras for ROS: A short guide, so you don't have to waste time like I did. This is using Matlab's app 'Camera Calibrator' app.

NOTE: I wrote a script to automate this, so hopefully that will just work. It should be called `calibrationParamsToYaml.m`

Here are the steps.

1. Using the camera that you are calibrating, take a bunch of photos of a chess board. If you don't have one at hand, print one out and lay it flat on a table.

2. Open the Matlab App 'Camera Calibrator'. If you don't have it, download it.

3. Click "add images" - add the images that you took in step 1. Follow its prompts. If it rejects too many of your images, then try taking photos again. You should have a minimum of 10-15 images.

4. Once you have gone through the "add images" prompts, you should be back at the main screen. Set 'Radial Distortion' to three coefficients, and set 'Compute' to compute both skew and Tangential Distortion. I don't think we will ever really use skew, but better to have it and not need it than to need it and not have it.

5. Click calibrate

So now you can export your Camera Parameters. The next thing will be to take the cameraParams object that you get, and to throw it into a .yaml file that ROS can deal with. These two articles are what I am basing this off of.

[ROS Info](http://docs.ros.org/api/sensor_msgs/html/msg/CameraInfo.html)
[MATLAB Info](https://se.mathworks.com/help/vision/ref/cameraparameters.html)

## Here is a summary of important points. We will go through point by point

you want to end up with something like this:

```yaml
image_width: 426
image_height: 640
camera_name: camera_1
camera_matrix:
  rows: 3
  cols: 3
  data: [376.2140,-0.6361,303.6654,0,379.5469,215.8517,0,0,1.0000]
distortion_model: plumb_bob
distortion_coefficients:
  rows: 1
  cols: 5
  data: [-0.372692037397071,0.237607529602961,0.003958650775861,9.870688270667489e-04,-0.100696137659218]
rectification_matrix:
  rows: 3
  cols: 3
  data: [1, 0, 0, 0, 1, 0, 0, 0, 1]
projection_matrix:
  rows: 3
  cols: 4
  data: [376.2140,-0.6361,303.6654,0,0,379.5469,215.8517,0,0,0,1.0000,0]
```

To start, some basic setup:

```yaml
image_width: 426
image_height: 640
camera_name: camera_1
```

image width and height define width and height of the pixels. Given by matlab `cameraParams.imageSize`.
The parameter `camera_name` can be anything, but must be unique to ROS, so just don't give your cameras the same names.

```yaml
camera_matrix:
  rows: 3
  cols: 3
  data: [fx,0,cx,0,fy,cy,0,0,1.0]
```

this gives ROS a matrix to project 3D points in the camera coordinate frame to 2D pixel coordinates. It is the TRANSPOSE of the matlab matrix `cameraParams.IntrinsicMatrix`. It is given by

```yaml
     [fx  0 cx]
     [ 0 fy cy]
     [ 0  0  1]
```

where `fx`,`fy` are focal lengths, and `cx`,`cy` are principle points.

```yaml
distortion_model: plumb_bob
```

This gives a simple model of radial and tangential distortion. ROS standard.

```yaml
distortion_coefficients:
  rows: 1
  cols: 5
  data: [k1, k2, t1, t2, k3]
```

This gives ROS a bunch of distortion coefficients related to plumb bob distortion. The parameters `k1`, `k2`, `k3` are radial distortion coefficients, given by `cameraParams.RadialDistortion`. `t1` and `t2` are tangential distortion coefficients, given by `cameraParamsIMU.TangentialDistortion`.

```yaml
rectification_matrix:
  rows: 3
  cols: 3
  data: [1, 0, 0, 0, 1, 0, 0, 0, 1]
```

This is for stereo cameras. We are using monocular cameras, so this is just the identity matrix so no funny business occurs.

```yaml
projection_matrix:
  rows: 3
  cols: 4
  data: [fx', 0, cx', 0, 0, fy', cy', 0, 0, 0, 1, 0]
```

Again, this is for stereo cameras. This gives the intrinsic matrix of the rectified image for stereo images; therefore, it's just the intrinsic matrix with a zero vector tacked on. Read the ROS docs for more info on this.
