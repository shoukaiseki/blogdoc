# ruoyi-bootsrap



### shiro免密码验证
shiro类 UserRealm 继承与 AuthorizingRealm
#### AppUserController
``` 
    @Anon
    @PostMapping("/app/captchaLogin")
    @ResponseBody
    public AjaxResult captchaLogin(@RequestParam("phonenum") String phonenum, HttpServletRequest request)
    {
        captchaValidateService.validate();
        User user = userService.selectUserByLoginName(phonenum);

        if(user==null){
            user=new User();
            user.setPassword(")&w*b@]2^#");
            user.setLoginName(phonenum);
            user.setPhonenumber(phonenum);
            user.setDeptId(101L);
            user.setVipFlag("1");
            if (UserConstants.USER_NAME_NOT_UNIQUE.equals(userService.checkLoginNameUnique(user.getLoginName())))
            {
                return error("新增用户'" + user.getLoginName() + "'失败，手机号码已存在!");
            }
            else if (StringUtils.isNotEmpty(user.getPhonenumber())
                    && UserConstants.USER_PHONE_NOT_UNIQUE.equals(userService.checkPhoneUnique(user)))
            {
                return error("新增用户'" + user.getLoginName() + "'失败，手机号码已存在..");
            }
            user = assUserInfoService.registerVipUser(user);
//            user = userService.selectUserByLoginName(phonenum);

        }
        AjaxResult ajaxResult = addShiro(user, request);
        return ajaxResult;
//        String jSessionId = request.getRequestedSessionId();
//        AjaxResult ajaxResult = AjaxResult.success();
//        ajaxResult.put("user",user);
//        ajaxResult.put("jSessionId",jSessionId);
//        return ajaxResult;
    }

    public AjaxResult addShiro(User user, HttpServletRequest request){
        //密码验证时会使用该语句查询
//        user = userService.selectUserByLoginName(user.getLoginName());
        UserLoginTypeHolder.set(UserLoginTypeHolder.CAPTCHA_LOGIN);
        UsernamePasswordToken token = new UsernamePasswordToken(user.getLoginName(),user.getPassword(), true);
        Subject subject = SecurityUtils.getSubject();
        try
        {
            subject.login(token);
            User sysUser = ShiroUtils.getSysUser();
            String jSessionId = request.getRequestedSessionId();
            AjaxResult ajaxResult = AjaxResult.success(sysUser);
            ajaxResult.put("jSessionId",jSessionId);
            appUserSessionService.saveAppUserToSession(sysUser);


            assUserInfoService.ifNoAssUserInfoThenAdd();
            ajaxResult.put("user",sysUser);

            return ajaxResult;
        }
        catch (AuthenticationException e)
        {
            logger.debug("",e);
            String msg = "用户或密码错误";
            if (StringUtils.isNotEmpty(e.getMessage()))
            {
                msg = e.getMessage();
            }
            return error(msg);
        }
    }

```
#### LoginService
```
    /**
     * 登录
     */
    public User login(String username, String password)
    {
        /**
         * 忽略密码验证,在验证码登录时使用
         */
        if (UserLoginTypeHolder.getUserLoginType()!=1) {
            // 查询用户信息
            User user = userService.selectUserByLoginName(username);
//            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success")));
            recordLoginInfo(user);
            return user;
        }
        // 验证码校验
        if (ShiroConstants.CAPTCHA_ERROR.equals(ServletUtils.getRequest().getAttribute(ShiroConstants.CURRENT_CAPTCHA)))
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.jcaptcha.error")));
            throw new CaptchaException();
        }
        // 用户名或密码为空 错误
        if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password))
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("not.null")));
            throw new UserNotExistsException();
        }
        // 密码如果不在指定范围内 错误
        if (password.length() < UserConstants.PASSWORD_MIN_LENGTH
                || password.length() > UserConstants.PASSWORD_MAX_LENGTH)
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
            throw new UserPasswordNotMatchException();
        }

        // 用户名不在指定范围内 错误
        if (username.length() < UserConstants.USERNAME_MIN_LENGTH
                || username.length() > UserConstants.USERNAME_MAX_LENGTH)
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.not.match")));
            throw new UserPasswordNotMatchException();
        }

        // 查询用户信息
        User user = userService.selectUserByLoginName(username);

        /** 
        if (user == null && maybeMobilePhoneNumber(username))
        {
            user = userService.selectUserByPhoneNumber(username);
        }

        if (user == null && maybeEmail(username))
        {
            user = userService.selectUserByEmail(username);
        }
        */

        if (user == null)
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.not.exists")));
            throw new UserNotExistsException();
        }
        
        if (UserStatus.DELETED.getCode().equals(user.getDelFlag()))
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.password.delete")));
            throw new UserDeleteException();
        }
        
        if (UserStatus.DISABLE.getCode().equals(user.getStatus()))
        {
            AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_FAIL, MessageUtils.message("user.blocked", user.getRemark())));
            throw new UserBlockedException();
        }

        passwordService.validate(user, password);
        AsyncManager.me().execute(AsyncFactory.recordLogininfor(username, Constants.LOGIN_SUCCESS, MessageUtils.message("user.login.success")));
        recordLoginInfo(user);
        return user;
    }

```

```
package com.ruoyi.project.wb.app.utils;

/**
 *
 **/

public class UserLoginTypeHolder {

    /**
     * 密码登录
     */
    public static final int PASSWORD_LOGIN = 1;

    /**
     * 验证码登录
     */
    public static final int CAPTCHA_LOGIN = 2;

    private static ThreadLocal<Integer> userLoginTypeInThread = new ThreadLocal<>();


    public static Integer get() {
        return userLoginTypeInThread.get();
    }


    public static void set(Integer userType) {
        userLoginTypeInThread.set(userType);
    }

    public static void remove() {
        userLoginTypeInThread.remove();
    }


    /**
     * 获取登录类型
     *
     * @return
     */
    public static int getUserLoginType() {
        Integer userLoginType = get();
        return userLoginType == null ? PASSWORD_LOGIN : userLoginType;
    }

}

```
