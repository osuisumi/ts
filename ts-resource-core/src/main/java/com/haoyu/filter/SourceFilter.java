package com.haoyu.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.web.filter.authz.AuthorizationFilter;

public class SourceFilter extends AuthorizationFilter {

	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
		String retUrl = ((HttpServletRequest) request).getHeader("Referer");   
		if(retUrl != null){   
			request.setAttribute("retUrl", retUrl);
		}else{
			request.setAttribute("retUrl", "/home");
		}
		return true;
	}

}
