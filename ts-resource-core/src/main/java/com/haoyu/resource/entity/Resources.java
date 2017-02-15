package com.haoyu.resource.entity;

public class Resources extends com.haoyu.tip.resource.entity.Resources{

	private static final long serialVersionUID = -4699191525418583201L;
	
	private ResourceExtend resourceExtend = new ResourceExtend();
	
	private String isVote;

	public String getIsVote() {
		return isVote;
	}

	public void setIsVote(String isVote) {
		this.isVote = isVote;
	}

	public ResourceExtend getResourceExtend() {
		return this.resourceExtend;
	}

	public void setResourceExtend(ResourceExtend resourceExtend) {
		this.resourceExtend = resourceExtend;
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((getSummary() == null) ? 0 : getSummary().hashCode());
		result = prime * result + ((getTitle() == null) ? 0 : getTitle().hashCode());
		result = prime * result + ((getType() == null) ? 0 : getType().hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Resources other = (Resources) obj;
		if (getSummary() == null) {
			if (other.getSummary() != null)
				return false;
		} else if (!getSummary().equals(other.getSummary()))
			return false;
		if (getTitle() == null) {
			if (other.getTitle() != null)
				return false;
		} else if (!getTitle().equals(other.getTitle()))
			return false;
		if (getType() == null) {
			if (other.getType() != null)
				return false;
		} else if (!getType().equals(other.getType()))
			return false;
		return true;
	}


	
	
}
