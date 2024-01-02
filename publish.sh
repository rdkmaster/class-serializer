
scriptDir=$(cd `dirname $0`; pwd)

cd $scriptDir

npm run build:clean
#npm run prettier:check
#npm run lint:check
#npm run test:ci
npm run build:es2015
npm run build:esm5
npm run build:cjs
npm run build:umd
npm run build:types
cp LICENSE build/LICENSE
cp README.md build/README.md
node -e "
  const fs = require('fs');
  const pkg = JSON.parse(fs.readFileSync('./package.json').toString());
  delete pkg.devDependencies;
  delete pkg.scripts;
  delete pkg['lint-staged'];
  fs.writeFileSync('./build/package.json', JSON.stringify(pkg, null, 2));
"
npm publish --access public ./build
