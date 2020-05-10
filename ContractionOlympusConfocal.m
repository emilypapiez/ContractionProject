addpath("/Volumes/Emily_Project/Data/Project Data")
%This is code for measuring tissue area contraction in microtissues
%overtime. In order for this code to work, you need to already know the
%radius of your agarose pegs in your images (in pixels) which you can
%measure with the PegMeasurment.M code. 

%list all of your sample names. The Phase files are used to place the
%locations of the pegs, as you can see the pegs in the phase. From the peg
%positions, the center circle position can be calculated. The Binary
%files are black and white processed images made from the phase files. This
%code places the calculated center circle onto the Binary file and measures
%the number of white pixels within the circle (white pixels are the
%tissue). The final output is a percentage of the circle area that the
%tissue covers.

%   *Make sure you can see all of your files in the folder on the left

%File Naming: FileType_Experiment_Plate_SampleNumber_DIV
%           *FileType = Phase File, or Binary (black and white) File 
%           *Experiment = experiment number, predetermined by the
%                           dissociation day / pups included
%           *Plate = Plate number that the microtissues were seeded on
%           *SampleNumber = unique number to identify each microtissue
%           *DIV = Day in vitro that the image was taken 
SamplesB = {'Binary_6_2_1_22','Binary_6_2_1_3','Binary_6_2_1_4', 'Binary_6_2_1_5','Binary_6_2_1_6','Binary_6_2_1_7','Binary_6_2_1_8','Binary_6_2_1_9','Binary_6_2_1_10','Binary_6_2_1_11','Ctrl_6_2_1_12','Binary_6_2_1_13','Binary_6_2_1_14','Binary_6_2_1_15','Binary_6_2_1_16','Binary_6_2_1_18','Binary_6_2_1_20';
            'Binary_6_2_2_2','Binary_6_2_2_3','Binary_6_2_2_4', 'Binary_6_2_2_5','Binary_6_2_2_6','Binary_6_2_2_7','Binary_6_2_2_8','Binary_6_2_2_9','Binary_6_2_2_10','Binary_6_2_2_11','Binary_6_2_2_12','Binary_6_2_2_13','Binary_6_2_2_14','Binary_6_2_2_15','Binary_6_2_2_16','Binary_6_2_2_18','Binary_6_2_2_20';
            'Binary_6_2_3_2','Binary_6_2_3_3','Binary_6_2_3_4', 'Binary_6_2_3_5','Binary_6_2_3_6','Binary_6_2_3_7','Binary_6_2_3_8','Binary_6_2_3_9','Binary_6_2_3_10','Binary_6_2_3_11','Binary_6_2_3_12','Binary_6_2_3_13','Binary_6_2_3_14','Binary_6_2_3_15','Binary_6_2_3_16','Binary_6_2_3_18','Binary_6_2_3_20';
            'Binary_6_2_4_2','Binary_6_2_4_3','Binary_6_2_4_4', 'Binary_6_2_4_5','Binary_6_2_4_6','Binary_6_2_4_7','Binary_6_2_4_8','Binary_6_2_4_9','Binary_6_2_4_10','Binary_6_2_4_11','Binary_6_2_4_12','Binary_6_2_4_13','Binary_6_2_4_14','Binary_6_2_4_15','Binary_6_2_4_16','Binary_6_2_4_18','Binary_6_2_4_20';
            'Binary_6_2_5_2','Binary_6_2_5_3','Binary_6_2_5_4', 'Binary_6_2_5_5','Binary_6_2_5_6','Binary_6_2_5_7','Binary_6_2_5_8','Binary_6_2_5_9','Binary_6_2_5_10','Binary_6_2_5_11','Binary_6_2_5_12','Binary_6_2_5_13','Binary_6_2_5_14','Binary_6_2_5_15','Binary_6_2_5_16','Binary_6_2_5_18','Binary_6_2_5_20'};
