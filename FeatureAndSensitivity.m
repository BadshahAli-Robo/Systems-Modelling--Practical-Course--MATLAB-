clc; %clear;

%%%%% Load training and test data using |imageDatastore|.
% install Machine Learning Toolbox and Computer Vision Toolbox 
syntheticDir   = fullfile(toolboxdir('vision'),'visiondata','digits','synthetic');
handwrittenDir = fullfile(toolboxdir('vision'),'visiondata','digits','handwritten');
   %the commands return full paths from the toolbox directory and the given subdirectories 

%%%%%% |imageDatastore| recursively scans the directory tree containing the
% images. Folder names are automatically used as labels for each image.
trainingSet = imageDatastore(syntheticDir,'IncludeSubfolders',true,'LabelSource','foldernames');
testSet = imageDatastore(handwrittenDir,'IncludeSubfolders',true,'LabelSource','foldernames');
   %the commands open the set from the given folder, including its subfolders and name the data as folder names 


%%%%% Viewing the label count for each set
%countEachLabel(trainingSet)
%countEachLabel(testSet)


%%%%% Looking at the training data
%figure;

% examples of the training data 
%subplot(2,3,1); imshow(trainingSet.Files{102});
%subplot(2,3,2); imshow(trainingSet.Files{304});
%subplot(2,3,3); imshow(trainingSet.Files{809});
%subplot(2,3,4); imshow(testSet.Files{13});
%subplot(2,3,5); imshow(testSet.Files{37});
%subplot(2,3,6); imshow(testSet.Files{97});


%%%%% Show pre-processing results
%exTestImage = readimage(testSet,37);
%processedImage = imbinarize(im2gray(exTestImage));  %Binarize 2-D grayscale image or 3-D volume by thresholding

%figure;

%subplot(1,2,1); imshow(exTestImage); 
%subplot(1,2,2); imshow(processedImage); 


%%%%% Feature Extraction

  %HOG (Histogram of Oriented Gradients) determines: 
  % 1. the gradients magnitude and 2. the gradients direction 
  % it defines the direction of each edge within images 
  % it can be used as a descriptor to define local objects and their shape
  % it is calculated according the magnitude of gradients at a certain orientation.


img = readimage(trainingSet, 206);

% Extract HOG features and HOG visualization 
[hog_2x2, vis2x2] = extractHOGFeatures(img,'CellSize',[2 2]);
[hog_4x4, vis4x4] = extractHOGFeatures(img,'CellSize',[4 4]);
[hog_8x8, vis8x8] = extractHOGFeatures(img,'CellSize',[8 8]);

% Show the original image
figure; 
subplot(2,3,1:3); imshow(img);

% Visualize the HOG features
subplot(2,3,4); plot(vis2x2); title({'CellSize = [2 2]'});
subplot(2,3,5); plot(vis4x4); title({'CellSize = [4 4]'});
subplot(2,3,6); plot(vis8x8); title({'CellSize = [8 8]'});

%cellSize = [8 8]; hogFeatureSize = length(hog_8x8);  %.25  %.25
%cellSize = [4 4]; hogFeatureSize = length(hog_4x4);  %.33  %.42
%cellSize = [2 2]; hogFeatureSize = length(hog_2x2); %.50   %.33
disp(hogFeatureSize);
% Loop over the trainingSet and extract HOG features from each image. 
% A similar procedure will be used to extract features from the testSet.

numImages = numel(trainingSet.Files);
trainingFeatures = zeros(numImages,hogFeatureSize,'single');
disp(numImages);
disp(hogFeatureSize);

for i = 1:numImages
    img = readimage(trainingSet,i);
    img = im2gray(img);  %each image from the training set extracted and converted to black and white 
   % Apply pre-processing steps
    img = imbinarize(img);  %binarized to 2D image scale 
    trainingFeatures(i, :) = extractHOGFeatures(img,'CellSize',cellSize);  %extracts HOG features
end


%%%%% Get labels for each image.
trainingLabels = trainingSet.Labels;
disp(length(trainingLabels))  %print number of values 

classifier = fitcecoc(trainingFeatures, trainingLabels);
 %for each image of a digit, classifier assigns a label associated with it, i.e. the digit it represents 


%%%%% Extract HOG features from the test set. The procedure is similar to what
  %was shown earlier and is encapsulated as a helper function for brevity.
[testFeatures, testLabels] = helperExtractHOGFeaturesFromImageSet(testSet, hogFeatureSize, cellSize);


%%%%% Make class predictions using the test features.
predictedLabels = predict(classifier, testFeatures);


%%%%% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);
helperDisplayConfusionMatrix(confMat);


%%%%% Support Functions
function helperDisplayConfusionMatrix(confMat) % Display the confusion matrix in a formatted table.
confMat = bsxfun(@rdivide,confMat,sum(confMat,2));  % Convert confusion matrix into percentage form
digits = '0':'9'; 
colHeadings = arrayfun(@(x)sprintf('%d',x),0:9,'UniformOutput',false); %headings of columns in a cell array 
format = repmat('%-9s',1,11); %heading format 
header = sprintf(format,'digit  |',colHeadings{:}); %headings of actual values on each row 
fprintf('\n%s\n%s\n',header,repmat('-',size(header))); %print a line of -
for idx = 1:numel(digits) %in each row, print: 
    fprintf('%-9s',   [digits(idx) '      |']); %the label of the actual value 
    fprintf('%-9.2f', confMat(idx,:));  %different predicted values (0-9) 
    fprintf('\n');  %new line 
end
end

function [features, setLabels] = helperExtractHOGFeaturesFromImageSet(imds, hogFeatureSize, cellSize) 
setLabels = imds.Labels;  % Extract HOG features from an imageDatastore.
numImages = numel(imds.Files);
features  = zeros(numImages,hogFeatureSize,'single');

for j = 1:numImages  % Process each image and extract features
    img = readimage(imds,j);
    img = im2gray(img);
    % Apply pre-processing steps
    img = imbinarize(img);
    features(j, :) = extractHOGFeatures(img,'CellSize',cellSize);
end
end