% function cltm_hist
%
% returns nothing
% call: cltm_hist(growler_features, no_growler_features, id_file)
%
% id_file specifies meta file
% id_file = ''   or  []  produces cltm_hist.met
% id_file = 'run1'  produces cltm_hist_run1.met

function dummy(g,ng,id_file) % returns nothing

if ~isempty(id_file)
  id_file = ['_' id_file];
end%if
eval(['delete meta cltm_hist' id_file '.met'])
disp(['deleted meta cltm_hist' id_file '.met    (pevious metafile if existed)'])

subplot(221)

keyboard

hist_2_things(g(:,1),ng(:,1))
xlabel('growler')
title('feature 1')
subplot(223)
hist_2_things(ng(:,1),g(:,1))
xlabel('clutter only')
hold on
subplot(121)
ylabel('histograms of "entropy" of CLT snapshots')

subplot(222)
hist_2_things(g(:,2),ng(:,2))
hist_2_things(g(:,2),ng(:,2)) % need tor repeat for some unknown reason
xlabel('growler')
title('feature 2')
subplot(224)
hist_2_things(ng(:,2),g(:,2))
xlabel('clutter only')
subplot(122)
ylabel('histograms of extents abour the mean epochs')

eval(['meta cltm_hist' id_file])
hold off
subplot

%%%%%%%%%%%%%%  SECOND HALF OF PAGE
subplot(221)
hist_2_things(g(:,3),ng(:,3))
xlabel('growler')
title('feature 3')
subplot(223)
hist_2_things(ng(:,3),g(:,3))
xlabel('clutter only')
hold on
subplot(121)
ylabel('histograms of slenderness')

eval(['meta cltm_hist' id_file])
hold off
subplot

