# ruoyi-vue

## spring security
```
用于验证的用户信息保存 com.ruoyi.framework.web.service.UserDetailsServiceImpl
```

```java
package com.ruoyi.framework.web.service;

import com.ruoyi.wb.domain.SellerUser;
import com.ruoyi.wb.service.ISellerUserService;
import com.ruoyi.wb.domain.ConsumerUser;
import com.ruoyi.wb.service.IConsumerUserService;
import com.ruoyi.wb.token.UserTypeHolder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.enums.UserStatus;
import com.ruoyi.common.exception.BaseException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.system.service.ISysUserService;

/**
 * 用户验证处理
 * <p>
 * com.ruoyi.framework.web.service.UserDetailsServiceImpl
 * <br>
 *
 * @author shoukaiseki ブログ http://www.shoukaiseki.top/<br> E-メール jiang28555@Gmail.com<br>
 * @date 2021-02-03 12:59:43<br>
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    private static final Logger log = LoggerFactory.getLogger(UserDetailsServiceImpl.class);

    @Autowired
    private ISysUserService userService;

    @Autowired
    private SysPermissionService permissionService;

    @Autowired
    private IConsumerUserService consumerUserService;

    @Autowired
    private ISellerUserService sellerUserService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        int userType = UserTypeHolder.getUserType();
        log.debug("userType={}", userType);

        if (userType == UserTypeHolder.SYSTEM) {
            SysUser user = userService.selectUserByUserName(username);
            if (StringUtils.isNull(user)) {
                log.info("登录用户：{} 不存在.", username);
                throw new UsernameNotFoundException("登录用户：" + username + " 不存在");
            } else if (UserStatus.DELETED.getCode().equals(user.getDelFlag())) {
                log.info("登录用户：{} 已被删除.", username);
                throw new BaseException("对不起，您的账号：" + username + " 已被删除");
            } else if (UserStatus.DISABLE.getCode().equals(user.getStatus())) {
                log.info("登录用户：{} 已被停用.", username);
                throw new BaseException("对不起，您的账号：" + username + " 已停用");
            }

            return createLoginUser(user, userType);
        }

        if (userType == UserTypeHolder.CONSUMER) {
            ConsumerUser consumerUser = consumerUserService.selectConsumerUserByPhonenumber(username);
            if (StringUtils.isNull(consumerUser)) {
                log.info("手机号：{} 尚未注册.", username);
                throw new UsernameNotFoundException("手机号：" + username + " 尚未注册");
            } else if (UserStatus.DISABLE.getCode().equals(consumerUser.getStatus())) {
                log.info("手机号：{} 已被停用.", username);
                throw new BaseException("对不起，您的手机号：" + username + " 已被停用");
            } else if (Integer.parseInt(consumerUser.getStatus()) > 0) {
                log.info("手机号：帐号已被禁用.", consumerUser.getStatus());
                throw new BaseException("对不起，您的手机号：" + username + " 已被禁用");
            }
            return createConsumerLoginUser(consumerUser, userType);
        }
        if (userType == UserTypeHolder.SELLER) {
            SellerUser sellerUser = sellerUserService.selectSellerUserByPhonenumber(username);

            return createSellerLoginUser(sellerUser, userType);
        }

        throw new BaseException("无效的 userType：" + userType);
    }

    public UserDetails createLoginUser(SysUser user, int userType) {
        LoginUser loginUser = new LoginUser(user, permissionService.getMenuPermission(user));
        loginUser.setUserType(userType);
        return loginUser;
    }


    public UserDetails createConsumerLoginUser(ConsumerUser consumerUser, int userType) {
        LoginUser loginUser = new LoginUser(consumerUser);
        loginUser.setUserType(userType);
        return loginUser;
    }

    public UserDetails createSellerLoginUser(SellerUser sellerUser, int userType) {
        LoginUser loginUser = new LoginUser(sellerUser);
        loginUser.setUserType(userType);
        return loginUser;
    }
}

```
