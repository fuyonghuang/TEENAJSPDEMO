package com.jt.entity;

import java.sql.Timestamp;

/**
 * Description: SUserRolePO
 * Author: curd generator
 * Create: 2016-02-18 11:06
 */
public class SUserRolePO {
	private String userId;
	private String roleId;

	public String getUserId(){
        return this.userId;
    }

    public void setUserId(String userId){
        this.userId = userId;
    }

	public String getRoleId(){
        return this.roleId;
    }

    public void setRoleId(String roleId){
        this.roleId = roleId;
    }

}