# kotlin

```kotlin
package com.ruoyi.project.base.service.impl

@Service
open class LocationServiceImpl : ILocationService {

    companion object {
        val logger = getLogger(LocationServiceImpl::class.java)
    }


    @Autowired
    private val locationMapper: LocationMapper? = null

    /**
     * 检查是否存在地点类别相同地点
     * @return false 存在类别/地点相同的记录,不应该插入或者修改
     */
    override fun checkLocationUnique(location:Location):Boolean{
        if (location.bitType==null) {
            val count:Int = locationMapper!!.checkLocationUnique(location)
            return count==0
        }

        var unique= true
        var bitTypeTmp=1
        while (bitTypeTmp <= location.bitType) {
            logger.debug("bitTypeTmp={}",bitTypeTmp)
            val count:Int = locationMapper!!.checkLocationUnique(location)
            if(count>0){
               return false
            }
            bitTypeTmp = bitTypeTmp shl 1
        }
        return unique
    }

    /**
     * 新增地点
     *
     * @param location 地点
     * @return 结果
     */
    @Transactional
    override fun insertLocation(location: Location?): Location? {
        setGeoCode(location!!)
        if (!checkLocationUnique(location)) {
           throw MessageVirtualException("类型相同的location已存在:${location.location}")
        }
        val user = TokenUserUtils.getUser()
        BaseEntity.setCreate(location, user.userId, user.userName, DateUtils.getNowDate())
        locationMapper!!.insertLocation(location)
        return locationMapper.selectLocationById(location.locationId)
    }

    /**
     * 修改地点
     *
     * @param location 地点
     * @return 结果
     */
    @Transactional
    override fun updateLocation(location: Location?): Int {
        setGeoCode(location!!)
        if (!checkLocationUnique(location)) {
            throw MessageVirtualException("类型相同的location已存在:${location.location}")
        }
        val user = TokenUserUtils.getUser()
        BaseEntity.setUpdate(location, user.userId, user.userName, DateUtils.getNowDate())
        return locationMapper!!.updateLocation(location)
    }

}
```


## 可变参数

```kotlin
    open fun format(vararg params:Any):MessageVirtualException{
        if (this.message==null) {
            return this
        }
		//可变参数向下传递时加上 *
        this.message=StringUtils.format(super.message,*params)
        return this
    }
```

## 方法默认值
会生成多个方法,可不传有默认值的参数
```
    @JvmStatic
    @JvmOverloads
   fun sum(column: String,alias:String=column): String {
        return "ifnull(sum(${column})) as $alias"
    }
```

### 静态方法默认值
```kotlin
import org.shoukaiseki.aqoeous.builder.AqoeousBuilder.aqoeous
import org.shoukaiseki.aqoeous.builder.RelationshipBuilder.paramName
import org.shoukaiseki.aqoeous.model.CustomQO

object ChildAqoeous {


    @JvmStatic
    @JvmOverloads
    fun inventoryItemQueryObjectChild(resultName:String="item",sourceData:String="itemId"): CustomQO {
        val qo= aqoeous()
            .resultName(resultName)
            .mergeParent(true)
            .listFirstMergeParent(true)
            .relationships(
                paramName("exactQueryUniqueIdList")
                    .sourceDatas(sourceData)
            )
            .build()

        return qo
    }
}
```



## let
https://blog.csdn.net/u013064109/article/details/78786646
```
 //kotlin
 
 fun main(args: Array<String>) {
    val result = "testLet".let {
        println(it.length)
        1000
    }
    println(result)
 }
 
 //java
 
 public final class LetFunctionKt {
   public static final void main(@NotNull String[] args) {
      Intrinsics.checkParameterIsNotNull(args, "args");
      String var2 = "testLet";
      int var4 = var2.length();
      System.out.println(var4);
      int result = 1000;
      System.out.println(result);
   }
}
```
