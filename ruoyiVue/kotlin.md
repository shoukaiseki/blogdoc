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
