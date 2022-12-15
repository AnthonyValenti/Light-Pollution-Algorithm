%%Algo Steps%%
%1. Convert image to the LAB Colour Space
%2. Inverse the image and dehaze using Contrast Enahancment
%3. Inverse again to return to normal colour's
%4. Determine the image background
%5. Subtract background from the image
%6. Sharpen the image

I = imread('pollution4.jpg');
I = imresize(I,[400 600]);
figure('Name','Original Image')
imshow(I);

lab = rgb2lab(I);
invLab = imcomplement(lab(:,:,1)./100);
reduceHaze = imcomplement(imreducehaze(invLab,'ContrastEnhancement','global'));
reduceHaze(:,:,1)=reduceHaze.*100;
reduceHaze(:,:,2:3)=lab(:,:,2:3)*2;
final = lab2rgb(reduceHaze);
figure('Name','Enhanced Image: LAB Colour Space');
imshow(final);

background = imopen(final,strel('disk',200));
figure('Name','Background');
imshow(background);
final2 = imsubtract(final,background);
figure('Name','Enhanced Image: Lab Space Subtract Background at the End');
imshow(final2);


sharpened = imsharpen(final2,"Threshold",0.8);
figure('Name','Enhanced Image: Sharpened');
imshow(sharpened);
