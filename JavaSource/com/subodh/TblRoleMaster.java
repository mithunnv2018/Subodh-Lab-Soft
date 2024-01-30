package com.subodh;

// Generated Jan 4, 2014 4:28:33 PM by Hibernate Tools 3.4.0.CR1

import java.util.HashSet;
import java.util.Set;

/**
 * TblRoleMaster generated by hbm2java
 */
public class TblRoleMaster implements java.io.Serializable {

	private String roleId;
	private String roleName;
	private String status;
	private Set<TblPartyMaster> tblPartyMasters = new HashSet<TblPartyMaster>(0);
	private Set<TblRoledetailMaster> tblRoledetailMasters = new HashSet<TblRoledetailMaster>(
			0);

	public TblRoleMaster() {
	}

	public TblRoleMaster(String roleId) {
		this.roleId = roleId;
	}

	public TblRoleMaster(String roleId, String roleName, String status,
			Set<TblPartyMaster> tblPartyMasters,
			Set<TblRoledetailMaster> tblRoledetailMasters) {
		this.roleId = roleId;
		this.roleName = roleName;
		this.status = status;
		this.tblPartyMasters = tblPartyMasters;
		this.tblRoledetailMasters = tblRoledetailMasters;
	}

	public String getRoleId() {
		return this.roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return this.roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Set<TblPartyMaster> getTblPartyMasters() {
		return this.tblPartyMasters;
	}

	public void setTblPartyMasters(Set<TblPartyMaster> tblPartyMasters) {
		this.tblPartyMasters = tblPartyMasters;
	}

	public Set<TblRoledetailMaster> getTblRoledetailMasters() {
		return this.tblRoledetailMasters;
	}

	public void setTblRoledetailMasters(
			Set<TblRoledetailMaster> tblRoledetailMasters) {
		this.tblRoledetailMasters = tblRoledetailMasters;
	}

}
