# Image-color- based-segmentation-masking-and-etc

  ## Project- Harvest Time Alert
     
Our aim is to create a program that informs the harvest time of the photos taken with a camera set up in a garden, by subjecting them to some processes in the system.

We passed the pictures taken by the camera through the image processing stages and obtained a printout about the type of product.

First of all, in order not to mislead the code, non-product elements were deleted and the roughness in the picture was removed. With the help of the written function [seg.m](https://github.com/akkocz17/Image-segmentation-masking-and-etc/blob/main/seg.m), the pictures filtered using RGB channels were separated into their colors. The fruit and vegetable images that were separated with the appropriate filter were automatically combined and saved.

![image](https://user-images.githubusercontent.com/88335393/203012035-afc283e3-1d0e-4566-88fa-f71b0fc99cbb.png)

![image](https://user-images.githubusercontent.com/88335393/203012290-7a37aeed-7186-4e57-9df5-60e578dfa5bb.png)


In the next step, the code [decision_of_type.m](https://github.com/akkocz17/Image-segmentation-masking-and-etc/blob/main/decision_of_type.m) giving information about the type of fruit and vegetable was written by looking at the color of the fruit and vegetable. The two processed images were combined and differentiated into their types.

![image](https://user-images.githubusercontent.com/88335393/203014343-3a7458a9-9524-4f19-b477-768039365b91.png)


In line with the resulting output, the maturity decision was made according to the color of the fruit and vegetable and it was printed on the screen.

![image](https://user-images.githubusercontent.com/88335393/203014902-714a58f6-a5d5-4094-8ac5-479b058698d5.png)


Contributers;

Aysu Arda   and   Zeynep Akkoç
