package com.subodh;

// Generated Jan 4, 2014 4:28:33 PM by Hibernate Tools 3.4.0.CR1

/**
 * TblRunningidMaster generated by hbm2java
 */
public class TblRunningidMaster implements java.io.Serializable {

	private String runName;
	private String runYear;
	private Integer runNos;
	private String runPreappend;

	public TblRunningidMaster() {
	}

	public TblRunningidMaster(String runName) {
		this.runName = runName;
	}

	public TblRunningidMaster(String runName, String runYear, Integer runNos,
			String runPreappend) {
		this.runName = runName;
		this.runYear = runYear;
		this.runNos = runNos;
		this.runPreappend = runPreappend;
	}

	public String getRunName() {
		return this.runName;
	}

	public void setRunName(String runName) {
		this.runName = runName;
	}

	public String getRunYear() {
		return this.runYear;
	}

	public void setRunYear(String runYear) {
		this.runYear = runYear;
	}

	public Integer getRunNos() {
		return this.runNos;
	}

	public void setRunNos(Integer runNos) {
		this.runNos = runNos;
	}

	public String getRunPreappend() {
		return this.runPreappend;
	}

	public void setRunPreappend(String runPreappend) {
		this.runPreappend = runPreappend;
	}

}
