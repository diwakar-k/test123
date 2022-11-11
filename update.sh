# #!/usr/bin/env bash

# set -e -u -
# cd source-code-from-github/
# ./mvnw clean package
# cp ./target/*.jar  ../jar-file
#!/bin/sh
set -e
set -x
cd source-repo
ls .git -1
cat .git/short_ref
cd example/hello-world-springboot-helm/build
echo "Starting mvn clean validate..."
./mvnw -P=rc clean validate release-candidate:updateVersion -Drevision=`cat ../../../.git/short_ref`
VERSION=$(cat pom.xml | grep -m2  "<version>.*</version>" | tail -n1 |awk -F'[><]' '{print $3}')
echo "Starting mvn clean deploy..."
./mvnw clean deploy -Dproject.version=$VERSION
echo "mvn clean deploy has been completed!"

set -x
echo "$VERSION" >> tag_file
ls -ltr
set +x