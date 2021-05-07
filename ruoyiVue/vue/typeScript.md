# typeScript
https://zhuanlan.zhihu.com/p/87830309

TypeScript 中的命名参数、可选参数、默认参数

```
export function  jumpProductionOrderSell(uniqueId,{newTab=false}={}){
    const url='/editPurchaseOrder/'+uniqueId

    if(newTab){
        let routeUrl = this.$router.resolve({
            path: url,
        })
        window.open(routeUrl.href, '_blank')
        return
    }

    this.$router.push( url)
}

```
