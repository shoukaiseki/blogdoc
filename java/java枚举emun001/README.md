# java枚举emun001

```Java
public enum Color 
{
       
     Red, White, Blue;   
       
    public static void main(String arg[])
 {   
         Color myColor = Color.Red;   
         System.out.println(myColor);   
           
        for(Color color : Color.values())
  {   
             System.out.println(color);   
         }   
     }   
}  
```
