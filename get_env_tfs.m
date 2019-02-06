function [env, tfs] = get_env_tfs(rawdata)
hilb = hilbert(rawdata);
env = abs(hilb);
tfs = rawdata ./ env;
end