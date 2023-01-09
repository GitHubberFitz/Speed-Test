#!/bin/bash
TDate=$(date +%m-%d-%Y)
RelPath=$(dirname "$0")
HostIP=$(ip -4 addr show eth0 | grep -oP "(?<=inet ).*(?=/)")

if [[ -f "${RelPath}/ost/index.html" ]]; then
    OSTver=$(grep -o -P '(?<=OpenSpeedTest.com V).*(?=Loaded)' ${RelPath}/ost/index.html | tr -d " ")
    echo "Current version #-"$OSTver"-#"
else
    ### Clone OpenSpeedTest
    git clone https://github.com/openspeedtest/Speed-Test.git ${RelPath}/temp

    ### Move the files we only need
    mkdir ${RelPath}/ost/
    mv -f ${RelPath}/temp/index.html ${RelPath}/ost/index.html
    mv -f ${RelPath}/temp/hosted.html ${RelPath}/ost/hosted.html
    mv -f ${RelPath}/temp/downloading ${RelPath}/ost/downloading
    mv -f ${RelPath}/temp/upload ${RelPath}/ost/upload
    mv -f ${RelPath}/temp/License.md ${RelPath}/ost/License.md
    mv -f ${RelPath}/temp/assets ${RelPath}/ost/assets
    rm -r ${RelPath}/temp/
fi

if [[ ! -f "${RelPath}/ost/10G-S.gif" ]]; then
    wget https://github.com/openspeedtest/v2-Test/raw/main/images/10G-S.gif -P ${RelPath}/ost/ #2>/dev/null
fi

read -p "Clone fresh Repo? (default n)[y/n]: " Response
if [[ $Response =~ ^[Yy]$ ]]; then
    ### Clone OpenSpeedTest
    git clone https://github.com/openspeedtest/Speed-Test.git ${RelPath}/temp

    ### Move the files we only need
    mv -f ${RelPath}/temp/index.html ${RelPath}/ost/index.html
    mv -f ${RelPath}/temp/hosted.html ${RelPath}/ost/hosted.html
    mv -f ${RelPath}/temp/downloading ${RelPath}/ost/downloading
    mv -f ${RelPath}/temp/upload ${RelPath}/ost/upload
    mv -f ${RelPath}/temp/License.md ${RelPath}/ost/License.md
    mv -f ${RelPath}/temp/assets ${RelPath}/ost/assets
    rm -r ${RelPath}/temp/
fi

### Extracting Version number
## Example: "OpenSpeedTest.com V2.5.4 Loaded" via index.html
OSTver=$(grep -o -P '(?<=OpenSpeedTest.com V).*(?=Loaded)' ${RelPath}/ost/index.html | tr -d " ")
echo "### Verify version varible correctly grabbed in between #-Number-#"
echo ""
echo "#-"$OSTver"-#"
echo ""
read -p "Version displayed correctly? (default n)[y/n]: " Response
if [[ ! $Response =~ ^[Yy]$ ]]; then
    echo "Aborted"
    exit 1
fi

### Build docker image
docker build -t fitzdockerhub/openspeedtest:${OSTver} \
    --build-arg BUILD_DATE="${TDate}" \
    --build-arg OpenSpeedTest_VERSION="${OSTver}" \
${RelPath}

### Check Run
docker run --rm -d \
    --name test-openspeedtest \
    -p 83:80 \
fitzdockerhub/openspeedtest:${OSTver}
### Pause before server check
sleep 1
ServCheck=$(curl ${HostIP}:83 -s | grep "<title>")

### Verify check
if [[ ! "$ServCheck" == *"Speed Test by OpenSpeedTest.com"* ]]; then
    echo "String not found or Server not running"
    echo "#-"ServCheck"-#"
    exit 1
else
    echo "Success - WebServer successfully responded"
    docker stop test-openspeedtest 2>/dev/null
fi

### Add Proper Tags
docker tag fitzdockerhub/openspeedtest:${OSTver} fitzdockerhub/openspeedtest:latest
### Deploy
docker push fitzdockerhub/openspeedtest:${OSTver}
docker push fitzdockerhub/openspeedtest:latest


## Ignore my notes
echo "*.txt" > .gitignore

### Commit files to GitHub
#git init
git add .
git commit -m "$OSTver"
git branch -M main
git remote add origin ssh://git@github.com/GitHubberFitz/Speed-Test.git
git push -u origin main