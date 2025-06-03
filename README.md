1. After downloading tesview.zip, unzip the file and launch MATLAB. Then set MATLAB path. Choose "Add with subfolders. ".
2. Navigate to the tesview directory.
3. Enter "tesview" in the command window to activate the toolbox.
4. Choose a head model depending on your need. Currently, four models are built in the toolbox. To include more age-stratified templates, please download template_HCP.zip for head models of the white and template_CH.zip for models of the Asian, unzip the packages, and copy the template folders to the tesview/template directory.
5. Click "Add an electrode" to add electrodes.
6. Click "Remove an electrode" to remove redundant electrodes.
7. Set position and current strength for each electrode. Note that the summed currents should be zero.
8. Click "OK" to start computing. The settings will be shown in the command window upon confirmation.
9. 1-2 minutes later, windows on the right will show the resulting electric field. Please click on the images to navigate through the volume. Numbers above the windows indicate the coordinates and the intensity value of the selected voxel.
10. Remove all the existing electrodes to activate the edit box "More Electrodes". For montages involving more than six electrodes, please manually input montage settings here and click "OK". Make sure that the inputs follow the format: 'electrode1',intensity1,'electrode2',intensity2,...
11. File Export:
After completing the electric field calculation, the electric field distribution data can be exported in two formats: .mat and .nii. Click "Save" and specify the file path for each output.
12. Position Navigation (MNI & MRI Coordinate Conversion)
Enter the full coordinate position in either individual space or MNI space, then click inside any of the coordinate input boxes and press Enter. The corresponding coordinates in the other space will be displayed, and the view will navigate to the specified position in the figure window.
13. Calculating Regional Mean and Percentiles of Electric Field Intensity
First, define the region of interest for electric field intensity statistics using the "Region" menu. 
Options include:
a) Whole brain: No additional settings required.
b) Sphere: A spherical region centered at a specified point with a given radius.
Please set the center coordinates in the "Coordinates" panel, then press Enter to confirm.
Enter the radius (mm) of the spherical region in the "Radius" field.
c) Predefined ROI: Currently supports the AAL3 and BN246 atlases.
Set the ROI label (refer to the Label.xlsx file for corresponding brain region names).
Multiple regions can be selected (use commas to separate labels, and colons to specify a range of labels).
Example:
Select "Predefined ROI – AAL3".
To calculate all left-hemisphere regions defined by AAL3:
Label input:	1:2:168 
To calculate the left and right precentral gyrus regions defined by AAL3:
Label input:	1,2
14. Calculating the Mean Intensity
Select "Average". No additional parameters are needed.
Click "Calculate". The "Output" box will display the mean electric field intensity (with standard deviation) across all voxels in the selected ROI.
The indicator symbol will be placed at the center of the brain region with the smallest label value.
15. Calculating Percentiles
Select "Percentile", and set a percentile rank (input a value between [0, 100]). (To find the maximum field strength point, set the percentile to 100.)
Click "Calculate". The "Output" box will show the corresponding percentile value E(pct).
A list of the 10 voxels closest to E(pct) in intensity will be displayed below, including their coordinates in individual space and electric field strengths.
16. Reset Function
Click "Reset" to clear all data in the "Metrics" panel.






If you have any other questions or wish to join our community, feel free to contact us via tulabpsych@163.com. Thank you for your support.
