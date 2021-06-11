# swagger


### 
```

    /**
     * 新增发布任务
     */
    //@PreAuthorize("@ss.hasPermi('wb010:RequestTaskOrder:add')")
    @ApiOperation(value = "新增互助请求",response= RequestTaskOrder.class,notes = "")
    @RepeatSubmit
    @Log(title = "发布任务", businessType = BusinessType.INSERT)
    @PostMapping("/add")
    public AjaxResult add(@RequestBody AppAddRequestTaskOrderAO appAddRequestTaskOrderAO)
    {

        AjaxResult ajaxResult = verificationUser();
        if (ajaxResult !=null) {
            return ajaxResult;
        }

        RequestTaskOrder requestTaskOrder=new RequestTaskOrder();
        BeanUtils.copyProperties(appAddRequestTaskOrderAO,requestTaskOrder);

        SysUser user = TokenUserUtils.getUser();
        UserInfo userInfo = userInfoService.selectUserInfoById(user.getUserId());
        requestTaskOrder.setUserId(user.getUserId());
        requestTaskOrder.setTiktokAccount(userInfo.getTiktokAccount());
        requestTaskOrder.setTiktokNickName(userInfo.getTiktokNickName());

        requestTaskOrder.setVirtualReturnType(2);
        RequestTaskOrder data = (RequestTaskOrder)requestTaskOrderService.insertRequestTaskOrder(requestTaskOrder);
//        try{
//            requestTaskOrderService.handleEnable(data.getRequestTaskOrderId());
//        }catch (Exception e){
//            return AjaxResult.error(e.getMessage(),data);
//        }
        return AjaxResult.successData(data);
    }



```

### AO类
```
package com.ruoyi.project.wb010.app.domain.ao;

import com.alibaba.fastjson.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.project.wb010.domain.RequestTaskOrderLine;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.apache.ibatis.type.Alias;

import java.util.Date;
import java.util.List;

/**
 * ApiModel 中的 value 名称保持唯一,不能与其它名称重复,否则 @RequestBody 中显示的属性不正确
 *
 **/
@ApiModel(value = "新增发布任务")
@JsonIgnoreProperties(ignoreUnknown = true)
public class AppAddRequestTaskOrderAO {

    @ApiModelProperty(value = "选择的任务",notes = "选中的 taskConfId")
    private List<RequestTaskOrderLine> requestTaskOrderLineList;

    /** 发布数量 */
    @ApiModelProperty(value = "发布数量")
    private Long planQuantity;


    /** 开播时间 */
    @ApiModelProperty(value = "开播时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date plannedStartTime;

    /** 结束时间 */
    @ApiModelProperty(value = "结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JSONField(format="yyyy-MM-dd HH:mm:ss")
    private Date plannedEndTime;


    public Long getPlanQuantity() {
        return planQuantity;
    }

    public void setPlanQuantity(Long planQuantity) {
        this.planQuantity = planQuantity;
    }

    public Date getPlannedStartTime() {
        return plannedStartTime;
    }

    public void setPlannedStartTime(Date plannedStartTime) {
        this.plannedStartTime = plannedStartTime;
    }

    public Date getPlannedEndTime() {
        return plannedEndTime;
    }

    public void setPlannedEndTime(Date plannedEndTime) {
        this.plannedEndTime = plannedEndTime;
    }

    public List<RequestTaskOrderLine> getRequestTaskOrderLineList() {
        return requestTaskOrderLineList;
    }

    public void setRequestTaskOrderLineList(List<RequestTaskOrderLine> requestTaskOrderLineList) {
        this.requestTaskOrderLineList = requestTaskOrderLineList;
    }
}

```
