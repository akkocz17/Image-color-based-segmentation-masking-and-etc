function combImg = seg(m,n)
%The function that making color segmentation.
%m the name of the image and n is the type of fruit.
he = imread( m ); 
lab_he = rgb2lab(he); 
ab = lab_he(:,:,2:3); 
ab = im2single(ab); 
nColors= 3;
pixel_labels = imsegkmeans(ab, nColors, 'NumAttempts' ,3);
switch n
    case 'domates'
        mask1 = pixel_labels==1;
        cluster1 = he .* uint8(mask1);
        mask3 = pixel_labels==3;
        cluster3 = he .* uint8(mask3);
    case 'çilek'
       mask1 = pixel_labels==2;
      cluster1 = he .* uint8(mask1);
      mask3 = pixel_labels==3;
      cluster3 = he .* uint8(mask3);
    case 'muz'
        mask1 = pixel_labels==3;
        cluster1 = he .* uint8(mask1);
        sari = imread( 'ripebanana.jpeg' ); 
        lab_sari = rgb2lab(sari);
        abs = lab_sari(:,:,2:3); 
        abs = im2single(abs); 
        nColorss= 3;  
        pixel_label = imsegkmeans(abs, nColorss, 'NumAttempts' ,3);
        mask2 = pixel_label==1;
        cluster3 = sari .* uint8(mask2);
      otherwise
        display('Not found');
end

subplot(2,2,1); image(cluster1);
subplot(2,2,2); image(cluster3);
combImg = imfuse(cluster1, cluster3, 'montage');
subplot(2,2,3); image(combImg);

end

