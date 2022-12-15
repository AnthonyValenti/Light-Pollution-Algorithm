%%Algo Steps%%
%1. Convert image to the LAB Colour Space
%2. Determine the image background
%3. Subtract background from the original image
%4. Inverse the image and dehaze using Contrast Enahancment
%5. Inverse again to return to normal colour's
%6. De noise the image

I = imread('pollution2.jpg');
figure('Name','Original Image')
imshow(I);

lab = rgb2lab(I);
background = imopen(lab,strel('disk',200));
J = imsubtract(lab,background);
figure('Name','Subtract Background: Lab Space');
imshow(J);

invLab = imcomplement(J(:,:,1)./100);
reduceHaze = imcomplement(imreducehaze(invLab,'ContrastEnhancement','global'));
reduceHaze(:,:,1)=reduceHaze.*100;
reduceHaze(:,:,2:3)=J(:,:,2:3)*2;
final = lab2rgb(reduceHaze);
final = imguidedfilter(final);
figure('Name','Enhanced Image: Lab Space Subtract Background at the Start');
imshow(final);

