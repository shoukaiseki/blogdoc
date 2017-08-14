# maximo发送工作流反应慢  

发送工作流之后如果有任务分配节点,反应慢

原因:任务分配中涉及到邮箱,请检查sendmail字段

处理方案:mxe.smtp.password,mxe.smtp.user 系统属性为发件人邮箱,MXServer.setMailAuth()
```Java
public static MXServer.SmtpAuthenticator getMailAuth() {
        return mailAuth;
    }

    void setMailAuth() {
        String user = this.getProperty("mxe.smtp.user");
        String pswd = this.getProperty("mxe.smtp.password");
        if(user != null && user.length() > 0) {
            mailAuth = new MXServer.SmtpAuthenticator(user, pswd);
        } else {
            mailAuth = null;
        }

    }
```
以及与mail相关的系统属性配置

发送邮箱的配置信息为 psdi.common.emailstner.EmailListnerTask .readMessagesFromMailServer

```Java
    public void readMessagesFromMailServer(InboundCommCfgData cfgData, MboRemote inboundCommCfgMbo) {
        Folder folder = null;
        Store store = null;
        Session session = null;

        try {
            Properties prop = MXServer.getMXServer().getConfig();
            prop.put("mail.pop3.connectiontimeout", "300000");
            prop.put("mail.pop3.timeout", "300000");
            prop.put("mail.imap.connectiontimeout", "300000");
            prop.put("mail.imap.timeout", "300000");
            prop.put("mail.smtp.connectiontimeout", "300000");
            prop.put("mail.smtp.timeout", "300000");
            if(cfgData.isStartTls()) {
                prop.put("mail." + cfgData.getProtocol() + ".starttls.enable", Boolean.valueOf(cfgData.isStartTls()));
            }

            if(this.getLogger().isDebugEnabled()) {
                Enumeration dbe = prop.propertyNames();

                while(dbe.hasMoreElements()) {
                    String propName = (String)dbe.nextElement();
                    if(propName.startsWith("mail")) {
                        this.getLogger().debug("prop: " + propName + " = " + prop.get(propName));
                    }
                }
            }

            session = Session.getDefaultInstance(prop, MXServer.getMailAuth());
            URLName url = new URLName(cfgData.getProtocol(), cfgData.getMailServerName(), cfgData.getPort(), "INBOX", cfgData.getUserName(), cfgData.getEmailPassword());
            store = session.getStore(url);
            store.connect();
            folder = store.getFolder(cfgData.getFolder());
            folder.open(2);
            Object[] paramConn = new Object[]{cfgData.getMailServerName(), cfgData.getEmailAddress()};
            this.getLogger().info(Resolver.getResolver().getMessage("emaillstner", "connectionok").getMessage(paramConn));
            LinkedHashSet<Message> messageSet = new LinkedHashSet();
            int i;
            Message m;
            if(!cfgData.getProtocol().equalsIgnoreCase("pop3") && !cfgData.getProtocol().equalsIgnoreCase("pop3s")) {
                Message[] unreadMessages = folder.search(new FlagTerm(new Flags(Flag.SEEN), false));
                if(unreadMessages != null) {
                    for(i = 0; i < unreadMessages.length; ++i) {
                        m = unreadMessages[i];
                        if(m != null) {
                            messageSet.add(m);
                        }
                    }

                    if(this.getLogger().isDebugEnabled()) {
                        this.getLogger().debug("EmailListenerTask: email address " + cfgData.getEmailAddress() + " number of mails for IMAP " + unreadMessages.length);
                    }
                }
            } else {
                int totalMessages = folder.getMessageCount();

                for(i = 1; i <= totalMessages; ++i) {
                    m = folder.getMessage(i);
                    if(m != null) {
                        messageSet.add(m);
                    }
                }

                if(this.getLogger().isDebugEnabled()) {
                    this.getLogger().debug("EmailListenerTask: email address " + cfgData.getEmailAddress() + " number of mails for POP3 " + totalMessages);
                }
            }

            Iterator itr = messageSet.iterator();

            while(itr.hasNext()) {
                MboRemote inboundComm = null;

                try {
                    m = (Message)itr.next();
                    boolean newMail = false;
                    if(!cfgData.getProtocol().equalsIgnoreCase("pop3") && !cfgData.getProtocol().equalsIgnoreCase("pop3s")) {
                        newMail = true;
                    } else {
                        String mailId = ((POP3Folder)folder).getUID(m);
                        newMail = this.isNewMail(mailId, cfgData.getEmailAddress(), inboundCommCfgMbo.getUserInfo());
                    }

                    if(!newMail) {
                        if(cfgData.isEmailDeletion()) {
                            this.deleteMailAfterAgeThreshold(m, cfgData.getAgeThreshold(), cfgData.getAgeUOM(), cfgData.getEmailAddress());
                        }
                    } else {
                        if(this.getLogger().isDebugEnabled()) {
                            this.getLogger().debug("EmailListenerTask: email address " + cfgData.getEmailAddress() + " new mail with subject " + m.getSubject());
                        }

                        if(m instanceof MimeMessage) {
                            Enumeration e = ((MimeMessage)m).getAllHeaderLines();

                            while(e.hasMoreElements()) {
                                String header = (String)e.nextElement();
                                if(this.getLogger().isDebugEnabled()) {
                                    this.getLogger().debug("*********readMessagesFromMailServer  header: " + header);
                                }
                            }
                        }

                        MailData md = this.getMailData(m, cfgData, inboundCommCfgMbo);
                        if(md.getFrom() != null && md.getFrom().trim().length() != 0) {
                            MboRemote personMbo = this.getPersonMbo(md.getFrom(), inboundCommCfgMbo);
                            UserInfo realUserInfo = null;
                            UserInfo inbcommUserInfo = null;
                            if(personMbo == null) {
                                md.setPersonId(this.runAsUserInfo.getPersonId());
                            } else {
                                md.setPersonId(personMbo.getString("personid"));
                                realUserInfo = this.getUserInfoForPersonIfUserExist(personMbo.getString("personid"));
                            }

                            if(realUserInfo == null) {
                                inbcommUserInfo = this.runAsUserInfo;
                            } else {
                                inbcommUserInfo = realUserInfo;
                            }

                            md.setInbCommUserInfo(inbcommUserInfo);
                            inboundComm = this.writeIntoInboundComm(md, cfgData, inboundCommCfgMbo, m);
                            if(cfgData.isEmailDeletion()) {
                                this.deleteMailAfterAgeThreshold(m, cfgData.getAgeThreshold(), cfgData.getAgeUOM(), cfgData.getEmailAddress());
                            } else {
                                m.setFlag(Flag.SEEN, true);
                            }

                            boolean personValidate = true;
                            String personValidateStr = MXServer.getMXServer().getProperty("mxe.lsnr.validateperson");
                            if(personValidateStr != null && personValidateStr.trim().length() > 0) {
                                personValidate = MXServer.getMXServer().getProperty("mxe.lsnr.validateperson").equals("1");
                            }

                            if(personValidate && personMbo == null) {
                                Object[] params = new Object[]{md.getFrom(), cfgData.getEmailAddress(), cfgData.getMailServerName()};
                                String errorStr = Resolver.getResolver().getMessage("emaillstner", "personerror").getMessage(params);
                                String[] attrArray = new String[]{"status", "error"};
                                String[] keyArray = new String[]{"ERROR", errorStr};
                                inboundComm = LSNRUtil.updateInboundComm(attrArray, keyArray, inboundComm);
                                if(this.getLogger().isErrorEnabled()) {
                                    this.getLogger().error(errorStr);
                                }

                                LSNRUtil.sendEmail(inboundComm, (String)null, "LSNRNOPER", (Throwable)null);
                            } else {
                                String invalidStatus = ((Mbo)inboundComm).getTranslator().toInternalString("EMAILSTATUS", inboundComm.getString("STATUS"));
                                if(invalidStatus.equalsIgnoreCase("INVALID")) {
                                    LSNRUtil.sendEmail(inboundComm, (String)null, "LSNRINVM", (Throwable)null);
                                } else {
                                    try {
                                        this.processNewStatusMail(inboundComm);
                                    } catch (Exception var24) {
                                        LSNRUtil.handleErrorException(var24, cfgData.getAdminEmail(), inboundComm);
                                    }
                                }
                            }
                        } else {
                            if(cfgData.isEmailDeletion()) {
                                this.deleteMailAfterAgeThreshold(m, cfgData.getAgeThreshold(), cfgData.getAgeUOM(), cfgData.getEmailAddress());
                            } else {
                                m.setFlag(Flag.SEEN, true);
                            }

                            if(this.getLogger().isErrorEnabled()) {
                                Object[] params = new Object[]{md.getSubject(), cfgData.getEmailAddress(), cfgData.getMailServerName()};
                                this.getLogger().error(Resolver.getResolver().getMessage("emaillstner", "getfromnull").getMessage(params));
                            }
                        }
                    }
                } catch (Exception var26) {
                    LSNRUtil.handleErrorException(var26, cfgData.getAdminEmail(), inboundComm);
                }
            }

            if(folder.isOpen()) {
                folder.close(true);
            }

            if(store != null) {
                store.close();
            }
        } catch (Exception var27) {
            Exception e = var27;

            try {
                if(folder != null && folder.isOpen()) {
                    folder.close(true);
                }

                if(store != null) {
                    store.close();
                }

                if(folder == null) {
                    LSNRUtil.sendEmail(inboundCommCfgMbo, (String)null, "LSNRCONNF", e);
                }
            } catch (Exception var25) {
                if(this.getLogger().isErrorEnabled()) {
                    this.getLogger().error(Resolver.getResolver().getMessage("emaillstner", "closemailserver").getMessage(), var25);
                }
            }

            if(this.getLogger().isErrorEnabled()) {
                this.getLogger().error(Resolver.getResolver().getMessage("emaillstner", "processfail").getMessage(), var27);
            }
        }

    }
```
