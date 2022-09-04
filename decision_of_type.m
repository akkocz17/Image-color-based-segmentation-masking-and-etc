clear all;
clc;
%Program print the types of fruits and vegetables.
he = imread( 'tomato.jpeg' ); 
je = imread( 'banana.jpeg' );  
lab_he = rgb2lab(he); 
lab_je = rgb2lab(je);
ab = lab_he(:,:,2:3); 
ab = im2single(ab); 
ac = lab_je(:,:,2:3); 
ac = im2single(ac);
nColors= 3;  
pixel_labels1 = imsegkmeans(ab, nColors, 'NumAttempts' ,3);
pixel_labels2 = imsegkmeans(ac, nColors, 'NumAttempts' ,3);

mask1 = pixel_labels1==1;
cluster1 = he .* uint8(mask1);
mask3 = pixel_labels2==1;
cluster3 = je .* uint8(mask3);
combImg = imfuse(cluster3, cluster1, 'montage');
subplot(2,2,3); image(combImg);

imwrite(combImg,'final.png');
format long g;
format compact;
fontSize = 16;
baseFileName = 'final.png';
folder = pwd
fullFileName = fullfile(folder, baseFileName);
rgbImage = imread(fullFileName);
[rows, columns, numberOfColorChannels] = size(rgbImage)
subplot(2, 2, 1);
imshow(rgbImage, []);
axis on;
caption = sprintf('Original Image\n%s', baseFileName);
title(caption, 'FontSize', fontSize, 'Interpreter', 'None');
hp = impixelinfo(); 
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0.05 1 0.95]);
set(gcf, 'Name', 'Types', 'NumberTitle', 'Off')
drawnow;
[BW, maskedRGBImage] = createMask(rgbImage);
subplot(2, 2, 2);
imshow(BW);
title('Black-White', 'FontSize', fontSize, 'Interpreter', 'None');
axis on;
drawnow;
fruitMask = imfill(BW, 'holes');
fruitMask = bwareaopen(fruitMask, 1000);
subplot(2, 2, 3);
imshow(fruitMask);
title('Masked Image ', 'FontSize', fontSize, 'Interpreter', 'None');
axis on;
drawnow;
maskedRGBImage = bsxfun(@times, rgbImage, cast(fruitMask, 'like', rgbImage));
subplot(2, 2, 4);
imshow(maskedRGBImage);
title('Types', 'FontSize', fontSize, 'Interpreter', 'None');
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
Tomatocolor = [192,3,2,255];
Bananacolor = [135,182,17,255];
hold on;
for k = 1 : length(propsR)
  thisColor = [redMeans(k), greenMeans(k), blueMeans(k)];
  distanceToTomato = sqrt((thisColor(1) - Tomatocolor(1)) .^ 2 + ...
    (thisColor(2) - Tomatocolor(2)) .^ 2 + ...
    (thisColor(3) - Tomatocolor(3)) .^ 2);
  distanceToBanana = sqrt((thisColor(1) - Bananacolor(1)) .^ 2 + ...
    (thisColor(2) - Bananacolor(2)) .^ 2 + ...
    (thisColor(3) - Bananacolor(3)) .^ 2);
  fprintf('For blob #%d,\n    Distance to Tomato = %f, distance to Banana = %f.\n', distanceToTomato, distanceToBanana);
  xCenter = propsR(k).Centroid(1);
  yCenter = propsR(k).Centroid(2);
  if distanceToTomato < distanceToBanana
    text(xCenter, yCenter, 'Tomato', 'Color', 'w', 'FontSize', fontSize, 'FontWeight', 'bold');
  else
    text(xCenter, yCenter, 'Banana', 'Color', 'w', 'FontSize', fontSize, 'FontWeight', 'bold');
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