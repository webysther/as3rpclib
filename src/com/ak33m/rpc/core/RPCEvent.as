/**
 *
 * @package		com.ak33m.rpc.core
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.core
{
	import flash.events.Event;
	
	/** 
	 * This event is dispatcher from a RPCResponder. 
	 */
	public class RPCEvent extends Event
	{
		/**
		 * 
		 */		
		public static const EVENT_RESULT:String = "onRPCResult";
		
		/**
		 * 
		 */		
		public static const EVENT_FAULT:String = "onRPCFault";
		
		/**
		 * 
		 */		
		public static const EVENT_CANCEL:String = "onRPCCancel";
		
		/**
		 * 
		 */		
		public var data:*;
		
		/**
		 * 
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * @param data
		 * 
		 */		
		public function RPCEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,data:*=null)
		{
			//TODO: implement function
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
	}
}