package com.inexisconsulting.customConfig;

import java.io.IOException;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;


public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	
	protected Log logger = LogFactory.getLog(this.getClass());

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
 
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, 
      HttpServletResponse response, Authentication authentication) throws IOException {
        handle(request, response, authentication);
        clearAuthenticationAttributes(request);
    }
 
    protected void handle(HttpServletRequest request, 
      HttpServletResponse response, Authentication authentication) throws IOException {
    	String targetUrl = determineTargetUrl(authentication);

		if (response.isCommitted()) {
			logger.debug("Response has already been committed. Unable to redirect to " + targetUrl);
			return;
		}
 
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
 
    
    protected String determineTargetUrl(Authentication authentication) {
    	// initialize role variables
        boolean isUser = false;
        boolean isAdmin = false;
        boolean isCeo = false;
        boolean isHRManager = false;
        boolean isTeamLead = false;
        
        // checks the role of the logged in user matchs any specified user roles
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (GrantedAuthority grantedAuthority : authorities) {
            if (grantedAuthority.getAuthority().equals("ROLE_USER")) {
                isUser = true;
                break;
            } else if (grantedAuthority.getAuthority().equals("ROLE_ADMIN")) {
                isAdmin = true;
                break;
            } else if (grantedAuthority.getAuthority().equals("ROLE_CEO")) {
            	isCeo = true;
                break;
            } else if (grantedAuthority.getAuthority().equals("ROLE_HR")) {
            	isHRManager = true;
                break;
            } else if (grantedAuthority.getAuthority().equals("ROLE_LEAD")) {
            	isTeamLead = true;
                break;
            }
        }
        
        // if a match is found redirect to the given address path
        if (isUser) {
            return "/user-main-menu";
        } else if (isAdmin) {
            return "/admin-main-menu";
        } else if (isCeo) {
            return "/ceo-main-menu";
        } else if (isHRManager) {
            return "/hr-main-menu";
        } else if (isTeamLead) {
            return "/lead-main-menu";
        }
          else {
        	 // else throw an exception
            throw new IllegalStateException();
        }
    }
 
    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }
 
    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }
    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }

}
