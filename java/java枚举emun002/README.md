# java枚举emun002

```Java
public class emun001 
{   
  
    public static void doOp(OpConstant opConstant) 
{   
        switch (opConstant)
{   
        case TURN_LEFT:   
             System.out.println("向左转");   
            break;   
        case TURN_RIGHT:   
             System.out.println("向右转");   
            break;   
        case SHOOT:   
             System.out.println("射击");   
            break;   
         }   
     }   
  
    public static void main(String[] args) {   
         doOp(OpConstant.SHOOT);   
     }   
}   
  
enum OpConstant {   
     TURN_LEFT, TURN_RIGHT, SHOOT   
}  
```
