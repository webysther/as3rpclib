/**
 *
 * @package		com.ak33m.rpc.xmlrpc
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.xmlrpc 
{
	
	import com.ak33m.rpc.xmlrpc.IXMLRPCStruct;
	
	/**
	 *
	 * @author	Webysther Nunes <webysther@gmail.com>
	 */
	public class XMLRPCStruct extends Array implements IXMLRPCStruct 
	{
		/**
		 * 
		 */		
		private var props:Array = new Array() ;
		
		/**
		 * 
		 * @param key
		 * @param value
		 * 
		 */		
		public function XMLRPCStruct( key:String = null , value:* = null ) : void
		{
			super(); 
			if ( key != null && value != null ) {
				this.add( key , value );
			}
		}
		
		/**
		 * 
		 * @param key
		 * @param value
		 * 
		 */		
		public function add( key:String , value:* ):void 
		{
			props[key] = value;
		}
		
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function getPropertyData():* 
		{
			return props;
		}
	}
}