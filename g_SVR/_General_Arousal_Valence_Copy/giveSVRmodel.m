function model = giveSVRmodel(trainDataX, trainDatay)
    trainData.X = trainDataX;
    trainData.y = trainDatay;
    
    [trainData, trainData, junk] = scaleSVM(trainData, trainData, trainData, 0, 1); %Normalizing
    
    param.s = 3; 					% epsilon SVR
    param.C = 10.5;
    param.t = 2; 					% RBF kernel
    param.gset = 2.^[-7:7];			% range of the gamma parameter
    param.eset = [0:5];				% range of the epsilon parameter
    param.nfold = 5;				% 5-fold CV
    
    Rval = zeros(length(param.gset), length(param.eset));
    
    for i = 1:param.nfold
        data = [trainData.y, trainData.X];
        [learn, validate] = k_FoldCV_SPLIT(data, param.nfold, i);        
        learnData.X = learn(:, 2:end);
        learnData.Y = learn(:, 1);
        validateData.X = validate(:, 2:end);
        validateData.Y = validate(:, 1);

        for j = 1:length(param.gset)
            param.g = param.gset(j);
            for k = 1:length(param.eset)
                param.e = param.eset(k);
                param.libsvm = ['-s ', num2str(param.s), ' -t ', num2str(param.t),' -c ', num2str(param.C), ' -g ', num2str(param.g),' -p ', num2str(param.e)];
                
                model = svmtrain(learnData.Y, learnData.X, param.libsvm);
 
                [y_hat, Acc, projection] = svmpredict(validateData.Y, validateData.X, model); % prediction on the validation data
                Rval(j,k) = Rval(j,k) + mean((y_hat-validateData.Y).^2); %Root mean square error
            end
        end
    end
    Rval = Rval ./ (param.nfold);
    [v1, i1] = min(Rval);
    [v2, i2] = min(v1);
    optparam = param;
    optparam.g = param.gset(i1(i2));
    optparam.e = param.eset(i2);
    
    optparam.libsvm = ['-s ', num2str(optparam.s), ' -t ', num2str(optparam.t),' -c ', num2str(optparam.C), ' -g ', num2str(optparam.g),' -p ', num2str(optparam.e)];
    
    %Appropriate Parameters Detected, Model Based on optimum parameters
    model = svmtrain(trainData.y,trainData.X, optparam.libsvm); %new model defined using optimum parameters
end