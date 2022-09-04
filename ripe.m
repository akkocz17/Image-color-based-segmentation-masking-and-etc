clear all;
clc;
%Decision of Ripeness

combImg=seg('tomato.jpeg','domates');

imwrite(combImg,'combine.png');
format long g;
format compact;
fontSize = 16;
baseFileName = 'combine.png';
folder = pwd
fullFileName = fullfile(folder, baseFileName);
if ~exist(fullFileName, 'file')
  
  fullFileNameOnSearchPath = baseFileName; 
  if ~exist(fullFileNameOnSearchPath, 'file')
    
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end

rgbImage = imread(fullFileName);
[rows, columns, numberOfColorChannels] = size(rgbImage)
figure(2);
subplot(2, 2, 1);
imshow(rgbImage, []);
axis on;
caption = sprintf('Original Color Image\n%s', baseFileName);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
hp = impixelinfo(); 
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0.05 1 0.95]);
set(gcf, 'Name', 'Ripeness', 'NumberTitle', 'Off')
drawnow;
[BW, maskedRGBImage] = createMask(rgbImage);
subplot(2, 2, 2);
imshow(BW);
title('Color Segmentation', 'FontSize', fontSize, 'Interpreter', 'None');
axis on;
drawnow;
fruitMask = imfill(BW, 'holes');
fruitMask = bwareaopen(fruitMask, 1000);
subplot(2, 2, 3);
imshow(fruitMask);
title('Final Mask', 'FontSize', fontSize, 'Interpreter', 'None');
axis on;
drawnow;
maskedRGBImage = bsxfun(@times, rgbImage, cast(fruitMask, 'like', rgbImage));
subplot(2, 2, 4);
imshow(maskedRGBImage);
title('Final Masked Image', 'FontSize', fontSize, 'Interpreter', 'None');
axis on;
drawnow;
redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);
propsR = regionprops(fruitMask, redChannel, 'MeanIntensity', 'Centroid');
propsG = regionprops(fruitMask, greenChannel, 'MeanIntensity');
propsB = regionprops(fruitMask, blueChannel, 'MeanIntensity');
redMeans = [propsR.MeanIntensity]
greenMeans = [propsG.MeanIntensity]
blueMeans = [propsB.MeanIntensity]
 ripeColor = [192,3,2,255];%domates
 unripeColor = [135,182,17,255];
% ripeColor = [205,168,53];%muz
% unripeColor = [134,188,16];

hold on;
for k = 1 : length(propsR)
  thisColor = [redMeans(k), greenMeans(k), blueMeans(k)];
  distanceToRipe = sqrt((thisColor(1) - ripeColor(1)) .^ 2 + ...
    (thisColor(2) - ripeColor(2)) .^ 2 + ...
    (thisColor(3) - ripeColor(3)) .^ 2);
  distanceToUnripe = sqrt((thisColor(1) - unripeColor(1)) .^ 2 + ...
    (thisColor(2) - unripeColor(2)) .^ 2 + ...
    (thisColor(3) - unripeColor(3)) .^ 2);
  fprintf('For blob #%d,\n    Distance to Ripe = %f, distance to Unripe = %f.\n', distanceToRipe, distanceToUnripe);
  xCenter = propsR(k).Centroid(1);
  yCenter = propsR(k).Centroid(2);
  if distanceToRipe < distanceToUnripe
    text(xCenter, yCenter, 'Ripe', 'Color', 'w', 'FontSize', fontSize, 'FontWeight', 'bold');
  else
    text(xCenter, yCenter, 'Unripe', 'Color', 'b', 'FontSize', fontSize, 'FontWeight', 'bold');
  end
end
function [BW,maskedRGBImage] = createMask(RGB)

I = rgb2hsv(RGB);
channel1Min = 0.000;
channel1Max = 1.000;
channel2Min = 0.338;
channel2Max = 1.000;
channel3Min = 0.000;
channel3Max = 1.000;
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
  (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
  (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;
maskedRGBImage = RGB;
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;
end