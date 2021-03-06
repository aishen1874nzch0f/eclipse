package com.base.shiro;

/**
 * 系统数据状态，对应数据表中的status字段
 *  
 * @author xpg
 * DELETED:删除：
 * NORMAL：正常
 * NOT_ENABLED:未激活
 * LOCKED：锁定
 */
public enum Status {

	DELETED(-1), NORMAL(0), NOT_ENABLED(1), LOCKED(2);

	private int status;

	Status(int status) {
		this.status = status;
	}

	/**
	 * DELETED(-1), NORMAL(0), NOT_ENABLED(1), LOCKED(2);
	 * 
	 * @return
	 */
	public int getStatus() {
		return status;
	}
}
