%
clear all;
clc;

rgb = imread( 'KARPUZ.jpg' );
imshow(rgb);
d = drawline;
pos = d.Position;
diffPos = diff(pos);
diameter = hypot(diffPos(1),diffPos(2))
gray_image = rgb2gray(rgb);
imshow(gray_image)
[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark')

[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', 'Sensitivity',0.9)

imshow(rgb)
h = viscircles(centers,radii);

[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', 'Sensitivity',0.92);

length(centers)

delete(h)  % Delete previously drawn circles
h = viscircles(centers,radii);

[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', 'Sensitivity',0.92,'Method','twostage');

 delete(h)
h = viscircles(centers,radii);

[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark','Sensitivity',0.95);

 delete(h)
viscircles(centers,radii);

%---------
d1 = drawline;
pos1 = d1.Position;
diffPos1 = diff(pos1);
diameter1 = hypot(diffPos1(1),diffPos1(2))

gray_image = rgb2gray(rgb);
imshow(gray_image)
[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark')

[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', 'Sensitivity',0.9)

imshow(rgb)
h = viscircles(centers,radii);

[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', 'Sensitivity',0.92);

length(centers)

delete(h)  % Delete previously drawn circles
h = viscircles(centers,radii);

[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark','Sensitivity',0.92,'Method','twostage');

 delete(h)
h = viscircles(centers,radii);

[centers,radii] = imfindcircles(rgb,[20 25],'ObjectPolarity','dark', 'Sensitivity',0.95);

 delete(h)
viscircles(centers,radii);

if diameter1<=150
    uiwait(helpdlg('The right time to harvest the second measured watermelon has not yet come.'))
end
