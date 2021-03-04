package com.etc.listener;



import java.util.HashMap;
import java.util.Map;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

import com.etc.entity.Users;





/**
 * Application Lifecycle Listener implementation class LoginLisntener
 *
 */
@WebListener
public class LoginListener implements HttpSessionAttributeListener {

	// 存放用户相关的sesession对象,key为用户名,value为用户对象
    private Map<String, HttpSession> map = new HashMap<String, HttpSession>();
	
    /**
     * @see HttpSessionAttributeListener#attributeAdded(HttpSessionBindingEvent)
     */
    public void attributeAdded(HttpSessionBindingEvent arg0)  { 
    
    	String name = arg0.getName();//key
    	if (name.equals("user")) {
			
    		Users userinfo = (Users) arg0.getValue();//value其实就是用户对象
    		
    		if (map.containsKey(userinfo.getUserName())) {
    			
				HttpSession session = map.get(userinfo.getUserName());
				System.out.println("用户：" + userinfo.getUserName() + "将被迫下线！");
				session.removeAttribute(name);
				session.setAttribute("msg", "您的账户已在其他浏览器登录，你被迫下线！");
			}
    		map.put(userinfo.getUserName(), arg0.getSession());
		}
    }

	/**
     * @see HttpSessionAttributeListener#attributeRemoved(HttpSessionBindingEvent)
     */
    public void attributeRemoved(HttpSessionBindingEvent arg0)  { 
         //删除属性前调用
    	String name = arg0.getName();
    	if (name.equals("user")) {
    		Users userinfo = (Users) arg0.getValue();
    		map.remove(userinfo.getUserName());
    		System.out.println("用户：" + userinfo + "已注销");
    	}
    }

	/**
     * @see HttpSessionAttributeListener#attributeReplaced(HttpSessionBindingEvent)
     */
    public void attributeReplaced(HttpSessionBindingEvent arg0)  { 
    }
	
}

