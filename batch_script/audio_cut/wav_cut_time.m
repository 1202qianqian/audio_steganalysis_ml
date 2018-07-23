%% wav cut in way of time cut
% - auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path, show_info)
% - Input
% ------------------------------------------input
% audio_file_path       ������Ƶ�ļ�·��
% time_interval         �ü����ȣ�10s / 30s / 60s��
% output_files_path     �ü��ļ��洢·��
% show_info             ȷ���Ƿ��ӡ������Ϣ
% -----------------------------------------output
% audio_files_num       ��ǰ��Ƶ�ļ��ü�����Ƭ�θ���
% ���б����ĵ�λ��Ϊ�룬Ĭ��intervalΪ10s
% Fs��Frequency Sample������Ƶ�ʣ���ʾÿ����ٸ�������
% =========================================================================
% 1)auido_files_num = wav_cut_time(audio_file_path)
%   ��ȡaudio_file_path��Ӧ����Ƶ�ļ���������10sΪ��������з�
%   �и�����Ƶ������'E:\Myself\2.database\2.wav_cut\wav_10s'·���£���ӡ�з���Ϣ
%
% 2)auido_files_num = wav_cut_time(audio_file_path, time_interval)
%   ��ȡaudio_file_path��Ӧ����Ƶ�ļ��������� 'time_interval' Ϊ��������з�
%   �и�����Ƶ������"E:\Myself\2.database\2.wav_cut\wav_'time_interval's"·���£���ӡ�з���Ϣ
%
% 3)auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path)
%   ��ȡaudio_file_path��Ӧ����Ƶ�ļ��������� 'time_interval' Ϊ��������з�
%   �и�����Ƶ������"E:\Myself\2.database\2.wav_cut\wav_'time_interval's"·����
%   ��ӡ�з���Ϣ
%
% 4)auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path, show_info)
%   ��ȡaudio_file_path��Ӧ����Ƶ�ļ��������� 'time_interval' Ϊ��������з�
%   �и�����Ƶ������"E:\Myself\2.database\2.wav_cut\wav_'time_interval's"·����
%   ����show_info��ʶ��ȷ���Ƿ��ӡ�з���Ϣ

function auido_files_num = wav_cut_time(audio_file_path, time_interval, output_files_path, show_info)

% Ĭ�ϲü�ʱ��Ϊ10��
if nargin == 1
    time_interval = 10;
    output_files_path = 'E:\Myself\2.database\2.wav_cut\wav_10s';
    show_info = 'on';
end

% Ĭ�ϲü�����·��
if nargin == 2
    output_files_path = strcat('E:\Myself\2.database\2.wav_cut\wav_', num2str(time_interval), 's');
    show_info = 'on';
end

% Ĭ�ϴ�ӡ��Ϣ
if nargin == 3
    show_info = 'on';
end

audio_file_name = get_file_name(audio_file_path);                               % ��Ƶ�ļ���
[audio_stream, Fs] = audioread(audio_file_path);                                % ��ȡ��Ƶ
audio_length = length(audio_stream);                                            % ��Ƶ��������
audio_time = floor(audio_length / Fs);                                          % ��Ƶ��ʱ��
fprintf('��ǰ��Ƶ�ļ���%s\n', audio_file_name);                                  % ��ӡ��Ϣ

cut_time = 10;                                                                  % ��ȥ��ʱ��
audio_stream = audio_stream(cut_time * Fs + 1 : ...
    audio_length - cut_time * Fs, :);                                           % ��ȥǰ10��ͺ�10�룬���⾲��Ƭ��
fragments = floor((audio_time - 20) / time_interval);                           % ������зֵ�Ƭ��
auido_files_num = fragments;

if fragments < 1
    fprintf('��ǰ��Ƶ�ļ�������ɸ�interval�µ��и�...\n');
else
    start_time = 1;
    segment = time_interval * Fs;                                               % ÿ��fragment�Ĳ�������
    if strcmp(show_info, 'on') == 1
        for i = 1 : fragments
            output_stream = audio_stream(start_time + (i-1) * segment: ...
                start_time + i * segment - 1, :);                               % �����Ƶ��
            audio_name = strcat(audio_file_name, '_cut_', num2str(i), '.wav');  % �����Ƶ���ļ���
            fprintf('audio %d-th��%s\n', i, audio_name);                        % ��ӡ��Ϣ
            output_audio_file_path = fullfile(output_files_path, audio_name);   % �����Ƶ��·��
            audiowrite(output_audio_file_path, output_stream, Fs);              % ���ļ�д��
        end
        
    else
        for i = 1 : fragments
            try
                output_stream = audio_stream(start_time + (i-1) * segment: ...
                    start_time + i * segment, :);                                   % �����Ƶ��
                audio_name = strcat(audio_file_name, '_cut_', num2str(i), '.wav');  % �����Ƶ���ļ���
                output_audio_file_path = fullfile(output_files_path, audio_name);   % �����Ƶ��·��
                audiowrite(output_audio_file_path, output_stream, Fs);              % ���ļ�д��
            catch
                continue;
            end
        end
    end
fprintf('��ǰ��Ƶ��ʱ��%ds  �ü���Ƶʱ��%ds �ü���Ƶ%d��\n', ...
    audio_time, time_interval, fragments);    
end

end