% function gltm_scat                             Steve Mann, Nov. 1990
%
% does scatter plots of the 4 features [1 2]  [1 3]  [1 4]  [2 3]  [2 4]  [3 4]
%
% call:  gltm_scat(growler_features, features_no_growler, id_file)
%        id_file = '' saves to gltm_scat.met
%        id_file = 'run3'  saves to gltm_scat_run3.met

function dummy(g,ng,id_file)

eval(['delete gltm_scat' id_file '.met'])
disp(['deleted gltm_scat' id_file '.met   (previous meta file for scatter plots)'])

if ~isempty(id_file)
  id_file = ['_' id_file];
end%if

A = g(:,1:2);
B = ng(:,1:2);
scateasy(A,B)
title('power  and  entropy')

eval(['meta gltm_scat' id_file])

A = g(:,[1 3]);
B = ng(:,[1 3]);
scateasy(A,B)
title('power  and  extent')

eval(['meta gltm_scat' id_file])

A = g(:,[1 4]);
B = ng(:,[1 4]);
scateasy(A,B)
title('power  and  MLE')

eval(['meta gltm_scat' id_file])

A = g(:,[2 3]);
B = ng(:,[2 3]);
scateasy(A,B)
title('entropy  and  extent')

eval(['meta gltm_scat' id_file])

A = g(:,[2 4]);
B = ng(:,[2 4]);
scateasy(A,B)
title('entropy  and  MLE')

eval(['meta gltm_scat' id_file])

A = g(:,[3 4]);
B = ng(:,[3 4]);
scateasy(A,B)
title('extent  and  MLE')

eval(['meta gltm_scat' id_file])


