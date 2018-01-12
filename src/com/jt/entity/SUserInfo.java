package com.jt.entity;

import java.sql.Timestamp;

/**
 * Description: SUserInfo
 * Author: curd generator
 * Create: 2016-02-18 11:06
 */
public class SUserInfo {
	private String userId;
	private String userName;
	private String userCode;
	private String password;
	private String companyId;
	private String companyName;
	private String departmentName;
	private String positionName;
	private String mobile;
	private String email;
	private String lastLoginTime;
	private String lastLoginIp;
	private String pyUser;
	private Integer openType;
	private Integer status;
	private Integer isExtendRight;
	private String createTime;
	private String createUser;
	private String updateTime;
	private String updateUser;

	public String getUserId(){
        return this.userId;
    }

    public void setUserId(String userId){
        this.userId = userId;
    }

	public String getUserName(){
        return this.userName;
    }

    public void setUserName(String userName){
        this.userName = userName;
    }

	public String getUserCode(){
        return this.userCode;
    }

    public void setUserCode(String userCode){
        this.userCode = userCode;
    }

	public String getPassword(){
        return this.password;
    }

    public void setPassword(String password){
        this.password = password;
    }

	public String getCompanyId(){
        return this.companyId;
    }

    public void setCompanyId(String companyId){
        this.companyId = companyId;
    }

	public String getCompanyName(){
        return this.companyName;
    }

    public void setCompanyName(String companyName){
        this.companyName = companyName;
    }

	public String getDepartmentName(){
        return this.departmentName;
    }

    public void setDepartmentName(String departmentName){
        this.departmentName = departmentName;
    }

	public String getPositionName(){
        return this.positionName;
    }

    public void setPositionName(String positionName){
        this.positionName = positionName;
    }

	public String getMobile(){
        return this.mobile;
    }

    public void setMobile(String mobile){
        this.mobile = mobile;
    }

	public String getEmail(){
        return this.email;
    }

    public void setEmail(String email){
        this.email = email;
    }

	public String getLastLoginTime(){
        return this.lastLoginTime;
    }

    public void setLastLoginTime(String lastLoginTime){
        this.lastLoginTime = lastLoginTime;
    }

	public String getLastLoginIp(){
        return this.lastLoginIp;
    }

    public void setLastLoginIp(String lastLoginIp){
        this.lastLoginIp = lastLoginIp;
    }

	public String getPyUser(){
        return this.pyUser;
    }

    public void setPyUser(String pyUser){
        this.pyUser = pyUser;
    }

	public Integer getOpenType(){
        return this.openType;
    }

    public void setOpenType(Integer openType){
        this.openType = openType;
    }

	public Integer getStatus(){
        return this.status;
    }

    public void setStatus(Integer status){
        this.status = status;
    }

	public Integer getIsExtendRight(){
        return this.isExtendRight;
    }

    public void setIsExtendRight(Integer isExtendRight){
        this.isExtendRight = isExtendRight;
    }

	public String getCreateTime(){
        return this.createTime;
    }

    public void setCreateTime(String createTime){
        this.createTime = createTime;
    }

	public String getCreateUser(){
        return this.createUser;
    }

    public void setCreateUser(String createUser){
        this.createUser = createUser;
    }

	public String getUpdateTime(){
        return this.updateTime;
    }

    public void setUpdateTime(String updateTime){
        this.updateTime = updateTime;
    }

	public String getUpdateUser(){
        return this.updateUser;
    }

    public void setUpdateUser(String updateUser){
        this.updateUser = updateUser;
    }

}