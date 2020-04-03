% scales real 3dim matrix, which has been stored as a block row
% leaves first col intact
%
% scales GLTM, multi glt file, on 0 to 65536 range, leaving first col intact
%
% call:   scaler_gltm(CLTM_b9825,levels_per_pixel); % levels.. defaults to 65536
%
% calls:  scaler2

function GLTM = dummy(GLTM, levels_per_pixel)
if nargin < 2
  levels_per_pixel = 65536;  % default
end%if
info = GLTM(:,1);
D = info(1);
L = info(2);
M = info(3);
N = info(4);

GLTM = scaler2(GLTM(:,2:L*N+1),levels_per_pixel);

GLTM = [info GLTM];   % replace first col

