function [result1, result2]  = chimerizer(sound1, sound2)

[env1, tfs1] = get_env_tfs(sound1);
[env2, tfs2] = get_env_tfs(sound2);
result1 = env1 .* tfs2;
result2 = env2 .* tfs1;

end