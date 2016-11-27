classdef msglogger < handle
%% classdef msglog
% 
% 
% 
% author: john devitis
% create date: 26-Nov-2016 13:54:58
% classy ver: 0.1.1

%% object properties
	properties
        name = 'Logged Loop'                        % process name
        born                                        % date time string of instance creation
        prefix = 'MSG::Process(%s)::Time(%s)::';    % configurable prefix string
        fid = 1                                     % default printing to console. provide valid fid to write to file
	end

%% dependent properties
	properties (Dependent)
	end

%% private properties
	properties (Access = private)
	end

%% constructor
	methods
		function self = msglogger(name,fid)
            % record create time and publish start
            self.born = datestr(datetime);
            % initialize w/ name if given
            if nargin > 0; self.name = name; end
            % if fileid given, notify console and log to file
            if nargin > 1; self.print('Logging to file.'); self.fid = fid; 
            end
            self.print('Main processing started.');
		end
	end

%% ordinary methods
	methods 
        function print_prefix(self)
            fprintf(self.fid,self.prefix,self.name,datestr(datetime));
        end
        
        function print(self,txt,pf,nl)
            if nargin < 3; pf = 1; end;
            if nargin < 4; nl = 1; end;
            if pf; self.print_prefix(); end;
            if nl; ftxt = '%s\n';
            else ftxt = '%s'; end
            fprintf(self.fid,sprintf(ftxt,txt));
        end
        
        function start_task(self,name,n,N)
            ftxt = 'Task(%s)::Starting::';
            % default task name if none given
            if nargin < 2; name = 'Loop Iteration'; end; 
            % if no loop numbers given, just print name
            if nargin < 3; txt = sprintf(ftxt,name);
            % if loop numbers given, print n of N tasks
            else txt = sprintf(strcat(ftxt,'\t%i\tof\t%i'),name,n,N); end
            self.print(txt,1,0);
        end
        
        function done_task(self)
            self.print('\tDone.',0,1);
        end
            
        function alivetime(self)
            tot = self.seconds_alive();
            self.print(sprintf('Alive(%4.2f seconds (%4.2f minutes))',tot,tot/60));
        end
        
        function tot = seconds_alive(self)
            tot = etime(clock,datevec(self.born));
        end
        
        function finish(self)
            self.print('Main process finished');
            self.alivetime();
            self.shutdown();
            self.print('Exiting.');
        end
        
        function shutdown(self)
            self.print('Shutting down...');
        end
        
	end % /ordinary

%% dependent methods
	methods 
	end % /dependent

%% static methods
	methods (Static)
        logg = example(N)
        logg = example2file(N)
	end % /static

%% protected methods
	methods (Access = protected)
	end % /protected

end