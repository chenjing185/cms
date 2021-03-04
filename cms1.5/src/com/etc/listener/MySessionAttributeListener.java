package com.etc.listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;

/**
 * Application Lifecycle Listener implementation class MySessionAttributeListener
 *
 */
/*@WebListener*/
public class MySessionAttributeListener implements HttpSessionAttributeListener {

    /**
     * Default constructor. 
     */
    public MySessionAttributeListener() {
        // TODO Auto-generated constructor stub
    }

	/**
     * @see HttpSessionAttributeListener#attributeAdded(HttpSessionBindingEvent)
     */
    public void attributeAdded(HttpSessionBindingEvent arg0)  { 
         System.out.println("增加属性");
         //getName获取属性的key
         String name = arg0.getName();
         System.out.println(name);
         
         //getValue获取属性的值
         Object value = arg0.getValue();
         System.out.println(value);
         
         //通过name得到value
         HttpSession session = arg0.getSession();
         System.out.println("session:"+session.getAttribute(name));  
    }

	/**
     * @see HttpSessionAttributeListener#attributeRemoved(HttpSessionBindingEvent)
     */
    public void attributeRemoved(HttpSessionBindingEvent arg0)  { 
         System.out.println("移除属性");
    }

	/**
     * @see HttpSessionAttributeListener#attributeReplaced(HttpSessionBindingEvent)
     */
    public void attributeReplaced(HttpSessionBindingEvent arg0)  { 
       System.out.println("修改属性");
    }
	
}
