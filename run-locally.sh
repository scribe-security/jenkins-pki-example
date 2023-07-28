
rm -rf dist/ node_modules/ tracker/processes.json tracker/events.json fs-tracker-logs.tar.xz

docker run -d \
          --privileged \
          --pid host \
          --userns=host \
          --name fs-tracker \
          -v /proc:/proc \
          -v /etc/passwd:/etc/passwd \
          -v $PWD/tracker:/tracker \
          -w /tracker \
          scribesecuriy.jfrog.io/scribe-docker-public-local/fs-tracker \
          -f jsonl


sleep 5

echo $'\e[1;33m'START$'\e[0m'

npm install
npm run build

echo $'\e[1;33m'END$'\e[0m'

docker stop fs-tracker

tar -cJf fs-tracker-logs.tar.xz -C tracker processes.json events.json

