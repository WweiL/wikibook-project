#!/bin/bash

set -e;

git config --global core.sshCommand "ssh -i /tmp/deploy_site -F /dev/null"
git clone -b develop --depth 200 git@github.com:illinois-cs241/illinois-cs241.github.io.git ${CLONE_DIR}
git submodule update --depth 200
git submodule sync
pushd ${CLONE_DIR}
git checkout develop
pushd _wikibook_project/
git pull origin master
export DOCS_SHA=$(git rev-parse --short HEAD)
popd
git add _wikibook_project/
git commit -m "Updating docs to ${DOCS_SHA}" || true
git push origin develop

popd
