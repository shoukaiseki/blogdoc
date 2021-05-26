# java

## maven
```xml
    <properties>
<!--        <kotlin.version>1.2.71</kotlin.version>-->
        <kotlin.version>1.5.0</kotlin.version>

        <java.version>11</java.version>
        <jdk.version>11</jdk.version>
        <maven.compiler.source>11</maven.compiler.source>
        <maven.compiler.target>11</maven.compiler.target>
    </properties>
```

##问题
### IDEA2021.1启动SpringBoot项目出现java程序包:xxx不存在
https://blog.csdn.net/lzzdhhhh/article/details/105907772




## 排序

```java
  //重新排序
    @Override
    public void resetSortOrderByList(List<ProductionOrder> productionOrderList){
        ProductionOrder previousNode=null;
        List<ProductionOrder> updateList=new ArrayList<>();
        for (ProductionOrder productionOrder : productionOrderList) {
            String id = productionOrder.getId();
            productionOrder.setNextNodeId("");
            productionOrder.setPreviousNodeId("");
            if(previousNode!=null){
               previousNode.setNextNodeId(id);
                productionOrder.setPreviousNodeId(previousNode.getId());
            }
            previousNode=productionOrder;
            updateList.add(productionOrder);
        }

        for (ProductionOrder productionOrder : updateList) {
            ProductionOrder productionOrderTmp = get(productionOrder.getId());
            productionOrderTmp.setNextNodeId(productionOrder.getNextNodeId());
            productionOrderTmp.setPreviousNodeId(productionOrder.getPreviousNodeId());
            productionOrderTmp.setSortOrder(productionOrder.getSortOrder());
            update(productionOrderTmp);
        }

    }
```
