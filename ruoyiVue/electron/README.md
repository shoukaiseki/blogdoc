# electron

## main.js 引入外部js

### main.js
```js
const {currentVersion} = require('./baseVersion');

const {getCoreUrlOrUpgradePackUrl} =require('./wbElectron')


```
### baseVersion.js
```
'use strict'
//增量版本号,
const {coreVersion} = require("./coreVersion");

const baseVersion=1004

// const currentVersion=(coreVersion*1000000)+baseVersion
module.exports={
    currentVersion: (coreVersion*1000000)+baseVersion
}
```
### coreVersion.js
```
'use strict'
/**
 * (1[内核版本号]).(1.1[增量版本号])
 * coreVersion  内核版本号 1-999
 * baseVersion  增量版本号  1-999999
 * 最后版本号为  内核版本号 * 1000_000 +增量版本号
 * @type {number}
 */

module.exports={
    coreVersion: 1
}

```


### wbElectron.js
方法
```
'use strict'
 function  getCoreUrlOrUpgradePackUrl(currentVersionNumber,versionData){
	 
        console.log("getCoreUrlOrUpgradePackUrl.currentVersionNumber",currentVersionNumber,versionData)
        let coreVersionNum = Number(versionData.versionNum);
        let upgradePackVersionNum = Number(versionData.upgradePackVersionNum);
        //判断内核版本,如果最后一个内核版本大于当前版本,则优先更新内核
        if (parseInt(coreVersionNum/1000000) > parseInt(currentVersionNumber/1000000)) {
            return versionData.url
        }
        if (upgradePackVersionNum > currentVersionNumber) {
            return versionData.upgradePackUrl
        }
        return undefined
    }
module.exports={
	getCoreUrlOrUpgradePackUrl: getCoreUrlOrUpgradePackUrl
}
```