git submodule update --init --recursive
git submodule foreach --recursive "git checkout main && git pull"
