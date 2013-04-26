/**
 *
 * @package		com.ak33m.rpc.core
 * 
 * @copyright	Akeem Philbert, Webysther Nunes
 * @license		http://opensource.org/licenses/BSD-3-Clause New BSD License
 */
package com.ak33m.rpc.core
{
	import mx.rpc.AsyncToken;
	
	/**
	 *
	 * @author	Akeem Philbert	<akeemphilbert@gmail.com>
	 */
	public interface IRPCObject
	{
		/**
		 * RPC specific implementation of a method call
		 */
		function makeCall (method : String,args : Array): AsyncToken;
		
		/**
		 * Create connection to RPC gateway
		 */
		function makeConnection ():void;
	}
}