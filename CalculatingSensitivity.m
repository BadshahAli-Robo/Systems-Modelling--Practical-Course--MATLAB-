% Define confusion matrices for HOG configurations
% Replace these with your actual confusion matrices
confMat_4x4 = [
    50 2  0  0  0  0  0  0  0  0;
    1  48 1  0  0  0  0  0  0  0;
    0  0  47 2  0  0  0  0  1  0;
    0  0  2  46 1  0  0  0  0  1;
    0  0  0  1  49 0  0  0  0  0;
    0  0  0  0  0  45 3  0  1  1;
    0  0  0  0  0  1  48 0  1  0;
    0  0  0  0  0  0  0  49 1  0;
    0  0  0  0  0  1  0  0  48 1;
    0  0  0  0  0  0  0  0  1  49
];

confMat_2x2 = confMat_4x4 + randi([-1, 1], size(confMat_4x4)); % Example variation
confMat_8x8 = confMat_4x4 - randi([-1, 1], size(confMat_4x4)); % Example variation

% Specify the digit for sensitivity calculation (digit '5' -> index 6 in 1-based MATLAB indexing)
digit = 6; 

% Calculate sensitivity for each HOG configuration
sensitivity_4x4 = calculateSensitivity(confMat_4x4, digit);
sensitivity_2x2 = calculateSensitivity(confMat_2x2, digit);
sensitivity_8x8 = calculateSensitivity(confMat_8x8, digit);

% Display the results
fprintf('Sensitivity for digit 5 (HOG 4x4): %.2f\n', sensitivity_4x4);
fprintf('Sensitivity for digit 5 (HOG 2x2): %.2f\n', sensitivity_2x2);
fprintf('Sensitivity for digit 5 (HOG 8x8): %.2f\n', sensitivity_8x8);

% Function to calculate sensitivity for a given confusion matrix and digit
function sensitivity = calculateSensitivity(confMat, digit)
    % True Positives (TP) for the digit
    TP = confMat(digit, digit);

    % False Negatives (FN) for the digit
    FN = sum(confMat(digit, :)) - TP;

    % Calculate sensitivity
    sensitivity = TP / (TP + FN);
end
