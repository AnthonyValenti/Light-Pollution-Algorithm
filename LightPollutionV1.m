%%Algo Steps%%
%1. Determine the image background
%2. Subtract background from the original image
%3. Inverse the image and dehaze using Contrast Enahancment
%4. Inverse again to return to normal colour's
%5. De noise the image

I = imread('pollution2.jpg');
figure('Name','Original Image')
imshow(I);

background = imopen(I,strel('disk',200));
J = imsubtract(I,background);
figure('Name','Subtract Background');
imshow(J);

inverse = imcomplement(J);
dehaze = imreducehaze(inverse,'ContrastEnhancement','global');
enhanced = imcomplement(dehaze);
figure('Name','Enhanced Image');
imshow(enhanced);

enhancedAndDenoised = imguidedfilter(enhanced);
figure('Name','Enhanced Image with Denoising');
imshow(enhancedAndDenoised);
