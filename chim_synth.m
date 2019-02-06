function [res1, res2] = chim_synth(sound1,sound2)

N = 16;                                % Number of subbands, 4
K = 8;                                % Overlapping factor (??)
L = 2*K*N;                            % Length of analysis filters, L=2KN

[hopt,passedge] = opt_filter(L-1,N);  % Create prototype lowpass filter
[H,F] = make_bank(hopt,N);            % Generate analysis and synthesis filter banks
H = sqrt(N)*H';  F = sqrt(N)*F';      % Scaling

% not 'decimating it', by putting N=1 instead of N=8
filter_output1 = upfirdn(sound1, H, 1, 1);
filter_output2 = upfirdn(sound2, H, 1, 1);
size1 = size(filter_output1);
size2 = size(filter_output2);

if size1(1) > size2(1) % truncate first signal to match second
	filter_output1 = filter_output1(1:size2(1),:);
	
elseif size2(1) > size1(1) % truncate second signal to match first
	filter_output2 = filter_output2(1:size1(1),:);
	
end 


subband1 = filter_output1(:,1);
subband2 = filter_output2(:,1);
[res1, res2] = chimerizer(subband1, subband2);

for i = 2:N
	subband1 = filter_output1(:,i);
	subband2 = filter_output2(:,i);
	[r1, r2] = chimerizer(subband1, subband2);
	res1 = res1 + r1;
	res2 = res2 + r2;
end

end
