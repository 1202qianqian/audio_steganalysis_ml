%% Get the best parameters of 
function [bestacc,best_t,bestc,bestg] = get_best_params(cover_feature,stego_feature,percent, t_flag)

data = [cover_feature;stego_feature];
cover_label = zeros(size(cover_feature,1),1);
stego_label = ones(size(stego_feature,1),1);
label = [cover_label;stego_label];

number = size(data,1);                                                      % ��������
dimension = size(data,2);                                                   % ����ά��
temp = [data, label];
temp = shuffle(temp);

train_set_number = floor(percent * number);                                 % ѵ������С
train_data = temp(1:train_set_number, 1:dimension);                         % ѵ����
train_label = temp(1:train_set_number, dimension + 1);                      % ѵ������ǩ
[bestacc,best_t,bestc,bestg] = SVM(train_label, train_data, -10, 10, -5, 5, 3, 1, 1, t_flag);