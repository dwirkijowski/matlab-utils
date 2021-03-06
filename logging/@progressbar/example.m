function example(N)
%% Command line progressbar demo
%
% author: john devitis
% create date: 11272016
clc

% Number of iterations (in seconds).
if nargin<1; N = 50; end
fprintf('Message Log Example:\n\n\n');

% Create instance of Timerwaitbar.
pbar = progressbar(N,'A long running task...');

% Do work.
for n = 1:N
    pause(.1);      % Work.
    pbar.update(n); % Show progress. 
end

% Notify complete.
pbar.done()         