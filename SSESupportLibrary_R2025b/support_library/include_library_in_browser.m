% include_library_in_browser.m
%
% Copyright (C) 2025, The MathWorks, Inc.
%
% This script installs ee_lib_for_power_systems in the library browser.
%

mdl = 'ee_lib_for_power_systems';

open_system(mdl)

set_param(mdl,'Lock','off')

set_param(mdl,'EnableLBRepository','on')

save_system(mdl)

close_system(mdl)

addpath(genpath(pwd))

savepath

% open library browser, right-click and select 'refresh' for library to
% appear

