clc; clear;
% Parameters
imageSize = [28, 28]; % [Height, Width] of the input image
numBins = 9;          % Number of orientation bins
blockSize = [2, 2];   % Block size in terms of cells (typically 2x2)

% Cell sizes to evaluate
cellSizes = [4, 2, 8]; % Cell sizes (4x4, 2x2, 8x8)

% Initialize results
disp('HOG Feature Calculation:');
for cellSize = cellSizes
    % Cell size
    cellHeight = cellSize;
    cellWidth = cellSize;
    
    % Block dimensions in pixels
    blockHeight = blockSize(1) * cellHeight;
    blockWidth = blockSize(2) * cellWidth;
    
    % Block stride (assume same as cell size for simplicity)
    blockStride = [cellHeight, cellWidth];
    
    % Number of blocks
    numBlocksY = floor((imageSize(1) - blockHeight) / blockStride(1)) + 1;
    numBlocksX = floor((imageSize(2) - blockWidth) / blockStride(2)) + 1;
    numBlocks = numBlocksY * numBlocksX;
    
    % Number of features
    numCellsPerBlock = prod(blockSize); % Number of cells per block
    numFeatures = numBlocks * numCellsPerBlock * numBins;
    
    % Display results
    fprintf('Cell Size: %dx%d -> Number of Features: %d\n', cellSize, cellSize, numFeatures);
end
