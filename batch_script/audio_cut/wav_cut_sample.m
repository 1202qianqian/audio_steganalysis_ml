%% wav��Ƶ�ü��ű�(ʵ�ֶ����׸����ĵȼ���з�)
% - auido_files_num = wav_cut_sample(audio_file_path, sample_interval, output_files_path, show_info)
% - ����˵����
% ------------------------------------------input
% audio_file_path       ������Ƶ�ļ�·��
% sample_interval       �ü����ȣ�16000�������㣩
% output_files_path     �ü��ļ��洢·��
% show_info             ȷ���Ƿ��ӡ������Ϣ
% -----------------------------------------output
% audio_files_num       ��ǰ��Ƶ�ļ��ü�����Ƭ�θ���
% =========================================================================
% 1)auido_files_num = wav_cut_time(audio_file_path)
%   ��ȡaudio_file_path��Ӧ����Ƶ�ļ���������1600��������Ϊ��������з�
%   �и�����Ƶ������'E:\Myself\2.database\2.wav_cut\wav_16000'·���£���ӡ�з���Ϣ
%
% 2)auido_files_num = wav_cut_time(audio_file_path, time_interval)
%   ��ȡaudio_file_path��Ӧ����Ƶ�ļ��������� 'sample_interval' Ϊ��������з�
%   �и�����Ƶ������"E:\Myself\2.database\2.wav_cut\wav_'sample_interval'"·���£���ӡ�з���Ϣ
%
% 3)auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path)
%   ��ȡaudio_file_path��Ӧ����Ƶ�ļ��������� 'sample_interval' Ϊ��������з�
%   �и�����Ƶ������"E:\Myself\2.database\2.wav_cut\wav_'sample_interval'"·����
%   ��ӡ�з���Ϣ
%
% 4)auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path, show_info)
%   ��ȡaudio_file_path��Ӧ����Ƶ�ļ��������� 'sample_interval' Ϊ��������з�
%   �и�����Ƶ������"E:\Myself\2.database\2.wav_cut\wav_'sample_interval'"·����
%   ����show_info��ʶ��ȷ���Ƿ��ӡ�з���Ϣ

function auido_files_num = wav_cut_sample(audio_file_path, sample_interval, output_files_path, show_info)

% Ĭ�ϲü�ʱ��Ϊ10��
if nargin == 1
    sample_interval = 16000;
    output_files_path = 'E:\Myself\2.database\2.wav_cut\wav_16000';
    show_info = 'on';
end

% Ĭ�ϲü�����·��
if nargin == 2
    output_files_path = strcat('E:\Myself\2.database\2.wav_cut\wav_', num2str(sample_interval));
    show_info = 'on';
end

% Ĭ�ϴ�ӡ��Ϣ
if nargin == 3
    show_info = 'on';
end

audio_file_name = get_file_name(audio_file_path);                               % ��Ƶ�ļ���
[audio_stream, Fs] = audioread(audio_file_path);                                % ��ȡ��Ƶ
audio_length = length(audio_stream);                                            % ��Ƶ��������
fprintf('��ǰ��Ƶ�ļ���%s\n', audio_file_name);                                  % ��ӡ��Ϣ
cut_samples = Fs * 10;                                                          % ��ȥǰ���Fs*10�������㣬������ֶ��������0

audio_stream = audio_stream(cut_samples + 1 : audio_length - cut_samples, :);
audio_length = length(audio_stream);
fragments = floor(audio_length / sample_interval);                              % ������зֵ�Ƭ��
auido_files_num = fragments;

if fragments < 1
    fprintf('��Ƶ�ļ����̣���������и�...\n');
else
    start_location = 1;
    if strcmp(show_info, 'on') == 1
        for i = 1 : fragments
            output_stream = audio_stream(start_location + (i-1) * sample_interval : ...
                start_location + i * sample_interval - 1, :);                   % �����Ƶ��
            audio_name = strcat(audio_file_name, '_cut_', num2str(i), '.wav');  % �����Ƶ���ļ���
            fprintf('audio %d-th��%s\n', i, audio_name);                        % ��ӡ��Ϣ
            output_audio_file_path = fullfile(output_files_path, audio_name);   % �����Ƶ��·��
            audiowrite(output_audio_file_path, output_stream, Fs);              % ���ļ�д��
        end
        
    else
        for i = 1 : fragments
            output_stream = audio_stream(start_location + (i-1) * sample_interval: ...
                start_location + i * sample_interval - 1, :);                   % �����Ƶ��
            audio_name = strcat(audio_file_name, '_cut_', num2str(i), '.wav');  % �����Ƶ���ļ���
            output_audio_file_path = fullfile(output_files_path, audio_name);   % �����Ƶ��·��
            audiowrite(output_audio_file_path, output_stream, Fs);              % ���ļ�д��
        end
    end
    
end

fprintf('��ǰ��Ƶ�ܲ�������%ds  �ü���Ƶ��������%ds �ü���Ƶ%d��\n', ...
    audio_length, sample_interval, fragments);
end