SamplesP = {'Phase_6_2_1_22','Phase_6_2_1_3','Phase_6_2_1_4','Phase_6_2_1_5','Phase_6_2_1_6','Phase_6_2_1_7','Phase_6_2_1_8','Phase_6_2_1_9','Phase_6_2_1_10','Phase_6_2_1_11','Phase_6_2_1_12','Phase_6_2_1_13','Phase_6_2_1_14','Phase_6_2_1_15','Phase_6_2_1_16','Phase_6_2_1_18','Phase_6_2_1_20';
            'Phase_6_2_2_2','Phase_6_2_2_3','Phase_6_2_2_4','Phase_6_2_2_5','Phase_6_2_2_6','Phase_6_2_2_7','Phase_6_2_2_8','Phase_6_2_2_9','Phase_6_2_2_10','Phase_6_2_2_11','Phase_6_2_2_12','Phase_6_2_2_13','Phase_6_2_2_14','Phase_6_2_2_15','Phase_6_2_2_16','Phase_6_2_2_18','Phase_6_2_2_20';
            'Phase_6_2_3_2','Phase_6_2_3_3','Phase_6_2_3_4','Phase_6_2_3_5','Phase_6_2_3_6','Phase_6_2_3_7','Phase_6_2_3_8','Phase_6_2_3_9','Phase_6_2_3_10','Phase_6_2_3_11','Phase_6_2_3_12','Phase_6_2_3_13','Phase_6_2_3_14','Phase_6_2_3_15','Phase_6_2_3_16','Phase_6_2_3_18','Phase_6_2_3_20';
            'Phase_6_2_4_2','Phase_6_2_4_3','Phase_6_2_4_4','Phase_6_2_4_5','Phase_6_2_4_6','Phase_6_2_4_7','Phase_6_2_4_8','Phase_6_2_4_9','Phase_6_2_4_10','Phase_6_2_4_11','Phase_6_2_4_12','Phase_6_2_4_13','Phase_6_2_4_14','Phase_6_2_4_15','Phase_6_2_4_16','Phase_6_2_4_18','Phase_6_2_4_20';
            'Phase_6_2_5_2','Phase_6_2_5_3','Phase_6_2_5_4','Phase_6_2_5_5','Phase_6_2_5_6','Phase_6_2_5_7','Phase_6_2_5_8','Phase_6_2_5_9','Phase_6_2_5_10','Phase_6_2_5_11','Phase_6_2_5_12','Phase_6_2_5_13','Phase_6_2_5_14','Phase_6_2_5_15','Phase_6_2_5_16','Phase_6_2_5_18','Phase_6_2_5_20'};

        
r =  131.467; % set the radius of the peg, specific to image size
rROI = 230; %set the radius of the center circle
white = 127118520; %set the number of pixels in the center circle by measuring the value of the circle on a white image 
FileType = '.jpg'; %set the file type, should be jpg
contraction = []; %make an empty array for the tissue area calculation values
centerROI = [];% make an empty array for the center circle position values

for n = 1:1 %For Loop to go through sample numbers position (in the array) first : last
    for i= 11:11 %Loop to go through days in vitro position (in the array) first : last
Samp = strcat(SamplesP{n,i},FileType); %Set Phase file name
Samp2 = strcat(SamplesB{n,i}, FileType);%Set Binary File Name
I = imread(Samp); %read the phase file
figure
imshow(I); %show the phase file
pegs = 2; %set the number of pegs - should stay at 4 
rpeg = []; %set an empty array to keep track of the peg positions
for t = 1:pegs % For loop to record position for each peg

    doublePoints = [];
    title(strcat(Samp, 'Peg Selection - PEG', num2str(t), ' - Select 3 points'))
    a1 = drawpoint('Color', 'w');
    doublePoints = cat(2, doublePoints,a1.Position');
    a2 = drawpoint('Color', 'w');
    doublePoints = cat(2, doublePoints,a2.Position');
    cp= drawpoint('Color', 'w'); 
%this code calculates the two different circles that can be made from the
%two perimeter points and determines which circle has a center that is
%close to the center point click you make
    b = sym('a',[2,1],'real');
    eqs = [1,1]*(doublePoints - repmat(b(:),1,2)).^2 - r^2;
    sol = vpasolve(eqs,b);
    ss = struct2cell(sol);
    center = double([ss{:}]);
    cd1 = sqrt( (center(1,1)-cp.Position(1,1))^2 + (center(1,2)-cp.Position(1,2))^2);
    cd2 = sqrt( (center(2,1)-cp.Position(1,1))^2 + (center(2,2)-cp.Position(1,2))^2);
    p=2;
    if cd1< cd2
        p = 1; 
    end
    
      d = drawcircle('Center', center(p,:), 'Radius',r,'Color', 'm'); %draw a circle around the peg perimeter
    pegcoord=[];
    pegcoord = cat(2, pegcoord,center(p,:)); %coordinate of the peg center point
    rpeg = cat(1,rpeg, pegcoord); %record the peg center point in an array
  %repeats for all pegs
end 

p1 = drawline('Position', [rpeg(1,:);rpeg(2,:)]); %draws line between pegs 1 and 2
xi= (rpeg(1,1)+rpeg(2,1))/2; %x value of midpoint
yi= (rpeg(1,2)+rpeg(2,2))/2; %y value of midpoint

centerROI(i,:) = [xi, yi];
f = drawcircle('Center', centerROI(i,:), 'Radius', rROI, 'Color', 'c');
ROI = createMask(f);

%ROIMasks(:,:,i) = ROI;

I2 = imread(Samp2);
figure 
imshow(I2)
%drawcircle('Center', centerROI, 'Radius', rROI, 'Color', 'c');

%ROI = ROIMasks(:,:,i);
currentROI = bsxfun(@times,I2, cast(ROI, class(I2)));
    m = sum(I2(logical(currentROI))); %calulate the sum of pixel values (1 white pixel = 1, so the sum is the number of white pixels);
contraction(n,i) =  (m/white)*100; %calculate the % area of tissue coverage by dividing the sum by the total pixels(white)

end
    end

figure
%scatter(contraction(2,:), contraction(1,:));
ylim([0 100]);

%you can copy the contraction values by double clicking the
%contraction matrix 